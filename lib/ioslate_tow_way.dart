import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isolate_flutter/icon_rotate.dart';
import 'package:toast/toast.dart';

class IsolateTowWayPage extends StatefulWidget {
  IsolateTowWayPage({Key key}) : super(key: key);
  @override
  _IsolateTowWayPageState createState() => _IsolateTowWayPageState();
}

class _IsolateTowWayPageState extends State<IsolateTowWayPage> {
  static void taskRunner(SendPort sendPort) {
    //new isolate
    ReceivePort receivePort = ReceivePort();
    receivePort.listen((message) {
      print("$message");
    });
    int sum = 0;
    for (int i = 0; i < 999999; i++) {
      sum += i;
    }
    sendPort.send([sum, receivePort.sendPort]);
  }

  void createNewIosolate() {
    //main isolate
    ReceivePort receivePort = ReceivePort();
    Isolate.spawn(taskRunner, receivePort.sendPort);
    receivePort.listen((message) {
      Toast.show(message.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      if (message[1] is SendPort) {
        message[1].send("From Main Isolate");
      }
    });
  }

  static int calulate(int number) {
    int temp = 0;
    for (int i = 0; i < number; i++) {
      temp += i;
    }
    return temp;
  }

  Future<void> demoCompute() async {
    var result = await compute(calulate, 9999999);
    Toast.show(result.toString(), context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Isolate Two Way"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              child: IconFlutterRotate(),
            ),
            FlatButton(
                color: Colors.green,
                onPressed: () {
                  // createNewIosolate();
                  demoCompute();
                },
                child: Text("Click"))
          ],
        ),
      ),
    );
  }
}

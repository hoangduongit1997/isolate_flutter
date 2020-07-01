import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:isolate_flutter/icon_rotate.dart';
import 'package:toast/toast.dart';

class IsolateOneWayPage extends StatefulWidget {
  IsolateOneWayPage({Key key}) : super(key: key);

  @override
  _IsolateOneWayPageState createState() => _IsolateOneWayPageState();
}

class _IsolateOneWayPageState extends State<IsolateOneWayPage> {
  static void taskRunner(SendPort sendPort) {
    //new isolate
    int sum = 0;
    for (int i = 0; i < 999999; i++) {
      sum += i;
    }
    sendPort.send(sum);
  }

  void createNewIosolate() {
    //main isolate
    ReceivePort receivePort = ReceivePort();
    Isolate.spawn(taskRunner, receivePort.sendPort);
    receivePort.listen((message) {
      Toast.show(message.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Isolate One Way"),
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
                  createNewIosolate();
                },
                child: Text("Click"))
          ],
        ),
      ),
    );
  }
}

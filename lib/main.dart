import 'package:flutter/material.dart';
import 'package:isolate_flutter/ioslate_one_way.dart';
import 'package:isolate_flutter/ioslate_tow_way.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Demo Isolate'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Demo compute in isolate two way"),
            FlatButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => IsolateOneWayPage()));
                },
                child: Text("Isolate one way")),
            FlatButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => IsolateTowWayPage()));
                },
                child: Text("Isolate two way"))
          ],
        ),
      ),
    );
  }
}

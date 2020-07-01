import 'package:flutter/material.dart';

class IconFlutterRotate extends StatefulWidget {
  IconFlutterRotate({Key key}) : super(key: key);

  @override
  _IconFlutterRotateState createState() => _IconFlutterRotateState();
}

class _IconFlutterRotateState extends State<IconFlutterRotate>
    with SingleTickerProviderStateMixin<IconFlutterRotate> {
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      alignment: Alignment.center,
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: FlutterLogo(),
    );
  }
}

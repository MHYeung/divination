import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class WindMill extends StatefulWidget {
  @override
  _WindMillState createState() => _WindMillState();
}

class _WindMillState extends State<WindMill>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = Tween<double>(begin: 0, end: 300).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

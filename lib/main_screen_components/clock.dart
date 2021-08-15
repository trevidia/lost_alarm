import 'package:flutter/material.dart';

class ClockTimer extends StatefulWidget {
  const ClockTimer({Key? key}) : super(key: key);

  @override
  _ClockTimerState createState() => _ClockTimerState();
}

class _ClockTimerState extends State<ClockTimer> {
  @override
  Widget build(BuildContext context) {
    // todo implement animation of clock
    return Image.asset("assets/Pics/Clock.jpg");
  }
}

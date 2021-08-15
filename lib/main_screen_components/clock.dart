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
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width - 200,
      height: 300,
      child: Row(
        children: [
          Container(
            child: Text("23"),
          )
        ],
      ),
    );
  }
}

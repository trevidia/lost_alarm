import 'package:flutter/material.dart';
import 'package:lost_alarm/main_screen_components/lost_clock_components/lost_timer.dart';
import 'package:lost_alarm/main_screen_components/terminal_screen.dart';
import 'package:provider/provider.dart';

class LostClock extends StatefulWidget {
  const LostClock({Key? key}) : super(key: key);

  @override
  _LostClockState createState() => _LostClockState();
}

class _LostClockState extends State<LostClock> {
  bool isRunning = false;
  int value1 = 0;
  int value2 = 0;
  int value3 = 0;
  int value4 = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      child: LostTimer(
          shouldCount: Provider.of<Command>(context, listen: true).isRunning,
          value1: Provider.of<Command>(context, listen: true).value1,
          value2: Provider.of<Command>(context, listen: true).value2,
          value3: Provider.of<Command>(context, listen: true).value3,
          value4: Provider.of<Command>(context, listen: true).value4),
    );
  }
}

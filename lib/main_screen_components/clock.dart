import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lost_alarm/logic_designs/clock.dart';
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
  int value5 = 0;
  int value6 = 0;

  @override
  void initState() {
    // TODO: implement initState
    isRunning = ClockPreferences.getIsRunning() ?? false;
    // startCount(this.context);



    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    Provider.of<Command>(context).onStartup();
    return Container(
      padding: EdgeInsets.all(8),
      child: Consumer<Command>(

        builder: (BuildContext context, value, Widget? child) {
          // Timer.periodic(Duration(seconds: ), (timer) {
          //   value.onStartup();
          //   timer.cancel();
          // });
          return LostTimer(
            shouldCount: value.isRunning,
            value1: value.value1,
            value3: value.value3,
            value2: value.value2,
            value4: value.value4,
            value5: value.value5,
            value6: value.value6,
          );
        },
        // child: LostTimer(
        //   shouldCount: Provider.of<Command>(context, listen: true).isRunning,
        //   value1: Provider.of<Command>(context, listen: true).value1,
        //   value2: Provider.of<Command>(context, listen: true).value2,
        //   value3: Provider.of<Command>(context, listen: true).value3,
        //   value4: Provider.of<Command>(context, listen: true).value4,
        //   value5: Provider.of<Command>(context, listen: true).value5,
        //   value6: Provider.of<Command>(context, listen: true).value6,
        // ),
      ),
    );
  }
}

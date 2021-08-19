import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

class ClockTimer extends StatefulWidget {
  const ClockTimer({Key? key}) : super(key: key);

  @override
  _ClockTimerState createState() => _ClockTimerState();
}

class _ClockTimerState extends State<ClockTimer>
    with SingleTickerProviderStateMixin {
  TextEditingController time = TextEditingController();
  late AnimationController _controller;
  late Animation _time;
  int? countTime;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 70),
    );
    _time = CurveTween(curve: Curves.linear).animate(_controller);

    _controller.addListener(() {
      setState(() {
        // print(DateTime.now());
        countTime = (countTime! - 1);
      });
    });

    super.initState();
  }

  decrement() {
    print("hi");
    setState(() {
      // print(DateTime.now());
      countTime = (countTime! - 1);
    });
  }

  int alarmId = 1;

  @override
  Widget build(BuildContext context) {
    print(_time.value * 70);
    // todo implement animation of clock
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          color: Color.fromRGBO(253, 255, 252, 1),
          width: MediaQuery.of(context).size.width - 100,
          height: 300,
          child: Row(
            children: [
              Center(
                child: Container(
                  height: 200,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(206, 212, 218, 1)),
                  child: Center(child: Text("$countTime")),
                ),
              )
            ],
          ),
        ),
        Container(
          width: 300,
          height: 200,
          child: Column(
            children: [
              TextFormField(controller: time),
              ElevatedButton(
                  onPressed: () {
                    AndroidAlarmManager.oneShot(
                      Duration(seconds: 2),
                      alarmId,
                      decrement,
                      exact: true,
                    );
                    setState(() {
                      countTime = int.parse(time.value.text);
                    });

                    // _controller.forward();
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      ],
    );
  }
}

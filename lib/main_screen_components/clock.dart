import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ClockTimer extends StatefulWidget {
  const ClockTimer({Key? key}) : super(key: key);

  @override
  _ClockTimerState createState() => _ClockTimerState();
}

class _ClockTimerState extends State<ClockTimer>
    with SingleTickerProviderStateMixin {
  TextEditingController time = TextEditingController();
  late AnimationController _controller;
  late Animation flip;
  int countTime = 0;
  int second = 0;
  List numbers = [0, 0, 0];
  List seconds = [0, 0];
  bool isRunning = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 70),
    );
    // _time = CurveTween(curve: Curves.linear).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  reduceTimeMinutes(Timer timer) {
    if (countTime > 0) {
      setState(() {
        countTime = (countTime - 1);
        // numbers = countTime.toString().split("");
        // numbers = [...countTime.toString().split("")];
      });
    } else {
      timer.cancel();
      setState(() {
        isRunning = false;
      });
    }

    // print(countTime);
    // print(second);
  }

  reduceTimeSec() {
    setState(() {
      second = second - 1;
    });
  }

  setMinutes() {
    switch (countTime.toString().length) {
      case 3:
        setState(() {
          numbers = countTime.toString().split('');
        });
        break;
      case 2:
        setState(() {
          numbers = [0, ...countTime.toString().split('')];
        });

        break;
      case 1:
        setState(() {
          numbers = [0, 0, ...countTime.toString().split('')];
        });
        break;
      default:
        numbers = [0, 0, 0];
    }
  }

  // reduceMinutes() {
  //   Timer.periodic(Duration(minutes: 1), (timer) {
  //     if (countTime > 0) {
  //       timeAlarm();
  //     } else {
  //       timer.cancel();
  //     }
  //   });
  // }
  setSeconds() {
    setState(() {
      seconds = second.toString().split('').length < 2
          ? [0, ...second.toString().split('')]
          : second.toString().split('');
    });
  }

  timeAlarm() {
    if (isRunning == false) {
      setState(() {
        isRunning = true;
      });
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (second > 0) {
          reduceTimeSec();
          setSeconds();
          // print(countTime);
          print(second);
          // print(timer.tick);
        } else if (second == 0) {
          setState(() {
            second = 59;
            setSeconds();
          });
          reduceTimeMinutes(timer);
          setMinutes();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 5;
    // todo implement animation of clock
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          color: Color.fromRGBO(253, 255, 252, 1),
          width: MediaQuery.of(context).size.width - 100,
          height: 300,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ...numbers.map((e) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: 200,
                  width: size,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(206, 212, 218, 1)),
                  child: Center(
                      child: Text("$e",
                          style: TextStyle(
                            fontSize: size / 1.5,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Helvetica",
                            fontStyle: FontStyle.normal,
                          ))),
                ),
              );
            }).toList(),
            SizedBox(
              width: 20,
            ),
            ...seconds.map((e) {
              return Expanded(
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(360 / 180 * pi),
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 200,
                    width: size,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(206, 212, 218, 1)),
                    child: Center(
                        child: Text(
                      "$e",
                      style: TextStyle(
                          fontSize: size / 1.5, fontFamily: "Helvetica"),
                    )),
                  ),
                ),
              );
            }).toList()
          ]),
        ),
        TextFormField(controller: time),
        ElevatedButton(
            onPressed: () {
              // print(time.text);
              if (isRunning == false) {
                setState(() {
                  countTime = int.parse(time.value.text) - 1;
                  second = 60 - 1;
                });
                setMinutes();
                setSeconds();
                timeAlarm();
              }

              // _controller.forward();
            },
            child: Text("Submit")),
      ],
    );
  }
}

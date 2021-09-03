import 'dart:async';
import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_alarm/logic_designs/worker.dart';

import 'alarm.dart';

class Tester extends StatefulWidget {
  const Tester({Key? key}) : super(key: key);

  @override
  _TesterState createState() => _TesterState();
}

class _TesterState extends State<Tester> {
  int id = Isolate.current.hashCode;
  // late Alarm alarm;

  @override
  void initState() {
    super.initState();

    // alarm = Alarm(time: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("I make notifications by clicking the below button"),
          ElevatedButton(
              onPressed: () {
                print('$id is the button isolate id');
                // AndroidAlarmManager.oneShotAt(time, id, callback)
                // controlIsolate();
                // alarm.start();
                AndroidAlarmManager.oneShot(
                    Duration(minutes: 1), 29, startAlarm,
                    exact: true, wakeup: true, alarmClock: true);
              },
              child: Text("Click Me")),
          ElevatedButton(
              onPressed: () {
                // Isolate.resolvePackageUri(packageUri)
                // AudioPlayerTask.onStop();
                // alarm.stop();
                AndroidAlarmManager.oneShot(Duration.zero, 29, stopAlarm,
                    exact: true, alarmClock: true);
              },
              child: Text("hey click to stop")),
        ]),
      ),
    );
  }
}

stopAlarm() {
  AudioPlayerTask.shouldCancelVibration = false;
  AudioPlayerTask.onStop();
}

startAlarm() async {
  AudioPlayerTask.init();
  AudioPlayerTask.onPlay();
  AudioPlayerTask.vibrate();
}


// controlIsolate() async {
//   ReceivePort receivePort = ReceivePort();
//   Isolate uche = await Isolate.spawn(fish, receivePort.sendPort);
// }


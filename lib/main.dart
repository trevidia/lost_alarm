import 'package:flutter/material.dart';
import 'package:lost_alarm/main_screen_components/clock.dart';
import 'package:lost_alarm/main_screen_components/keyboard.dart';
import 'package:lost_alarm/screens/main_screen.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await AndroidAlarmManager.initialize();
  runApp(LostAlarm());
}

void printer() {
  print("hi");
}

class LostAlarm extends StatelessWidget {
  const LostAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lost Alarm",
      theme: ThemeData(canvasColor: Color.fromRGBO(33, 37, 41, 1)),
      home: Scaffold(
        // body: Terminal(),
        body: ClockTimer(),
      ),
    );
  }
}

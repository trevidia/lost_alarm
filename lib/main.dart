import 'package:flutter/material.dart';
import 'package:lost_alarm/screens/main_screen.dart';

void main(){
  runApp(LostAlarm());
}

class LostAlarm extends StatelessWidget {
  const LostAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lost Alarm",
      home: Scaffold(
        body: Terminal(),
      ),
    );
  }
}

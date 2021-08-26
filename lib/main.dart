import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_alarm/main_screen_components/terminal_screen.dart';
import 'package:lost_alarm/screens/main_screen.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
        body: ChangeNotifierProvider(
            create: (context) => Command(), child: Terminal()),
      ),
    );
  }
}

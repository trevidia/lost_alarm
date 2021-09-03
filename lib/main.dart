import 'package:audio_service/audio_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_alarm/logic_designs/clock.dart';
import 'package:lost_alarm/logic_designs/test.dart';
import 'package:lost_alarm/main_screen_components/terminal_screen.dart';
import 'package:lost_alarm/screens/main_screen.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // makes the app not to rotate
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  AwesomeNotifications().initialize('resource://mipmap/splash_launcher', [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: "Basic Notifications",
      defaultColor: Colors.black54,
      importance: NotificationImportance.High,
      enableVibration: true,
      playSound: true,
    )
  ]);

  await AndroidAlarmManager.initialize();
  // Shared preference
  // for the clock saving logic
  // initialization
  await ClockPreferences.init();

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
      home: AudioServiceWidget(
        child: Scaffold(
          // body: Terminal(),
          body: ChangeNotifierProvider(
              create: (context) => Command(), child: Tester()),
          // child: Terminal()
        ),
      ),
    );
  }
}

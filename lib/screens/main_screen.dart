import 'dart:async';
import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:lost_alarm/main_screen_components/clock.dart';
import 'package:lost_alarm/main_screen_components/keyboard.dart';
import 'package:lost_alarm/main_screen_components/terminal_screen.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class Terminal extends StatefulWidget {
  const Terminal({Key? key}) : super(key: key);

  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {

  @override
  void initState(){
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      print("done");
    });
    print("${DateTime.now().weekday} is now");
    Timer.periodic(Duration(minutes: 1), (timer) {
      // FlutterRingtonePlayer.play(
      //
      //   volume: 1,
      //   looping: true, android: AndroidSounds.alarm,
      // );
      // AndroidAlarmManager.oneShot(Duration(minutes: 1), 7, ringAlarm);
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: Random().nextInt(30),
              channelKey: 'basic_channel',
              title: 'Simple Notification',
              body: 'Your alarm is ready',
            locked: true
          ),

        schedule: NotificationCalendar(
          weekday: 1,
          hour: 21,
          minute: 19,
          second: 0,
          millisecond: 0,
          repeats: false
        ),
        actionButtons: [
          NotificationActionButton(
            key: "Alarm_stopper",
            label: "Stop Alarm"
          )
        ]
      );
      timer.cancel();
    });
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      print("this is isAllowed\'s answer $isAllowed");
      if (!isAllowed) {
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Allow Notifications'),
            content: Text("Our App would love to send you notifications"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Don't allow"), ),
              TextButton(onPressed: (){
                AwesomeNotifications().requestPermissionToSendNotifications()
                    .then((_) => Navigator.pop(context));
              }, child: Text("Allow"),)
            ],
          );
        });
        print("this is isAllowed\'s answer $isAllowed");
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience


      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //Todo [Alarm] implementation to prevent users from quiting
        return Future.value(true);
      },
      child: SafeArea(
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/Pics/Background.jpg"))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                color: Color.fromRGBO(107, 112, 92, 1),
                height: MediaQuery.of(context).size.height / 5,
                width: (MediaQuery.of(context).size.width / 2) + 100,
                child: LostClock(),
              ),
              SizedBox(
                height: 50,
              ),
              CommandDisplay(),
              OnKeyBoard()
            ],
          ),
        ),
      ),
    );
  }
}

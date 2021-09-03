import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lost_alarm/logic_designs/alarm.dart';
import 'package:lost_alarm/logic_designs/clock.dart';
import 'package:lost_alarm/main.dart';
import 'package:provider/provider.dart';

class CommandDisplay extends StatefulWidget {
  const CommandDisplay({Key? key}) : super(key: key);

  @override
  _CommandDisplayState createState() => _CommandDisplayState();
}

class _CommandDisplayState extends State<CommandDisplay>
    with SingleTickerProviderStateMixin {
  late bool hasLoaded;
  late AnimationController control;
  Color beeper = Colors.greenAccent;
  @override
  void initState() {
    control =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    control.repeat(reverse: true);
    control.addListener(() {});
    control.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() {
          beeper = Colors.greenAccent;
        });
      } else {
        setState(() {
          beeper = Colors.transparent;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String command = Provider.of<Command>(context, listen: true)._command;
    return Stack(children: [
      Image.asset(
        "assets/Pics/PC-min.png",
      ),
      Positioned(
        top: MediaQuery.of(context).size.height / 15,
        left: MediaQuery.of(context).size.width / 6,
        child: Container(
          width: 250,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "lost_alarm \$>: $command",
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 10,
                    fontFamily: "Helvetica"),
              ),
              Container(
                width: 6,
                height: 12,
                color: beeper,
              )
            ],
          ),
        ),
      )
    ]);
  }
}

var count = 0;
var running = false;

ringAlarm() async {
  final AudioPlayer player = AudioPlayer();
  await player.setAsset('assets/Sound/Alarm/Alarm.wav');
  await player.setLoopMode(LoopMode.all);
  player.play();
}

class Command extends ChangeNotifier {
  List<String> _words = [];
  String _command = "";
  int _time = 0;
  int day = 0;
  int hours = 0;
  int seconds = 59;
  bool isRunning = ClockPreferences.getIsRunning() ?? false;
  bool secIsRunning = false;
  int value1 = 0;
  int value2 = 0;
  int value3 = 0;
  int value4 = 0;
  int value5 = 0;
  int value6 = 0;
  int alarmId = 1;
  bool backgroundHasLoaded = false;
  bool keyBoardLoaded = false;
  bool terminalScreenLoaded = false;
  bool startUp = false;

  bool checkIfAllLoaded() {
    if (backgroundHasLoaded && terminalScreenLoaded) {
      return true;
    } else {
      return false;
    }
  }

  Command() {
    isRunning = ClockPreferences.getIsRunning() ?? false;
    if (isRunning) {
      onStartup();
    }
  }

  setTime(DateTime now, int timeInput) {
    if (now.hour < timeInput) {
      _time = ((timeInput - now.hour) * 60) - now.minute - 1;
    } else {
      _time = ((23 - now.hour + timeInput) * 60) + 60 - now.minute - 1;
    }
    return _time;
  }

  setTimeSec() {
    changeToInt(String e) => int.parse(e);
    List values = seconds.toString().split('');
    switch (seconds.toString().length) {
      case 2:
        value5 = changeToInt(values[0]);
        value6 = changeToInt(values[1]);
        break;
      case 1:
        value5 = 0;
        value6 = changeToInt(values[0]);
        break;
    }
    notifyListeners();
  }

  alarmCaller() async {
    AndroidAlarmManager.oneShot(Duration(minutes: 3), alarmId, ringAlarm,
        wakeup: true, rescheduleOnReboot: true);
  }

  changeTimeMinute() async {
    _setClockTime(_time);
    Timer.periodic(Duration(minutes: 1), (timer) async {
      if (isRunning) {
        if (_time != 0) {
          _time = _time - 1;
          _setClockTime(_time);
        } else {
          isRunning = false;
          await ClockPreferences.setIsRunning(false);
          timer.cancel();
          notifyListeners();
        }
      }
    });
  }

  _changeTimeSeconds() {
    Timer.run(() {
      setTimeSec();
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (isRunning) {
          seconds -= 1;

          if (seconds == -1) {
            seconds = 59;
          }
          setTimeSec();
        }
      });
    });
    //   setTimeSec();
    // if (secIsRunning == false){
    //   setSec();
    //   secIsRunning = true;
    // }
  }

  _setClockTime(int time) {
    changeToInt(String e) => int.parse(e);
    List values = time.toString().split('');
    switch (time.toString().length) {
      case 4:
        value1 = changeToInt(values[0]);
        value2 = changeToInt(values[1]);
        value3 = changeToInt(values[2]);
        value4 = changeToInt(values[3]);
        break;
      case 3:
        value1 = 0;
        value2 = changeToInt(values[0]);
        value3 = changeToInt(values[1]);
        value4 = changeToInt(values[2]);
        break;
      case 2:
        value1 = 0;
        value2 = 0;
        value3 = changeToInt(values[0]);
        value4 = changeToInt(values[1]);
        break;
      case 1:
        value1 = 0;
        value2 = 0;
        value3 = 0;
        value4 = changeToInt(values[0]);
        break;
    }
    notifyListeners();
  }

  errorCodes(String error) {
    _command = error;
    notifyListeners();
    Timer.periodic(Duration(seconds: 2), (timer) {
      _command = "";
      notifyListeners();
      timer.cancel();
    });
  }

  onStartup() {
    if (startUp == false) {
      startUp = true;
      if (isRunning) {
        DateTime? timeAWSet = ClockPreferences.getTAWSet();
        DateTime now = DateTime.now();
        int? timeInput = ClockPreferences.getTimeSet();
        var duration1 = setTime(timeAWSet!, timeInput!);
        var duration2 = setTime(now, timeInput);
        print("duration2 is $duration2");
        print("timeInput is $timeInput");
        print("timeset is $timeAWSet");
        if (duration2 < ClockPreferences.getDuration()) {
          print("timeInput is $timeInput");
          setTime(now, timeInput);
          _setClockTime(_time);
          changeTimeMinute();
          _changeTimeSeconds();
          notifyListeners();
        } else {
          ClockPreferences.setIsRunning(false);
          isRunning = false;
        }
      }
    }
  }

  executeCommand() async {
    // else {
    //   errorCodes("System Failure");
    // }
    if (!isRunning) {
      _words = _command.split(" ");

      try {
        int timeInput = int.parse(_words[3]);
        DateTime now = DateTime.now();
        if (_words[4] == "am") {
          if (timeInput == 12) {
            timeInput = 0;
          }
          await ClockPreferences.setTime(timeInput);
          print(ClockPreferences.getTimeSet());

          /// Checks if the current time is am
          /// or Pm and converts the input to minutes
        } else if (_words[4] == "pm") {
          if (timeInput < 12) {
            assert(timeInput > 12 == false);
            timeInput += 12;
          }
          await ClockPreferences.setTime(timeInput);

          print(ClockPreferences.getTimeSet());
        }
        setTime(now, timeInput);
        await ClockPreferences.setDuration(_time);
        print(ClockPreferences.getDuration());
        await ClockPreferences.setTAWSet(now);
        isRunning = true;
        await ClockPreferences.setIsRunning(true);
        alarmCaller();
        this._changeTimeSeconds();
        changeTimeMinute();

        _command = "";

        notifyListeners();
      } catch (e) {
        errorCodes("invalid command");
      }
    } else {
      if (_command == "4 8 15 16 23 42") {
        isRunning = false;
        _time = 0;
        _setClockTime(0);
        seconds = 0;
        setTimeSec();
        await ClockPreferences.setTime(0);
        await ClockPreferences.setIsRunning(false);
        notifyListeners();
        errorCodes("Alarm has been stoped");

        // Alarm.stop();
      } else {
        errorCodes("An alarm is already running");
      }

    }
  }

  addCommand(String command) {
    if (!(_command.length > 20)) {
      this._command += command;
      notifyListeners();
    }
  }

  removeCharacter() {
    if (_command.isNotEmpty) {
      int char = _command.length - 1;

      _command = _command.substring(0, char);
      notifyListeners();
    }
  }
}

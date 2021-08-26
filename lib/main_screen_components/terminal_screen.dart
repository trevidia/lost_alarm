import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommandDisplay extends StatefulWidget {
  const CommandDisplay({Key? key}) : super(key: key);

  @override
  _CommandDisplayState createState() => _CommandDisplayState();
}

class _CommandDisplayState extends State<CommandDisplay>
    with SingleTickerProviderStateMixin {
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
        fit: BoxFit.contain,
      ),
      Positioned(
        top: MediaQuery.of(context).size.height / 15,
        left: MediaQuery.of(context).size.width / 6,
        child: Container(
          width: 200,
          child: Row(
            children: [
              Text(
                "lost_alarm \$>: $command",
                style: TextStyle(color: Colors.greenAccent, fontSize: 10),
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

class Command extends ChangeNotifier {
  List<String> _words = [];
  String _command = "";
  int _time = 0;
  int day = 0;
  int hours = 0;
  int minutes = 0;
  bool isRunning = false;
  int value1 = 0;
  int value2 = 0;
  int value3 = 0;
  int value4 = 0;

  setTime(bool stater, DateTime now, int timeInput, String period) {
    print('hoip');
    if (stater && period == "am") {
      print('hiploiu');
      if (now.hour < timeInput) {
        _time = ((timeInput - now.hour) * 60) - now.minute - 1;
        _setClockTime(_time);
        print(_time);
      } else {
        _time = ((23 - now.hour + timeInput) * 60) + 60 - now.minute - 1;
        _setClockTime(_time);
        print(_time);
      }
    } else if (period == "pm") {
      timeInput = timeInput + 12;
      if (now.hour < timeInput) {
        _time = ((timeInput - now.hour) * 60) - now.minute - 1;
        _setClockTime(_time);
      } else {
        _time = ((23 - now.hour + timeInput) * 60) + 60 - now.minute - 1;
        _setClockTime(_time);
        print(_time);
      }
    }
    print(_time);
  }

  _setClockTime(int time) {
    print(value1);
    print(value2);
    print(value3);
    print(value4);
    changeToInt(String e) => int.parse(e);
    print(time.toString().length);
    List values = time.toString().split('');
    switch (time.toString().length) {
      case 4:
        value1 = changeToInt(values[0]);
        value2 = changeToInt(values[1]);
        value3 = changeToInt(values[2]);
        value4 = changeToInt(values[3]);
        notifyListeners();
        break;
      case 3:
        value1 = 0;
        value2 = changeToInt(values[0]);
        value3 = changeToInt(values[1]);
        value4 = changeToInt(values[2]);
        notifyListeners();
        break;
      case 2:
        value1 = 0;
        value2 = 0;
        value3 = changeToInt(values[0]);
        value4 = changeToInt(values[1]);
        notifyListeners();
        break;
      case 1:
        value1 = 0;
        value2 = 0;
        value3 = 0;
        value4 = changeToInt(values[0]);
        notifyListeners();
        break;
    }
    print(value1);
    print(value2);
    print(value3);
    print(value4);
    notifyListeners();
  }

  executeCommand() {
    _words = _command.split(" ");

    int timeInput = int.parse(_words[3]);
    DateTime now = DateTime.now();
    print(now);
    if (_words[4] == "am") {
      /// Checks if the current time is am
      /// or Pm and converts the input to minutes
      setTime(now.hour >= 0 && now.hour < 13, now, timeInput, "am");
    } else if (_words[4] == "pm") {
      setTime(23 >= now.hour && 13 <= now.hour, now, timeInput, "pm");
    }
    isRunning = true;
    notifyListeners();
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

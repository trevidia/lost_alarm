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

  addCommand(String command) {
    if (command != "EXECUTE" && !(_command.length > 20)) {
      this._command += command;
      notifyListeners();
    } else {}
  }

  removeCharacter() {
    if (_command.isNotEmpty) {
      int char = _command.length - 1;

      _command = _command.substring(0, char);
      notifyListeners();
    }
  }
}

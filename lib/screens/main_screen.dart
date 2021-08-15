import 'package:flutter/material.dart';
import 'package:lost_alarm/main_screen_components/clock.dart';
import 'package:lost_alarm/main_screen_components/keyboard.dart';
import 'package:lost_alarm/main_screen_components/terminal_screen.dart';


class Terminal extends StatefulWidget {
  const Terminal({Key? key}) : super(key: key);

  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/Pics/Background-min.jpg"),
        Container(
          child: Column(
            children: [
              ClockTimer(),
              Stack(
                children: [
                  CommandDisplay(),
                  Align(
                      heightFactor: 3.3,
                      child: Transform.scale(
                          scale: 1.5,
                          child: OnKeyBoard()
                      ))],
              )
            ],
          ),
        )
      ],
    );
  }
}

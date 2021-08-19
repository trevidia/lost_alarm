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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            color: Color.fromRGBO(52, 58, 64, 1),
          ),
          Column(
            children: [
              Expanded(flex: 5, child: ClockTimer()),
              // Expanded(
              //   flex: 4,
              //   child: SizedBox(
              //     child: Stack(children: [
              //       // CommandDisplay(),

              //       //   Align(heightFactor: 3.5, child: OnKeyBoard())
              //     ]),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}

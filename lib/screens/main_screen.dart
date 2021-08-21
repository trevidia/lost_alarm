import 'package:flutter/material.dart';
import 'package:lost_alarm/main_screen_components/clock.dart';
import 'package:lost_alarm/main_screen_components/keyboard.dart';
import 'package:lost_alarm/main_screen_components/terminal_screen.dart';
import 'package:provider/provider.dart';

class Terminal extends StatefulWidget {
  const Terminal({Key? key}) : super(key: key);

  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Command(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CommandDisplay(), OnkeyBoard()],
      ),
    );
  }
}

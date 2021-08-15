import 'package:flutter/material.dart';

class CommandDisplay extends StatefulWidget {
  const CommandDisplay({Key? key}) : super(key: key);

  @override
  _CommandDisplayState createState() => _CommandDisplayState();
}

class _CommandDisplayState extends State<CommandDisplay> {
  @override
  Widget build(BuildContext context) {
    // todo implement animation of beeper
    return Image.asset("assets/Pics/PC.png");
  }
}

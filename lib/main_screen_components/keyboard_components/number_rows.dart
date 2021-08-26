import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lost_alarm/main_screen_components/terminal_screen.dart';
import 'package:provider/provider.dart';

class NumberRow extends StatefulWidget {
  final List<String> keys;
  final int row;

  const NumberRow(this.keys, this.row);

  @override
  _NumberRowState createState() => _NumberRowState();
}

class _NumberRowState extends State<NumberRow> {
  late AudioPlayer player;
  bool islongPressed = false;
  @override
  void initState() {
    player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.keys.map((e) {
        return GestureDetector(
          onLongPressStart: (details) {
            setState(() {
              islongPressed = true;
            });
          },
          onLongPress: () async {
            if (e == "Backspace") {
              await player.setAsset('assets/Sound/Keyboard_sounds/1.wav');
              player.play();

              Provider.of<Command>(context, listen: false).removeCharacter();
            }
          },
          onLongPressEnd: (details) {
            print(details.velocity);
            setState(() {
              islongPressed = false;
            });
          },
          onTap: () async {
            await player.setAsset('assets/Sound/Keyboard_sounds/1.wav');
            if (e == "Backspace") {
              Provider.of<Command>(context, listen: false).removeCharacter();
            } else {
              Provider.of<Command>(context, listen: false)
                  .addCommand(e.toLowerCase());
            }
            await player.play();
          },
          child: Container(
            constraints: BoxConstraints(maxWidth: 30, minWidth: 10),
            margin: EdgeInsets.fromLTRB(3, 1, 3, 1),
            child: Image(
              width: 25,
              filterQuality: FilterQuality.high,
              isAntiAlias: true,
              image: AssetImage(
                "assets/Keyboard/${widget.row}-$e.png",
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

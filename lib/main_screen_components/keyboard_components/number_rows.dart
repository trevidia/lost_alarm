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
  Color? tapColor;
  late List<Color> keyColors;


  @override
  void initState() {
    player = AudioPlayer();
    // keyColors = widget.keys;

    super.initState();
  }


  @override
  void dispose() {
    print("i disposed");

    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ...widget.keys.map((e) {
        return Expanded(
          child: Container(
            constraints: BoxConstraints(maxWidth: 30, minWidth: 10),
            margin: EdgeInsets.fromLTRB(3, 1, 3, 1),
            child: InkWell(
              onTap: () async {
                await player.setAsset('assets/Sound/Keyboard_sounds/1.wav',
                preload: false);
                await player.load();
                player.play();


                if (e == "Backspace") {
                  Provider.of<Command>(context, listen: false)
                      .removeCharacter();
                } else {
                  Provider.of<Command>(context, listen: false)
                      .addCommand(e.toLowerCase());
                }

              },
              child: Image(
                key: Key(e.toString()),
                width: 25,
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
                image: AssetImage(
                  "assets/Keyboard/${widget.row}-$e.png",
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lost_alarm/main_screen_components/terminal_screen.dart';
import 'package:provider/provider.dart';

class OnkeyBoard extends StatelessWidget {
  final row1 = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
  ];
  final row2 = ["ESC", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"];
  final row3 = ["CTRL", "A", 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
  final row4 = ["Shift", 'Z', 'X', "C", 'V', 'B', 'N', 'M', 'Backspace'];

  initPlayer() async {
    AudioPlayer player = AudioPlayer();
    await player.setAsset("assets/Sound/Keyboard_sounds/2.wav");
    player.play();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Todo map buttons to image
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
          "assets/Keyboard/casing.png",
        ))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NumberRow(row1, 1),
            NumberRow(row2, 2),
            NumberRow(row3, 3),
            NumberRow(row4, 4),
            Container(
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await initPlayer();
                      Provider.of<Command>(context, listen: false)
                          .addCommand("POWER");
                    },
                    child: Image.asset(
                      "assets/Keyboard/5-POWER.png",
                      width: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await initPlayer();
                      Provider.of<Command>(context, listen: false)
                          .addCommand(" ");
                    },
                    child: Image.asset(
                      "assets/Keyboard/5-SPACE.png",
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await initPlayer();
                      Provider.of<Command>(context, listen: false)
                          .addCommand("EXECUTE");
                    },
                    child: Image.asset(
                      "assets/Keyboard/5-EXECUTE.png",
                      width: 35,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

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

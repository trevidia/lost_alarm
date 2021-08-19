import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class OnkeyBoard extends StatelessWidget {
  final row1 = [
    "ESC",
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
    "Backspace"
  ];
  final row2 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"];
  final row3 = ["A", 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'EXECUTE'];
  final row4 = ["Shift", 'Z', 'X', "C", 'V', 'B', 'N', 'M', 'Shift'];
  final row5 = ["SPACE"];

  @override
  Widget build(BuildContext context) {
    // Todo map buttons to image
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Keyboard/casing.png"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NumberRow(row1, 1),
            NumberRow(row2, 2),
            NumberRow(row3, 3),
            NumberRow(row4, 4),
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
          onTap: () async {
            await player.setAsset('assets/Sound/Keyboard_sounds/1.wav');
            player.play();
            print(e);
          },
          child: Container(
            constraints: BoxConstraints(maxWidth: 30, minWidth: 10),
            margin: EdgeInsets.fromLTRB(3, 1, 3, 1),
            child: Image(
              isAntiAlias: true,
              image: AssetImage("assets/Keyboard/${widget.row}-$e.jpg"),
            ),
          ),
        );
      }).toList(),
    );
  }
}

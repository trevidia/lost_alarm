import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:lost_alarm/main_screen_components/terminal_screen.dart';
import 'package:provider/provider.dart';

import 'keyboard_components/number_rows.dart';

class OnKeyBoard extends StatefulWidget {
  @override
  _OnKeyBoardState createState() => _OnKeyBoardState();
}

class _OnKeyBoardState extends State<OnKeyBoard> {
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

  AudioPlayer player = AudioPlayer();



  @override
  initState(){

    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Todo map buttons to image
    return Expanded(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
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
                      onTap: ()  {
                        player.setAsset('assets/Sound/Keyboard_sounds/1.wav');
                        player.play();
                        Provider.of<Command>(context, listen: false)
                            .addCommand("");
                      },
                      child: Image.asset(
                        "assets/Keyboard/5-POWER.png",
                        width: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: ()  {
                        player.setAsset('assets/Sound/Keyboard_sounds/1.wav');
                        player.play();
                        Provider.of<Command>(context, listen: false)
                            .addCommand(" ");
                      },
                      child: Image.asset(
                        "assets/Keyboard/5-SPACE.png",
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        player.setAsset('assets/Sound/Keyboard_sounds/1.wav');
                        player.play();
                        Provider.of<Command>(context, listen: false)
                            .executeCommand();
                      },
                      child: Image.asset(
                        "assets/Keyboard/5-EXECUTE.png",
                        width: 40,
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

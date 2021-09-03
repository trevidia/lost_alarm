import 'package:flutter/material.dart';

import 'flip_card_animatable.dart';

class LostTimer extends StatelessWidget {
  const LostTimer({
    Key? key,
    required this.value1,
    required this.shouldCount,
    required this.value2,
    required this.value3,
    required this.value4,
    required this.value5,
    required this.value6,
  }) : super(key: key);

  final int value1;
  final bool shouldCount;
  final int value2;
  final int value3;
  final int value4;
  final int value6;
  final int value5;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 20,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 5,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FlipCardAnimateAble(
                    textColor: Colors.white,
                    cardColor: Colors.black,
                    number: value1,
                    isRunning: shouldCount,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FlipCardAnimateAble(
                      textColor: Colors.white,
                      cardColor: Colors.black,
                      isRunning: shouldCount,
                      number: value2,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FlipCardAnimateAble(
                    textColor: Colors.white,
                    cardColor: Colors.black,
                    number: value3,
                    isRunning: shouldCount,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FlipCardAnimateAble(
                    textColor: Colors.white,
                    cardColor: Colors.black,
                    isRunning: shouldCount,
                    number: value4,
                  ),
                ),
              ),
              Expanded(flex: 1, child: SizedBox(width: 10)),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FlipCardAnimateAble(
                    textColor: Colors.black,
                    cardColor: Colors.white,
                    number: value5,
                    isRunning: shouldCount,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FlipCardAnimateAble(
                    textColor: Colors.black,
                    cardColor: Colors.white,
                    isRunning: shouldCount,
                    number: value6,
                  ),
                ),
              ),
              Expanded(
                  child: SizedBox(
                width: 5,
              ))
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 20,
          ),
        )
      ],
    );
  }
}

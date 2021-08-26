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
  }) : super(key: key);

  final int value1;
  final bool shouldCount;
  final int value2;
  final int value3;
  final int value4;

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
                  padding: const EdgeInsets.all(8.0),
                  child: FlipCardAnimatable(
                    number: value1,
                    time: 59000,
                    isRunning: shouldCount,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlipCardAnimatable(
                      isRunning: shouldCount,
                      number: value2,
                      time: 5900,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlipCardAnimatable(
                    number: value3,
                    time: 590,
                    isRunning: shouldCount,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlipCardAnimatable(
                    isRunning: shouldCount,
                    number: value4,
                    time: 59,
                  ),
                ),
              ),
              Expanded(flex: 1, child: SizedBox(width: 10)),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlipCardAnimatable(
                    number: 5,
                    time: 9,
                    isRunning: shouldCount,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlipCardAnimatable(
                    isRunning: shouldCount,
                    number: 9,
                    time: 0,
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

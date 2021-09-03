import 'dart:math';


import 'package:lost_alarm/logic_designs/alarm.dart';
import 'package:lost_alarm/logic_designs/clock.dart';

import 'clipper.dart';
import 'time_card.dart';
import 'package:flutter/material.dart';

class FlipCardAnimateAble extends StatefulWidget {
  final int number;
  final bool isRunning;
  final Color textColor;
  final Color cardColor;

  FlipCardAnimateAble({
    Key? key,
    required this.number,
    required this.isRunning,
    required this.textColor,
    required this.cardColor,
  }) : super(key: key);

  @override
  _FlipCardAnimateAbleState createState() => _FlipCardAnimateAbleState();
}

class _FlipCardAnimateAbleState extends State<FlipCardAnimateAble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _anime;
  late Animation _backanime;
  late int prevNumber;
  late int latestNumber;
  bool isFliped = false;


  @override
  void initState() {
    super.initState();


    latestNumber = widget.number;
    if(ClockPreferences.getIsRunning() == true){
      prevNumber = widget.number;
    } else {
      prevNumber = 0;
    }

    // latestNumber -= 0;

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _anime = IntTween(begin: 0, end: 180).animate(_controller);
    _backanime = IntTween(begin: 180, end: 360).animate(_controller);
    _controller.addListener(() {
      setState(() {

      });
    });


  }

  // playAudio() async {
  //   await player.setAsset("assets/Sound/click/Click.wav");
  //   player.play();
  //   await player.stop();
  // }

  @override
  void didUpdateWidget(covariant FlipCardAnimateAble oldWidget) {
    /// if the alarm starts the flip animation starts


    if (widget.isRunning == true) {

      if (oldWidget.number != widget.number) {
        setState(() {
         
          latestNumber = widget.number;
        });
          _controller.forward();
          setState(() {
            prevNumber = oldWidget.number;
            // Alarm.play();
          });
          // playAudio();
        }


        _controller.addStatusListener((status) {
          if (status == AnimationStatus.completed && widget.isRunning == true) {

              prevNumber = widget.number;
              _controller.reset();

            // _controller.forward();
          }
        });

    } else if (widget.isRunning == false) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.stop();
        }
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flippable(
      latestNumber: latestNumber,
      anime: _anime,
      prevNumber: prevNumber,
      backanime: _backanime,
      cardColor: widget.cardColor,
      textColor: widget.textColor,
    );
  }
}

class Flippable extends StatelessWidget {
  const Flippable({
    Key? key,
    required this.latestNumber,
    required Animation anime,
    required this.prevNumber,
    required Animation backanime,
    required this.textColor,
    required this.cardColor,
  })  : _anime = anime,
        _backanime = backanime,
        super(key: key);

  final int latestNumber;
  final Animation _anime;
  final int prevNumber;
  final Animation _backanime;
  final Color textColor;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRect(
        clipper: ClipTop(),
        child: Container(
          child: TimeCard(
            textColor: textColor,
            number: latestNumber,
            cardColor: cardColor,
          ),
        ),
      ),
      if (_anime.value < 180)
        ClipRect(
          clipper: ClipBottom(),
          child: TimeCard(
              textColor: textColor, cardColor: cardColor, number: prevNumber),
        ),
      if (_anime.value > 90)
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX((_backanime.value / 180) * pi),
          child: Transform.rotate(
            alignment: Alignment.center,
            angle: 0,
            child: ClipRect(
              clipper: ClipBottom(),
              child: TimeCard(
                number: latestNumber,
                cardColor: cardColor,
                textColor: textColor,
              ),
            ),
          ),
        ),
      if (_anime.value < 90)
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX((_anime.value / 180) * pi),
          child: ClipRect(
            clipper: ClipTop(),
            child: TimeCard(
              number: prevNumber,
              textColor: textColor,
              cardColor: cardColor,
            ),
          ),
        ),
    ]);
  }
}

import 'dart:async';
import 'dart:math';

import 'clipper.dart';
import 'time_card.dart';
import 'package:flutter/material.dart';

class FlipCardAnimatable extends StatefulWidget {
  final int number;
  final bool isRunning;
  final int time;

  FlipCardAnimatable(
      {Key? key,
      required this.number,
      required this.isRunning,
      required this.time})
      : super(key: key);

  @override
  _FlipCardAnimatableState createState() => _FlipCardAnimatableState();
}

class _FlipCardAnimatableState extends State<FlipCardAnimatable>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _anime;
  late Animation _backanime;
  late int prevNumber;
  late int latestNumber;

  @override
  void initState() {
    latestNumber = widget.number;

    prevNumber = 0;
    latestNumber -= 0;

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _anime = IntTween(begin: 0, end: 180).animate(_controller);
    _backanime = IntTween(begin: 180, end: 360).animate(_controller);

    _controller.addListener(() {
      /// makes the animation
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        /// if the animation is finished for the flip it calls the function
        /// to decrement the latest value
        decrement();
      }
    });
    super.initState();
  }

  decrement() {
    Timer.periodic(Duration(seconds: widget.time, milliseconds: 600), (timer) {
      /// main logic for the flipper
      if (widget.isRunning == true) {
        prevNumber = latestNumber;
        latestNumber -= 1;
        _controller.reset();
        _controller.forward();
      }
      if (widget.isRunning == true && latestNumber < 0) {
        latestNumber = widget.number;
        _controller.reset();
        _controller.forward();
      }

      timer.cancel();
    });
  }

  @override
  void didUpdateWidget(covariant FlipCardAnimatable oldWidget) {
    /// if the alarm starts the flip animation starts
    print("hi");
    if (widget.isRunning == true) {
      if (oldWidget.number == 0) {
        // print("hi");
        latestNumber = widget.number;
      }
      _controller.forward();
    } else {
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
    // _controller.dispose();
    print("I have been disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flipable(
        latestNumber: latestNumber,
        anime: _anime,
        prevNumber: prevNumber,
        backanime: _backanime);
  }
}

class Flipable extends StatelessWidget {
  const Flipable({
    Key? key,
    required this.latestNumber,
    required Animation anime,
    required this.prevNumber,
    required Animation backanime,
  })  : _anime = anime,
        _backanime = backanime,
        super(key: key);

  final int latestNumber;
  final Animation _anime;
  final int prevNumber;
  final Animation _backanime;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRect(
        clipper: ClipTop(),
        child: TimeCard(
          number: latestNumber,
        ),
      ),
      if (_anime.value < 180)
        ClipRect(
          clipper: ClipBottom(),
          child: TimeCard(number: prevNumber),
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
            child: TimeCard(number: prevNumber),
          ),
        ),
    ]);
  }
}

import 'package:flutter/material.dart';

class OnKeyBoard extends StatelessWidget {
  const OnKeyBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Todo map buttons to image
    return Transform.scale(
      scale: 1.3,
      child: Transform.translate(
        offset: Offset(50, 100),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Pics/Keyboard-min.png"))),
        ),
      ),
    );
  }
}

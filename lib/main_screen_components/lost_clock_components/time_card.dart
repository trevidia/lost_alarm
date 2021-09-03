import 'package:flutter/material.dart';

class TimeCard extends StatelessWidget {
  final number;
  final textColor;
  final cardColor;
  const TimeCard(
      {Key? key, this.number, required this.cardColor, required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 150,
      width: 200,
      decoration: BoxDecoration(
          color: cardColor == Colors.black ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(5)),
      child: Stack(children: [
        Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                ),
                height: 195,
                width: 200,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                ),
                height: 195,
                width: 200,
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "$number",
                  style: TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      fontSize: 30,
                      fontFamily: "Helvetica",
                      color: textColor),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                height: 195,
                width: 200,
              ),
            ),
            Container(
              color: Color.fromRGBO(73, 80, 87, 1),
              height: 2,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                height: 195,
                width: 200,
              ),
            )
          ],
        ),
      ]),
    );
  }
}

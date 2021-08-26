import 'package:flutter/material.dart';

class TimeCard extends StatelessWidget {
  final number;
  const TimeCard({Key? key, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 150,
      width: 200,
      decoration: BoxDecoration(
          color: Color.fromRGBO(33, 37, 41, 1),
          borderRadius: BorderRadius.circular(5)),
      child: Stack(children: [
        Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(33, 37, 41, 1),
                ),
                height: 195,
                width: 200,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(33, 37, 41, 1),
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
                      fontFamily: "Century Gothic",
                      color: Color.fromRGBO(206, 212, 218, 1)),
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
              height: 5,
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

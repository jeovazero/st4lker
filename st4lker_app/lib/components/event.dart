import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';

class Event extends StatelessWidget {
  final String action;
  final String date;
  final String repository;

  Event({ this.action, this.repository, this.date });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: secondaryDarkest, width: 4),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Text(
                date,
                style: TextStyle(
                  color: secondary,
                  fontSize: 18,
                  fontFamily: 'Tuffy',
                ),
              ),
              Text(
                action,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Tuffy',
                ),
              ),
              Text(
                '> ${repository}',
                style: TextStyle(
                  color: secondary,
                  fontSize: 18,
                  fontFamily: 'Tuffy',
                ),
              )
            ],
          )),
    );
  }
}

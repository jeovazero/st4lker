import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';

class Event extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: secondary, width: 4),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Text(
                '12 / Feb',
                style: TextStyle(
                  color: secondary,
                  fontSize: 18,
                  fontFamily: 'Tuffy',
                ),
              ),
              Text(
                'Created the repository',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Tuffy',
                ),
              ),
              Text(
                '> jeovazero/st4lker',
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

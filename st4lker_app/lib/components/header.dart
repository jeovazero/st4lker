import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'colors.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Row(children: [
          Text('St4lker',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Tuffy',
              )),
          Text('Github',
              style: TextStyle(
                color: secondary,
                fontWeight: FontWeight.bold,
                fontSize: 32,
                fontFamily: 'Tuffy',
              ))
        ]),
      ),
      decoration: BoxDecoration(
        color: primaryDark,
        border: Border(bottom: BorderSide(color: secondary, width: 5)),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';

class TextFieldStalker extends StatelessWidget {
  final Function(String) onChanged;

  TextFieldStalker({ this.onChanged });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        onChanged: onChanged,
        textAlign: TextAlign.left,
        autocorrect: false,
        style: TextStyle(color: Colors.white, fontFamily: 'Tuffy'),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: secondaryDarkest,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(width: 2, color: secondary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(width: 2, color: secondaryDarkest),
          ),
          hintText: 'stalk a github user',
          hintStyle: TextStyle(color: secondaryDarkest),
          fillColor: primaryDark,
        ),
      ),
    );
  }
}

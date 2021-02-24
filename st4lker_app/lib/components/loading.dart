import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Dot(offset: 1),
      Dot(offset: 0.75),
      Dot(offset: 0.5),
      Dot(offset: 0.25),
      Dot(offset: 0)
    ], mainAxisSize: MainAxisSize.min,);
  }
}

class Dot extends StatefulWidget {
  final double offset;

  Dot({Key key, @required this.offset}) : super(key: key);

  @override
  _Dot createState() => _Dot(offset: offset);
}

enum Direction { Forward, Reverse }

class _Dot extends State<Dot> {
  double _begin = 0;
  double _end = 1;
  Direction _dir = Direction.Forward;

  final double offset;
  final double duration;

  _Dot({@required this.offset}) : duration = offset;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: _begin, end: _end),
      duration: Duration(milliseconds: 500),
      onEnd: () => {
        if (_dir == Direction.Forward)
          {
            setState(() {
              _dir = Direction.Reverse;
              _begin = 1;
              _end = 0;
            })
          }
        else
          {
            setState(() {
              _dir = Direction.Forward;
              _begin = 0;
              _end = 1;
            })
          }
      },
      builder: (BuildContext context, double val, Widget _) {
        double _t;
        double t;
        if (_dir == Direction.Forward) {
          _t = offset + val;
          t = _t > 1 ? 2 - _t : _t;
        } else {
          _t = val - offset;
          t = _t < 0 ? -_t : _t;
        }
        var lerpValue = lerpDouble(12, 24, t);
        return Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          child: Container(
            width: lerpValue,
            height: lerpValue,
            decoration: BoxDecoration(
              color: Color.lerp(secondary, grad2, t),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}

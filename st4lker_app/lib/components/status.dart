import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:st4lker/components/loading.dart';

enum AppStatus { Loading, UserNotFound, Error, UserFound, Forbidden, Nothing }

class Status extends StatelessWidget {
  final AppStatus status;

  Status({this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AppStatus.Loading:
        return Loading();

      case AppStatus.Forbidden:
        return Text(
          'Sorry, you have reached the limit of calls (60 calls/hour) in the'
          ' public Github API. Try again later :/',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Tuffy',
          ),
        );

      case AppStatus.Error:
        return Text(
          'Sorry, check your connection and try again.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Tuffy',
          ),
        );

      case AppStatus.UserNotFound:
        return Text(
          'User not found :(',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Tuffy',
          ),
        );

      default:
        return Container();
    }
  }
}

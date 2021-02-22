import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'components/user_card.dart';
import 'components/colors.dart';
import 'components/header.dart';
import 'components/text_field_stalker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Route onGenerate(RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Main(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: primary,
      onGenerateRoute: onGenerate,
      textStyle: TextStyle(
        fontFamily: 'Tuffy',
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextFieldStalker(),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                UserCard(),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24, top: 24, bottom: 24),
                    child: Text(
                      'Activities',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Tuffy',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      child: Scaffold(
        backgroundColor: primary,
        body: SafeArea(
          child: Column(children: [Header(), Body()]),
        ),
      ),
    );
  }
}

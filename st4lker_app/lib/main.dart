import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_events_search/github_events_search.dart';
import 'package:st4lker/components/status.dart';
import 'package:st4lker/components/user_card.dart';
import 'package:st4lker/event_from_github.dart';

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

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Body();
}

class _Body extends State<Body> {
  Timer _debounce;
  List<GithubEvent> _events = [];
  AppStatus _appStatus = AppStatus.Nothing;
  GithubUser _user;

  _onChange(String text) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    setState(() {
      _user = null;
      _appStatus = text.isNotEmpty ? AppStatus.Loading : AppStatus.Nothing;
      _events = [];
    });

    if (text.isEmpty) return;

    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      try {
        final user = await getGithubUser(user: text);
        if (user is GithubNoUser) {
          setState(() {
            _appStatus = AppStatus.UserNotFound;
          });
          return;
        }
        final events = await searchEventsByUSer(user: text, per_page: 5);
        setState(() {
          _user = user;
          _events = events;
          _appStatus = AppStatus.UserFound;
        });
      } catch (err) {
        setState(() {
          _appStatus = AppStatus.Error;
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextFieldStalker(
            onChanged: _onChange,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                if (_appStatus != AppStatus.UserFound)
                  Container(
                    child: Status(status: _appStatus),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(24),
                  ),
                if (_user != null) UserCard(_user),
                if (_user != null)
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
                for (var item in _events) event_from_github(item)
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
          child: Column(children: <Widget>[Header(), Body()]),
        ),
      ),
    );
  }
}

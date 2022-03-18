import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_events_search/github_events_search.dart';

import 'components/colors.dart';
import 'components/header.dart';
import 'components/status.dart';
import 'components/text_field_stalker.dart';
import 'components/user_sliver.dart';
import 'event_from_github.dart';

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

    _debounce = Timer(const Duration(seconds: 1), () async {
      try {
        final githubUserResponse = await getGithubUser(user: text);
        if (githubUserResponse.status == ResponseStatus.NotFound) {
          setState(() {
            _appStatus = AppStatus.UserNotFound;
          });
          return;
        }
        final eventsResponse = await searchEventsByUSer(
          user: text,
          per_page: 100,
        );
        if (eventsResponse.status == ResponseStatus.Ok) {
          setState(() {
            _user = githubUserResponse.user;
            _events = eventsResponse.events;
            _appStatus = AppStatus.UserFound;
          });
        } else if (eventsResponse.status == ResponseStatus.Forbidden) {
          setState(() {
            _appStatus = AppStatus.Forbidden;
          });
        }
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
            child: _appStatus != AppStatus.UserFound
                ? Container(
                    child: Status(status: _appStatus),
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.all(24),
                  )
                : CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: UserSliver(_user),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                          if (_user != null)
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 24,
                                  top: 24,
                                  bottom: 24,
                                ),
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
                          for (var item in _events) eventFromGithub(item)
                        ]),
                      )
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

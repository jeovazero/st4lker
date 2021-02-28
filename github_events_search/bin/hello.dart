import 'dart:io';

import 'package:github_events_search/github_events_search.dart';
import 'package:github_events_search/src/github_user.dart';

Future main(List<String> trash) async {
  var events = await searchEventsByUSer(
    user: 'jeovazero',
    per_page: 100,
    page: 1,
  );
  print(events);
  var user = await getGithubUser(user: 'jeovazero');
  print(user);
  var noUser = await getGithubUser(user: 'zwrwef');
  print(noUser);
  exit(0);
}

import 'package:github_events_search/github_events_search.dart';
import 'package:github_events_search/src/github_user.dart';

Future main(List<String> trash) async {
  var events = await searchEventsByUSer(user: 'jeovazero', per_page: 10, page: 1);
  print(events);
  var user = await getGithubUser(user: 'jeovazero');
  print(user);
}

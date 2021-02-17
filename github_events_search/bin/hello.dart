import 'package:github_events_search/github_events_search.dart';

Future main(List<String> trash) async {
  var json = await searchEventsByUSer(user: 'jeovazero', per_page: 10, page: 1);
  print(json);
}

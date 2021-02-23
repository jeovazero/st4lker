import 'package:github_events_search/github_events_search.dart';
import 'package:intl/intl.dart';
import 'package:st4lker/components/event.dart';

String capitalize(String text) => '${text[0].toUpperCase()}${text.substring(1)}';

Event event_from_github(GithubEvent gh_event) {
  final repository = gh_event.repo.name;
  var action;
  var date = DateFormat.MMMd().format(gh_event.created_at);
  if (gh_event is PushEvent) {
    var size = gh_event.payload.size;
    action = 'Pushed ${size} commit${size > 1 ? 's' : ''}';
  } else if (gh_event is PullRequestEvent) {
    var pr_action = gh_event.payload.action;
    action = '${capitalize(pr_action)} a Pull Request on';
  } else if (gh_event is WatchEvent) {
    action = 'Stared a repository';
  } else if (gh_event is IssuesEvent) {
    var issue_action = gh_event.payload.action;
    action = '${capitalize(issue_action)} a Issue on';
  } else {
    assert(false, 'Something wrong, little coder');
  }

  return Event(action: action, date: date, repository: repository,);
}
import 'package:flutter/widgets.dart';
import 'package:github_events_search/github_events_search.dart';
import 'package:intl/intl.dart';
import 'package:st4lker/components/event.dart';

String capitalize(String text) =>
    '${text[0].toUpperCase()}${text.substring(1)}';

Widget eventFromGithub(GithubEvent ghEvent) {
  final repository = ghEvent.repo.name;
  var action;
  var date = DateFormat.MMMd().format(ghEvent.created_at);

  if (ghEvent is PushEvent) {
    var size = ghEvent.payload.size;
    action = 'Pushed $size commit${size > 1 ? 's' : ''}';
  } else if (ghEvent is PullRequestEvent) {
    var prAction = ghEvent.payload.action;
    action = '${capitalize(prAction)} a Pull Request on';
  } else if (ghEvent is WatchEvent) {
    action = 'Stared a repository';
  } else if (ghEvent is IssuesEvent) {
    var issueAction = ghEvent.payload.action;
    action = '${capitalize(issueAction)} a Issue on';
  } else if (ghEvent is CreateEvent) {
    action = 'Created the repository';
  } else if (ghEvent is ForkEvent) {
    var repoName = ghEvent.payload.forkee.name;
    action = 'Forked $repoName from';
  } else if (ghEvent is PublicEvent) {
    action = 'Made public the repository';
  } else {
    assert(false, 'Something wrong, little coder');
  }

  return Padding(
    child: Event(
      action: action,
      date: date,
      repository: repository,
    ),
    padding: EdgeInsets.only(top: 0, bottom: 20),
  );
}

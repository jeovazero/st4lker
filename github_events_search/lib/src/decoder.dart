import 'events_type.dart';
import 'events/base.dart';
import 'events/issue.dart';
import 'events/watch.dart';
import 'events/push.dart';
import 'events/pull_request.dart';

List<GithubEvent> decodeEvents(dynamic json) {
  final List<GithubEvent> list = [];

  if (json is List) {
    for (var el in json) {
      if (el is Map<String, dynamic>) {
        var type = fromMaybeEvent(fromMaybeString('', el['type']));
        switch (type) {
          case GithubEventType.WatchEvent:
            list.add(WatchEvent.fromJson(el));
            break;
          case GithubEventType.PushEvent:
            list.add(PushEvent.fromJson(el));
            break;
          case GithubEventType.IssuesEvent:
            list.add(IssuesEvent.fromJson(el));
            break;
          case GithubEventType.PullRequestEvent:
            list.add(PullRequestEvent.fromJson(el));
            break;
        }
      }
    }
  }

  return list;
}
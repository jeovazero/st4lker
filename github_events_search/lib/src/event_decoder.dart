import 'event_types.dart';
import 'events/root.dart';
import 'helpers.dart';

List<GithubEvent> decodeEvents(dynamic json) {
  final list = <GithubEvent>[];

  if (json is List) {
    for (var item in json) {
      if (item is Map<String, dynamic>) {
        var type = fromMaybeEvent(fromMaybeString('', item['type']));
        switch (type) {
          case GithubEventType.WatchEvent:
            list.add(WatchEvent.fromJson(item));
            break;
          case GithubEventType.PushEvent:
            list.add(PushEvent.fromJson(item));
            break;
          case GithubEventType.IssuesEvent:
            list.add(IssuesEvent.fromJson(item));
            break;
          case GithubEventType.PullRequestEvent:
            list.add(PullRequestEvent.fromJson(item));
            break;
          case GithubEventType.PublicEvent:
            list.add(PublicEvent.fromJson(item));
            break;
          case GithubEventType.CreateEvent:
            list.add(CreateEvent.fromJson(item));
            break;
        }
      }
    }
  }

  return list;
}

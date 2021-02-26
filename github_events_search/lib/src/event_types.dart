enum GithubEventType {
  IssuesEvent,
  WatchEvent,
  PullRequestEvent,
  PushEvent,
  PublicEvent,
  UnknownEvent
}

GithubEventType fromMaybeEvent(String type) {
  switch (type) {
    case 'WatchEvent':
      return GithubEventType.WatchEvent;
    case 'PushEvent':
      return GithubEventType.PushEvent;
    case 'IssuesEvent':
      return GithubEventType.IssuesEvent;
    case 'PullRequestEvent':
      return GithubEventType.PullRequestEvent;
    case 'PublicEvent':
      return GithubEventType.PublicEvent;
    default:
      return GithubEventType.UnknownEvent;
  }
}

enum ResponseStatus { Ok, NotFound, Unknown, Forbidden }

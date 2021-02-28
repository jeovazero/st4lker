enum GithubEventType {
  IssuesEvent,
  WatchEvent,
  PullRequestEvent,
  PushEvent,
  PublicEvent,
  CreateEvent,
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
    case 'CreateEvent':
      return GithubEventType.CreateEvent;
    default:
      return GithubEventType.UnknownEvent;
  }
}

enum ResponseStatus { Ok, NotFound, Unknown, Forbidden }

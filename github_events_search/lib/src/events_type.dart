enum GithubEventType {
  IssuesEvent,
  WatchEvent,
  PullRequestEvent,
  PushEvent,
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
    default:
      return GithubEventType.UnknownEvent;
  }
}

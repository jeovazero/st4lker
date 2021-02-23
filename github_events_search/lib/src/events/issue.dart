import 'base.dart';

class Issue {
  final String title;

  Issue(this.title);

  static Issue createFromJson(Map<String, dynamic> json) =>
      Issue(fromMaybeString('', json['title']));
}

class IssuesEventPayload {
  final String action;
  final Issue issue;

  IssuesEventPayload(this.action, this.issue);

  static IssuesEventPayload createFromJson(Map<String, dynamic> json) =>
      IssuesEventPayload(fromMaybeString('', json['action']),
          transformFromRecord(null, Issue.createFromJson, json['issue']));

  @override
  String toString() {
    return 'IssuesEvent { action = ${action}, '
        'issue = { title = \'${issue?.title}\' } }';
  }
}

class IssuesEvent extends GithubEvent<IssuesEventPayload> {
  IssuesEvent.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, IssuesEventPayload.createFromJson);
}

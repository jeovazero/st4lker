import 'base.dart';
import '../helpers.dart';

class PullRequestPayload {
  final String action;
  final int number;

  PullRequestPayload(this.action, this.number);

  static PullRequestPayload createFromJson(Map<String, dynamic> json) =>
      PullRequestPayload(
        fromMaybeString('', json['action']),
        fromMaybeInt(-1, json['number']),
      );

  @override
  String toString() {
    return 'PREvent { action = ${action}, number = ${number} }';
  }
}

class PullRequestEvent extends GithubEvent<PullRequestPayload> {
  PullRequestEvent.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, PullRequestPayload.createFromJson);
}

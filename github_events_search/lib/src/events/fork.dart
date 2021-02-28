import '../helpers.dart';
import 'base.dart';

class ForkEvent extends GithubEvent<ForkEventPayload> {
  ForkEvent.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, ForkEventPayload.createFromJson);
}

class ForkEventPayload {
  final Repo forkee;

  ForkEventPayload(this.forkee);

  static ForkEventPayload createFromJson(Map<String, dynamic> json) =>
      ForkEventPayload(
        transformFromRecord(null, Repo.createFromJson, json['forkee']),
      );

  @override
  String toString() {
    return 'ForkEvent { forkee = ${forkee} }';
  }
}

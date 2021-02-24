import 'base.dart';
import '../helpers.dart';

class WatchEventPayload {
  final String action;

  WatchEventPayload(this.action);

  static WatchEventPayload createFromJson(Map<String, dynamic> json) =>
      WatchEventPayload(fromMaybeString('', json['action']));

  @override
  String toString() {
    return 'WatchEvent { action = ${action} }';
  }
}

class WatchEvent extends GithubEvent<WatchEventPayload> {
  WatchEvent.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, WatchEventPayload.createFromJson);
}
import 'base.dart';

class PublicEvent extends GithubEvent<dynamic> {
  PublicEvent.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, PublicEventPayload.createFromJson);
}

class PublicEventPayload {
  PublicEventPayload();

  static PublicEventPayload createFromJson(Map<String, dynamic> _) =>
      PublicEventPayload();

  @override
  String toString() {
    return 'Public { }';
  }
}

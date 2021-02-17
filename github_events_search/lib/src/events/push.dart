import 'base.dart';

class PushEvent extends GithubEvent<PushEventPayload> {
  PushEvent.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, PushEventPayload.createFromJson);
}

class PushEventPayload {
  final int size;

  PushEventPayload(this.size);

  static PushEventPayload createFromJson(Map<String, dynamic> json) =>
      PushEventPayload(fromMaybeInt(0, json['size']));

  @override
  String toString() {
    return 'PushEvent { size = ${size}  }';
  }
}

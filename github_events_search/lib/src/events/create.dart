import 'base.dart';
import '../helpers.dart';

class CreateEvent extends GithubEvent<CreateEventPayload> {
  CreateEvent.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, CreateEventPayload.createFromJson);
}

class CreateEventPayload {
  final String description;

  CreateEventPayload(this.description);

  static CreateEventPayload createFromJson(Map<String, dynamic> json) =>
      CreateEventPayload(fromMaybeString('', json['description']));

  @override
  String toString() {
    return 'CreateEvent { description = ${description} }';
  }
}

import '../events_type.dart';
import '../helpers.dart';

class Repo {
  final int id;
  final String name;
  final String url;

  Repo.fromJson(Map<String, dynamic> json)
      : id = fromMaybeInt(-1, json['id']),
        name = fromMaybeString('', json['name']),
        url = fromMaybeString('', json['url']);

  static Repo createFromJson(Map<String, dynamic> json) => Repo.fromJson(json);

  @override
  String toString() {
    return 'Repo { id = ${id}, name = ${name}, url = ${url} }';
  }
}


class Actor {
  final int id;
  final String login;
  final String avatar_url;

  Actor.fromJson(Map<String, dynamic> json)
      : id = fromMaybeInt(-1, json['id']),
        login = fromMaybeString('', json['login']),
        avatar_url = fromMaybeString('', json['avatar_url']);

  static Actor createFromJson(Map<String, dynamic> json) => Actor.fromJson(json);

  @override
  String toString() {
    return 'Actor { login = ${login}, avatar = ${avatar_url} }';
  }
}

class GithubEvent<P> {
  final String id;
  final GithubEventType type;
  final Repo repo;
  final P payload;
  final DateTime created_at;
  final Actor actor;

  GithubEvent.fromJson(Map<String, dynamic> json, F<P> payloadDecoder)
      : id = fromMaybeString('', json['id']),
        type = fromMaybeEvent(fromMaybeString('', json['type'])),
        repo = transformFromRecord(null, Repo.createFromJson, json['repo']),
        actor = transformFromRecord(null, Actor.createFromJson, json['actor']),
        created_at = DateTime.parse(fromMaybeString('', json['created_at'])),
        payload = transformFromRecord(null, payloadDecoder, json['payload']);

  @override
  String toString() {
    return 'GithubEvent {\n  id = ${id},\n  '
        'created_at = ${created_at},\n  '
        'type = ${type},\n  '
        'repo = ${repo},\n  '
        'actor = ${actor},\n  '
        'payload = ${payload}\n }';
  }
}

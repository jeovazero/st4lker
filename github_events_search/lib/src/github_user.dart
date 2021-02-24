import 'dart:convert' as c;
import 'dart:io' as io;
import 'package:meta/meta.dart';

import 'helpers.dart';

class GithubUser {
  final String login;
  final int id;
  final String avatar_url;
  final String url;
  final String name;
  final int public_repos;
  final int followers;
  final int following;

  GithubUser.fromJson(Map<String, dynamic> json)
      : login = fromMaybeString('', json['login']),
        id = fromMaybeInt(-1, json['id']),
        avatar_url = fromMaybeString('', json['avatar_url']),
        url = fromMaybeString('', json['url']),
        name = fromMaybeString(null, json['name']),
        public_repos = fromMaybeInt(0, json['public_repos']),
        followers = fromMaybeInt(0, json['followers']),
        following = fromMaybeInt(0, json['following']);

  @override
  String toString() {
    return 'GithubUser { \n  '
        'login = ${login} \n  '
        'id = ${id} \n  '
        'avatar_url = ${avatar_url} \n  '
        'url = ${url} \n  '
        'name = ${name} \n  '
        'public_repos = ${public_repos} \n  '
        'followers = ${followers} \n  '
        'following = ${following} \n}';
  }
}

Future<GithubUser> getGithubUser({@required String user}) async {
  var apiUserURI = Uri.https('api.github.com', '/users/${user}');

  var request = await io.HttpClient().getUrl(apiUserURI);
  var response = await request.close();
  var textResponse = await response.transform(c.utf8.decoder).join();

  dynamic json = c.json.decode(textResponse);
  if (json is Map<String, dynamic>) {
    return Future.value(GithubUser.fromJson(json));
  }
  return Future.error(Exception('JSON malformed'));
}

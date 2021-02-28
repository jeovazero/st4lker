import 'dart:convert' as c;
import 'dart:io' as io;

import 'package:meta/meta.dart';

import 'event_types.dart';
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

class GithubUserResponse {
  final int rateLimitRemaining;
  final GithubUser user;
  final ResponseStatus status;

  GithubUserResponse({this.rateLimitRemaining, this.user, this.status});

  @override
  String toString() {
    return 'GithubUserResponse {\n  '
        'rateLimitRemaining = ${rateLimitRemaining},\n  '
        'status = ${status},\n  '
        'user = ${user} }';
  }
}

Future<GithubUserResponse> getGithubUser({@required String user}) async {
  var apiUserURI = Uri.https('api.github.com', '/users/${user}');

  var request = await io.HttpClient().getUrl(apiUserURI);
  var response = await request.close();
  var rateLimitRemaining = response.headers.value('x-ratelimit-remaining');
  GithubUser _user;

  var status = statusFromCode(response.statusCode);

  if (status == ResponseStatus.Ok) {
    var textResponse = await response.transform(c.utf8.decoder).join();

    dynamic json = c.json.decode(textResponse);
    if (json is Map<String, dynamic>) {
      _user = GithubUser.fromJson(json);
    } else {
      return Future.error(Exception('JSON malformed'));
    }
  }

  return Future.value(
    GithubUserResponse(
      rateLimitRemaining: int.parse(rateLimitRemaining, radix: 10),
      status: statusFromCode(response.statusCode),
      user: _user, // nullable
    ),
  );
}

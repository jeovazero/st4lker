import 'dart:convert' as c;
import 'dart:io' as io;
// remove it when dart >= 2.12.0
import 'package:meta/meta.dart';

import 'decoder.dart';
import 'events/base.dart';

Future<List<GithubEvent>> searchEventsByUSer({ @required String user ,
    int per_page = 20, int page = 0}) async {
  var queryParam = {'per_page': per_page.toString(), 'page': page.toString()};

  var apiEventURI = Uri.https(
    'api.github.com',
    '/users/${user}/events',
    queryParam,
  );

  var request = await io.HttpClient().getUrl(apiEventURI);
  var response = await request.close();
  var textResponse = await response.transform(c.utf8.decoder).join();

  dynamic json = c.json.decode(textResponse);

  return Future.value(decodeEvents(json));
}

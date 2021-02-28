import 'dart:convert' as c;
import 'dart:io' as io;

// remove it when dart >= 2.12.0
import 'package:meta/meta.dart';

import 'event_decoder.dart';
import 'event_types.dart';
import 'events/base.dart';
import 'helpers.dart';

class GithubEventsResponse {
  final ResponseStatus status;
  final bool hasNext;
  final List<GithubEvent> events;
  final int rateLimitRemaining;

  GithubEventsResponse({
    this.hasNext,
    this.events,
    this.rateLimitRemaining,
    this.status,
  });

  @override
  String toString() {
    return 'GithubEvents { \n  '
        'hasNext = ${hasNext},\n  '
        'status = ${status},\n  '
        'rateLimitRemaining = ${rateLimitRemaining},\n  '
        'events = \n${events}\n}';
  }
}

Future<GithubEventsResponse> searchEventsByUSer({
  @required String user,
  int per_page = 20,
  int page = 0,
}) async {
  var queryParam = {'per_page': per_page.toString(), 'page': page.toString()};

  var apiEventURI = Uri.https(
    'api.github.com',
    '/users/${user}/events',
    queryParam,
  );

  var request = await io.HttpClient().getUrl(apiEventURI);
  var response = await request.close();

  var status = statusFromCode(response.statusCode);

  var link = response.headers.value('link');
  // https://docs.github.com/en/rest/overview/resources-in-the-rest-api#pagination
  var hasNext =
      link?.split(',')?.map((e) => e.indexOf('rel="next"'))?.any((n) => n > 0);

  var rateLimitRemaining = response.headers.value('x-ratelimit-remaining');
  var textResponse = await response.transform(c.utf8.decoder).join();
  dynamic json = c.json.decode(textResponse);

  return Future.value(
    GithubEventsResponse(
      status: status,
      hasNext: hasNext ?? false,
      events: decodeEvents(json),
      rateLimitRemaining: int.parse(rateLimitRemaining, radix: 10),
    ),
  );
}

import 'event_types.dart';

String fromMaybeString(String _default, dynamic d) =>
    d is String ? d : _default;

int fromMaybeInt(int _default, dynamic d) {
  if (d is int) return d;
  if (d is String) return int.parse(d);
  return _default;
}

typedef F<T> = T Function(Map<String, dynamic> a);

T transformFromRecord<T>(T _default, F<T> f, dynamic json) {
  if (json is Map<String, dynamic>) {
    return f(json);
  }
  return _default;
}

ResponseStatus statusFromCode(int code) {
  switch (code) {
    case 200:
      return ResponseStatus.Ok;
    case 404:
      return ResponseStatus.NotFound;
    case 403:
      return ResponseStatus.Forbidden;
    default:
      return ResponseStatus.Unknown;
  }
}

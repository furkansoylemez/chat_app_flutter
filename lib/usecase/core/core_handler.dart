import 'dart:async';

typedef OnError<T> = FutureOr<T> Function(dynamic error);

Future<T> futureHandler<T>(
  Future<T> future,
  OnError<T> onError,
) {
  return future.then((result) => result).catchError((Object error) {
    return onError(error);
  });
}

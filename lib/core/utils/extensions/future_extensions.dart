import 'dart:async';

extension OnError<T> on Future<T> {
  Future<T> onErrorJustReturn(T value) => catchError((_) => value);
  Future<T?> drainAllErrors() {
    final completer = Completer<T?>();

    unawaited(then(completer.complete, onError: (_) => completer.complete(null)));

    return completer.future;
  }
}

extension OnErrorNullable<T> on Future<T?> {
  Future<T?> drainErrors() => catchError((_) => null);
}

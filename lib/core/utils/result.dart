import 'package:equatable/equatable.dart';

sealed class Result<T, R extends Object> extends Equatable {
  const Result();
}

final class ResultData<T, R extends Object> extends Result<T, R> {
  const ResultData(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}

class ResultError<T, R extends Object> extends Result<T, R> {
  const ResultError(this.exception);

  final R exception;

  @override
  List<Object?> get props => [exception];
}

import 'package:equatable/equatable.dart';

abstract class BaseState with EquatableMixin {
  const BaseState();
}

abstract class CopyableState<T extends BaseState> {
  const CopyableState();

  T copyWith();
}

abstract class ErrorState<T extends Object> {
  const ErrorState();

  T get exception;
}

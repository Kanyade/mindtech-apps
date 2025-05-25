import 'package:app_skeleton/core/bloc_base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

extension SafeAdding<T> on Subject<T> {
  void addSafe(T event) {
    if (!isClosed) add(event);
  }

  void addErrorSafe(Object error, [StackTrace? stackTrace]) {
    if (!isClosed) addError(error, stackTrace);
  }
}

mixin SafeAddingMixin<E extends BaseEvent, S extends BaseState> on BaseBloc<E, S> {
  void addSafe(E event) {
    if (!isClosed) add(event);
  }

  void emitSafe(Emitter<S> emit, S state) {
    if (!isClosed) emit(state);
  }
}

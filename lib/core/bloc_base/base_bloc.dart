import 'package:app_skeleton/core/bloc_base/base_event.dart';
import 'package:app_skeleton/core/bloc_base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:app_skeleton/core/bloc_base/base_event.dart';
export 'package:app_skeleton/core/bloc_base/base_state.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E extends BaseEvent, S extends BaseState> extends Bloc<E, S> {
  BaseBloc(super.initialState);
}

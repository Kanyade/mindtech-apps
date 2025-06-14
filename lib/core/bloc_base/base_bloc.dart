import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:io_mindtechapps_hw/core/bloc_base/base_event.dart';
import 'package:io_mindtechapps_hw/core/bloc_base/base_state.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:io_mindtechapps_hw/core/bloc_base/base_event.dart';
export 'package:io_mindtechapps_hw/core/bloc_base/base_state.dart';

abstract class BaseBloc<E extends BaseEvent, S extends BaseState> extends Bloc<E, S> {
  BaseBloc(super.initialState);
}

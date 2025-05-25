import 'package:io_mindtechapps_hw/app/domain/transactions/bloc/models/model.jsn.dart';
import 'package:io_mindtechapps_hw/app/domain/transactions/repository.dart';
import 'package:io_mindtechapps_hw/core/bloc_base/base_bloc.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/safe_event_adding.dart';
import 'package:io_mindtechapps_hw/core/utils/result.dart';

part 'event.dart';
part 'state.dart';

class UserSettingsBloc extends BaseBloc<UserSettingsEvent, UserSettingsState> with SafeAddingMixin {
  final UserSettingsRepository _repository;

  UserSettingsBloc(this._repository) : super(const UserSettingsInitialState()) {
    on<UserSettingsLoadEvent>((event, emit) async {
      if (event.forceRefresh || state is! UserSettingsLoadedState) {
        emit(const UserSettingsLoadingState());

        final result = await _repository.getLatestSettings(forceRefresh: event.forceRefresh);

        emitSafe(emit, switch (result) {
          ResultData<UserSettings, UserSettingsError>(:final value) => UserSettingsLoadedState(settings: value),
          ResultError(:final exception) => UserSettingsErrorState(exception: exception),
        });
      }
    });
  }
}

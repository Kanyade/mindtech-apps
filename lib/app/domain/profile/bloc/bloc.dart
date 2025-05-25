import 'package:io_mindtechapps_hw/app/domain/profile/model.jsn.dart';
import 'package:io_mindtechapps_hw/app/domain/profile/repository.dart';
import 'package:io_mindtechapps_hw/core/bloc_base/base_bloc.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/safe_event_adding.dart';
import 'package:io_mindtechapps_hw/core/utils/result.dart';

part 'event.dart';
part 'state.dart';

class UserProfileBloc extends BaseBloc<UserProfileEvent, UserProfileState> with SafeAddingMixin {
  final UserProfileRepository _repository;

  UserProfileBloc(this._repository) : super(const UserProfileInitialState()) {
    on<UserProfileLoadEvent>((event, emit) async {
      if (event.forceRefresh || state is! UserProfileLoadedState) {
        emit(const UserProfileLoadingState());

        final result = await _repository.getLatestProfile(forceRefresh: event.forceRefresh);

        emitSafe(emit, switch (result) {
          ResultData<UserProfile, UserProfileError>(:final value) => UserProfileLoadedState(profile: value),
          ResultError(:final exception) => UserProfileErrorState(exception: exception),
        });
      }
    });
  }
}

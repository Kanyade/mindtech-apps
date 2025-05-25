import 'package:app_skeleton/core/di/di_module.dart';
import 'package:app_skeleton/core/services/clipboard/bloc.dart';
import 'package:app_skeleton/core/services/open_url/repository.dart';

class UserInteractionDiModule extends DiModule {
  const UserInteractionDiModule();

  @override
  void initializeModule(GetIt getIt) {
    getIt
      ..registerSingleton<OpenUrlRepository>(const OpenUrlRepository())
      ..registerSingleton<ClipboardRepository>(const ClipboardRepository())
      ..registerSingleton<ClipboardBloc>(ClipboardBloc(getIt.get<ClipboardRepository>()));
  }
}

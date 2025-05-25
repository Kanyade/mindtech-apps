import 'package:io_mindtechapps_hw/core/di/di_module.dart';
import 'package:io_mindtechapps_hw/core/services/clipboard/bloc.dart';
import 'package:io_mindtechapps_hw/core/services/open_url/repository.dart';

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

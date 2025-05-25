import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/string_extensions.dart';
import 'package:io_mindtechapps_hw/core/utils/logger.dart';

class MindtechAppBlocObserver extends BlocObserver {
  MindtechAppBlocObserver({required this.crashlytics});

  final CrashlyticsRepository crashlytics;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    MindtechAppLogger.logInfo('MindtechAppBlocObserver: onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    MindtechAppLogger.logInfo(
      'MindtechAppBlocObserver: onChange -- ${bloc.runtimeType}, ${change.toString().shorten(count: 256)}',
    );
  }

  @override
  Future<void> onError(BlocBase bloc, Object error, StackTrace stackTrace) async {
    MindtechAppLogger.logError(
      'MindtechAppBlocObserver: onError -- ${bloc.runtimeType}, $error -- ${stackTrace.toString()}',
    );

    crashlytics.recordError(exception: '${bloc.runtimeType}: $error', stackTrace: stackTrace).ignore();

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    MindtechAppLogger.logWarning('MindtechAppBlocObserver: onClose -- ${bloc.runtimeType}');
  }
}

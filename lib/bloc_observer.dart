import 'package:app_skeleton/core/services/crashlytics/repository.dart';
import 'package:app_skeleton/core/utils/extensions/string_extensions.dart';
import 'package:app_skeleton/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSkeletonBlocObserver extends BlocObserver {
  AppSkeletonBlocObserver({required this.crashlytics});

  final CrashlyticsRepository crashlytics;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    AppSkeletonLogger.logInfo('AppSkeletonBlocObserver: onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    AppSkeletonLogger.logInfo(
      'AppSkeletonBlocObserver: onChange -- ${bloc.runtimeType}, ${change.toString().shorten(count: 256)}',
    );
  }

  @override
  Future<void> onError(BlocBase bloc, Object error, StackTrace stackTrace) async {
    AppSkeletonLogger.logError(
      'AppSkeletonBlocObserver: onError -- ${bloc.runtimeType}, $error -- ${stackTrace.toString()}',
    );

    crashlytics.recordError(exception: '${bloc.runtimeType}: $error', stackTrace: stackTrace).ignore();

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    AppSkeletonLogger.logWarning('AppSkeletonBlocObserver: onClose -- ${bloc.runtimeType}');
  }
}

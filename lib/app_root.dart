// ignore_for_file: di_module_usage, discarded_futures

import 'package:app_skeleton/app/presentation/app_skeleton.dart';
import 'package:app_skeleton/core/di/di_module.dart';
import 'package:app_skeleton/core/router/router.dart';
import 'package:app_skeleton/core/services/analytics/repository.dart';
import 'package:app_skeleton/core/services/clipboard/bloc.dart';
import 'package:app_skeleton/core/services/crashlytics/repository.dart';
import 'package:app_skeleton/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();

  static void reset(BuildContext context) => context.findAncestorStateOfType<_AppRootState>()!.restartApp();
}

class _AppRootState extends State<AppRoot> {
  Key _key = UniqueKey();

  void restartApp() => setState(() => _key = UniqueKey());

  @override
  Widget build(BuildContext context) => KeyedSubtree(key: _key, child: const _BaseBlocsInserter());
}

class _BaseBlocsInserter extends HookWidget {
  const _BaseBlocsInserter();

  @override
  Widget build(BuildContext context) {
    final providers = useMemoized(_baseBlocProviders, []);
    final repositories = useMemoized(_baseRepositories, []);

    return MultiRepositoryProvider(
      key: const Key('UnauthenticatedBaseRepositories'),
      providers: repositories,
      child: MultiBlocProvider(
        key: const Key('UnauthenticatedBaseProviders'),
        providers: providers,
        child: AppSkeleton(router: DiModule.getObject<AppSkeletonRouter>()),
      ),
    );
  }

  List<BlocProvider> _baseBlocProviders() {
    AppSkeletonLogger.logInfo('Base bloc providers starting...');

    return [BlocProvider<ClipboardBloc>.value(value: DiModule.getObject<ClipboardBloc>())];
  }

  List<RepositoryProvider> _baseRepositories() {
    AppSkeletonLogger.logInfo('Base repository providers starting...');

    return [
      RepositoryProvider<AnalyticsRepository>.value(value: DiModule.getObject<AnalyticsRepository>()..init()),
      RepositoryProvider<CrashlyticsRepository>.value(
        value: DiModule.getObject<CrashlyticsRepository>()..initializeCrashlytics(),
      ),
    ];
  }
}

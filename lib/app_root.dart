// ignore_for_file: di_module_usage, discarded_futures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:io_mindtechapps_hw/app/presentation/mindtech_app.dart';
import 'package:io_mindtechapps_hw/core/authentication/authentication.dart';
import 'package:io_mindtechapps_hw/core/di/di_module.dart';
import 'package:io_mindtechapps_hw/core/router/router.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/clipboard/bloc.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/utils/logger.dart';

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
        child: MindtechApp(router: DiModule.getObject<MindtechAppRouter>()),
      ),
    );
  }

  List<BlocProvider> _baseBlocProviders() {
    MindtechAppLogger.logInfo('Base bloc providers starting...');

    return [
      BlocProvider<AuthenticationBloc>.value(value: DiModule.getObject<AuthenticationBloc>()),
      BlocProvider<ClipboardBloc>.value(value: DiModule.getObject<ClipboardBloc>()),
    ];
  }

  List<RepositoryProvider> _baseRepositories() {
    MindtechAppLogger.logInfo('Base repository providers starting...');

    return [
      RepositoryProvider<AnalyticsRepository>.value(value: DiModule.getObject<AnalyticsRepository>()..init()),
      RepositoryProvider<CrashlyticsRepository>.value(
        value: DiModule.getObject<CrashlyticsRepository>()..initializeCrashlytics(),
      ),
    ];
  }
}

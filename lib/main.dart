// ignore_for_file: bootstrap_import, di_module_usage

import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:io_mindtechapps_hw/app/presentation/restart/screen.dart';
import 'package:io_mindtechapps_hw/app_root.dart';
import 'package:io_mindtechapps_hw/bloc_observer.dart';
import 'package:io_mindtechapps_hw/bootstrap.dart';
import 'package:io_mindtechapps_hw/core/di/di_module.dart';
import 'package:io_mindtechapps_hw/core/resources/firebase_options/firebase_import.env.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/crashlytics.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/user_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  return AppInitializer.tryStartApp();
}

sealed class AppInitializer {
  static bool splashRemoved = false;
  static void tryRemoveSplash() {
    if (splashRemoved) return;
    splashRemoved = true;
    FlutterNativeSplash.remove();
  }

  static Future<void> tryStartApp() async {
    try {
      await _appInit();
      runApp(const AppRoot());
    } catch (e, st) {
      await _appDispose(e, st);
      tryRemoveSplash();
      runApp(const RestartAppScreen());
    }
  }

  static Future<void> _appInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    await Firebase.initializeApp(options: FirebaseImport.getCurrentPlatform);

    await Bootstrapper.initialize();
    Bloc.observer = MindtechAppBlocObserver(crashlytics: DiModule.getObject<CrashlyticsRepository>());

    await _initGlobalErrorReportingToCrashlytics();
  }

  static Future<void> _appDispose(Object exception, StackTrace st) async {
    WidgetsFlutterBinding.ensureInitialized();

    await DiModule.resetDependencies();
    await Firebase.initializeApp(options: FirebaseImport.getCurrentPlatform);

    const Crashlytics()
        .recordError(exception: exception, stackTrace: st, reason: 'Error while starting the app', fatal: true)
        .ignore();

    final storage = UserPreferences(const FlutterSecureStorage(), await SharedPreferences.getInstance());
    await Future.wait([storage.deleteAllEncrypted(), storage.deleteAllUnencrypted()]);
  }

  static Future<void> _initGlobalErrorReportingToCrashlytics() async {
    FlutterError.onError = DiModule.getObject<ICrashlytics>().recordFlutterFatalError;

    Isolate.current.addErrorListener(
      RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await const Crashlytics().recordError(
          exception: 'Non-Flutter error: ${errorAndStacktrace.first}',
          stackTrace: errorAndStacktrace.last,
          fatal: true,
        );
      }).sendPort,
    );
  }
}

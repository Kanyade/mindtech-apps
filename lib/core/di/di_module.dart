// ignore_for_file: get_it_import
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

export 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

abstract class DiModule {
  const DiModule();

  Future<void> initialize() async {
    initializeModule(_getIt);

    await _getIt.allReady();
  }

  @protected
  void initializeModule(GetIt getIt);

  static T getObject<T extends Object>({String? instanceName, dynamic param1, dynamic param2}) =>
      _getIt.get<T>(instanceName: instanceName, param1: param1, param2: param2);

  static Future<void> resetDependencies() async {
    await _getIt.reset();
  }
}

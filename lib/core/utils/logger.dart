import 'dart:developer';

import 'package:flutter/foundation.dart';

const bool _isVsCode = bool.fromEnvironment('vscode');

class MindtechAppLogger {
  static void logInfo(String msg) {
    if (!kDebugMode) return;

    _isVsCode ? log('${_LogColors.blue}$msg${_LogColors.reset}') : debugPrint('\u001B[36m$msg\u001B[0m');
  }

  static void logSuccess(String msg) {
    if (!kDebugMode) return;

    _isVsCode ? log('${_LogColors.green}$msg${_LogColors.reset}') : debugPrint('\u001B[32m$msg\u001B[0m');
  }

  static void logError(String msg) {
    if (!kDebugMode) return;

    _isVsCode ? log('${_LogColors.red}$msg${_LogColors.reset}') : debugPrint('\u001B[31m$msg\u001B[0m');
  }

  static void logWarning(String msg) {
    if (!kDebugMode) return;

    _isVsCode ? log('${_LogColors.yellow}$msg${_LogColors.reset}') : debugPrint('\u001B[31m$msg\u001B[0m');
  }
}

class _LogColors {
  static String reset = '\x1b[0m';
  static String red = '\x1b[31m';
  static String green = '\x1b[32m';
  static String yellow = '\x1b[33m';
  static String blue = '\x1b[34m';
}

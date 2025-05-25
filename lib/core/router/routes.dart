part of 'router.dart';

class Routes {
  static const start = '/start';
  static const account = '/account';
  static const loading = '/loading';
}

class AppRoute<ReturnType> {
  static const QUERY_INPUT_KEY = 'app-route-input';

  final String name;
  final Map<String, dynamic> queryParameters;

  const AppRoute._(this.name, {this.queryParameters = const {}});

  static AppRoute start() => const AppRoute._(Routes.start);
  static AppRoute account() => const AppRoute._(Routes.account);
  static AppRoute loading() => const AppRoute._(Routes.loading);
}

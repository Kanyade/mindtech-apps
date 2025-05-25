part of 'router.dart';

class Routes {
  // Unauthenticated routes section
  static const login = '/login';
  static const loading = '/loading';

  // Authenticated routes section
  static const transactions = '/transactions';
  static const settings = '/settings';
}

class AppRoute<ReturnType> {
  static const QUERY_INPUT_KEY = 'app-route-input';

  final String name;
  final Map<String, dynamic> queryParameters;

  const AppRoute._(this.name, {this.queryParameters = const {}});

  static AppRoute login() => const AppRoute._(Routes.login);
  static AppRoute loading() => const AppRoute._(Routes.loading);
  static AppRoute transactions() => const AppRoute._(Routes.transactions);
  static AppRoute settings() => const AppRoute._(Routes.settings);
}

part of 'router.dart';

class RoutesBuilder {
  const RoutesBuilder({required this.analyticsRepository});

  final AnalyticsRepository analyticsRepository;

  Widget bottomNavigationBuilder(StatefulNavigationShell navigationShell, List<BottomNavigationTab> tabs) {
    return BottomNavigationMenu(tabs: tabs, navigationShell: navigationShell, analyticsRepository: analyticsRepository);
  }

  Widget loadingScreenBuilder(BuildContext context, GoRouterState state) => const ColoredBox(
    color: Colors.white,
    child: Center(child: CircularProgressIndicator.adaptive()),
  );
  Widget loginScreenBuilder(BuildContext context, GoRouterState state) => const LoginScreen();
  Widget transactionsScreenBuilder(BuildContext context, GoRouterState state) => const TransactionsScreen();
  Widget settingsScreenBuilder(BuildContext context, GoRouterState state) => const SettingsScreen();
}

extension GoRouterStateExtension on GoRouterState {
  Map<String, dynamic> get input {
    return jsonDecode(uri.queryParameters[AppRoute.QUERY_INPUT_KEY]!);
  }
}

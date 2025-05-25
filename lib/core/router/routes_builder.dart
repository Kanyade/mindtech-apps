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
  Widget startScreenBuilder(BuildContext context, GoRouterState state) => const StartScreen();
  Widget accountScreenBuilder(BuildContext context, GoRouterState state) => const AccountScreen();
}

class GoRouteWrapper extends HookWidget {
  const GoRouteWrapper({super.key, required this.child, this.onInit, this.onAfterLayout, this.onDispose});

  final Widget child;
  final void Function()? onInit;
  final void Function()? onDispose;
  final void Function(BuildContext context)? onAfterLayout;

  VoidCallback? setup(BuildContext context) {
    onInit?.call();
    if (onAfterLayout != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => onAfterLayout?.call(context));
    }
    return onDispose;
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() => setup(context), const []);
    return child;
  }
}

extension GoRouterStateExtension on GoRouterState {
  Map<String, dynamic> get input {
    return jsonDecode(uri.queryParameters[AppRoute.QUERY_INPUT_KEY]!);
  }
}

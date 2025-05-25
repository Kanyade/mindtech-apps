import 'dart:async';

import 'package:app_skeleton/core/resources/app_resources.dart';
import 'package:app_skeleton/core/router/router.dart';
import 'package:app_skeleton/core/services/analytics/repository.dart';
import 'package:app_skeleton/core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationMenu extends HookWidget {
  const BottomNavigationMenu({
    super.key,
    required this.navigationShell,
    required this.tabs,
    required AnalyticsRepository analyticsRepository,
  }) : _analyticsRepository = analyticsRepository;

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;
  final List<BottomNavigationTab> tabs;
  final AnalyticsRepository _analyticsRepository;

  Dispose? checkAndLogBranchChange(
    BuildContext context,
    ObjectRef<Set<int>> visitedBranches,
    int currentIndex,
    ObjectRef<String?> lastScreen,
  ) {
    final screenName = GoRouter.of(context).state.fullPath;
    if (visitedBranches.value.contains(currentIndex)) {
      if (screenName != null) {
        unawaited(_analyticsRepository.setCurrentScreen(screenName));
        if (lastScreen.value != null) {
          unawaited(_analyticsRepository.logEvent(eventName: 'screen_leave', parameters: {'screen': lastScreen.value}));
        }
      }
    } else {
      visitedBranches.value.add(currentIndex);
      if (lastScreen.value != null) {
        unawaited(_analyticsRepository.logEvent(eventName: 'screen_leave', parameters: {'screen': lastScreen.value}));
      }
    }
    lastScreen.value = screenName;
    return null;
  }

  Dispose? updateLastScreen(String? currentPath, ObjectRef<String?> lastScreen) {
    lastScreen.value = currentPath;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;
    final currentPath = GoRouter.of(context).state.fullPath;
    final visitedBranches = useRef(<int>{});
    final lastScreen = useRef<String?>(null);

    // Order matters
    useEffect(() => checkAndLogBranchChange(context, visitedBranches, currentIndex, lastScreen), [currentIndex]);
    useEffect(() => updateLastScreen(currentPath, lastScreen), [currentPath]);

    final iconSize = AppDimensions.r24;

    return PopScope(
      canPop: false,
      child: Builder(
        builder: (context) => Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
            },
            unselectedLabelStyle: AppTextStyles.uiLabelSmall,
            selectedLabelStyle: AppTextStyles.uiLabelSmall,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.gray40,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            items: tabs
                .map((e) {
                  return switch (e) {
                    BottomNavigationTab.start => BottomNavigationBarItem(
                      label: 'Start'.hardCoded,
                      icon: Icon(Icons.home_outlined, size: iconSize, color: AppColors.gray75),
                      activeIcon: Icon(Icons.home_outlined, size: iconSize, color: AppColors.primary),
                    ),
                    BottomNavigationTab.account => BottomNavigationBarItem(
                      label: 'Account'.hardCoded,
                      icon: Icon(Icons.account_circle_outlined, size: iconSize, color: AppColors.gray75),
                      activeIcon: Icon(Icons.account_circle_outlined, size: iconSize, color: AppColors.primary),
                    ),
                  };
                })
                .toList(growable: false),
          ),
          body: navigationShell,
        ),
      ),
    );
  }
}

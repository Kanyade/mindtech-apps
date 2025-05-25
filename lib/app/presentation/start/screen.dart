import 'package:io_mindtechapps_hw/app/presentation/_components/base_screen.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      isRootScreen: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Welcome to App Skeleton', style: AppTextStyles.uiLabelLarge, textAlign: TextAlign.center)],
        ),
      ),
    );
  }
}

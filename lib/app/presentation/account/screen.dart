import 'package:app_skeleton/app/presentation/_components/base_screen.dart';
import 'package:app_skeleton/core/resources/app_resources.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      isRootScreen: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Account screen', style: AppTextStyles.uiLabelLarge, textAlign: TextAlign.center)],
        ),
      ),
    );
  }
}

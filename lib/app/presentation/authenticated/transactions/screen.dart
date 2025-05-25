import 'package:flutter/material.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/base_screen.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      isRootScreen: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Transactions screen', style: AppTextStyles.uiLabelLarge, textAlign: TextAlign.center)],
        ),
      ),
    );
  }
}

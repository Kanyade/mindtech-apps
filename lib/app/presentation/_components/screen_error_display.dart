import 'package:io_mindtechapps_hw/app/presentation/_components/app_button.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class ScreenErrorDisplay extends StatelessWidget {
  const ScreenErrorDisplay({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: AppDimensions.h12,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Oops, something went wrong...'.hardCoded, style: AppTextStyles.bodyBook),
          AppButton.filled(icon: const Icon(Icons.refresh), onPressed: onRetry, label: Text('Try again'.hardCoded)),
        ],
      ),
    );
  }
}

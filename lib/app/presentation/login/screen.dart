import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/app_button.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/base_screen.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/snackbar.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/unfocusing_tap_region.dart';
import 'package:io_mindtechapps_hw/core/authentication/authentication.dart';
import 'package:io_mindtechapps_hw/core/bloc_base/base_bloc.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:io_mindtechapps_hw/core/services/settings.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/string_extensions.dart';
import 'package:io_mindtechapps_hw/core/utils/format_validator.dart';
import 'package:io_mindtechapps_hw/core/utils/hooks/text_field_hooks.dart';

part '_components/footer.dart';
part '_components/form/buttons.dart';
part '_components/form/email_field.dart';
part '_components/form/form.dart';
part '_components/form/password_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.settings});

  final Settings settings;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      isRootScreen: true,
      body: Column(
        children: [
          Column(
            children: [
              Text('SimuBank', style: AppTextStyles.mobileHeadersHeaderMobile2),
              Text('Digital Banking'.hardCoded, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          SizedBox(height: AppDimensions.h32),
          const Expanded(child: _LoginForm()),
          _Footer(settings: settings),
        ],
      ),
    );
  }
}

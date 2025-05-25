import 'package:app_skeleton/app/presentation/_components/app_button.dart';
import 'package:app_skeleton/core/resources/app_resources.dart';
import 'package:app_skeleton/core/utils/extensions/string_extensions.dart';
import 'package:app_skeleton/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestartAppScreen extends StatelessWidget {
  const RestartAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
        ensureScreenSize: true,
        designSize: const Size(AppDimensions.UI_DESIGN_SIZE_WIDTH, AppDimensions.UI_DESIGN_SIZE_HEIGHT),
        minTextAdapt: true,
        fontSizeResolver: FontSizeResolvers.radius,
        builder: (context, _) => Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.w32),
              child: Center(
                child: Column(
                  spacing: AppDimensions.h16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Oops, something went wrong...'.hardCoded,
                      style: AppTextStyles.mobileTitlesTitleMobile2,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'An unexpected error occurred, please restart your app'.hardCoded,
                      style: AppTextStyles.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    AppButton.filled(onPressed: AppInitializer.tryStartApp, label: Text('Restart App'.hardCoded)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

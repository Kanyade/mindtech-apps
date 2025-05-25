import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:io_mindtechapps_hw/app/domain/user_settings/bloc/bloc.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/base_screen.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/screen_error_display.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/shimmer_container.dart';
import 'package:io_mindtechapps_hw/app_root.dart';
import 'package:io_mindtechapps_hw/core/authentication/authentication.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/string_extensions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserSettingsBloc>();

    return BaseScreen(
      isRootScreen: true,
      body: BlocBuilder<UserSettingsBloc, UserSettingsState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is UserSettingsErrorState) {
            return ScreenErrorDisplay(
              onRetry: () {
                bloc.add(const UserSettingsLoadEvent(forceRefresh: true));
              },
            );
          } else if (state is UserSettingsLoadedState) {
            final usersettings = state.settings;
            return Column(
              spacing: AppDimensions.h32,
              children: [
                Text(
                  'Settings'.hardCoded,
                  style: AppTextStyles.mobileHeadersHeaderMobile3.copyWith(color: AppColors.primary),
                ),
                Expanded(
                  child: SizedBox.expand(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            spacing: AppDimensions.h16,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _LabeledItem(label: 'User ID:'.hardCoded, value: usersettings.userId.toString()),
                              _LabeledItem(
                                label: 'Notifications enabled:'.hardCoded,
                                value: usersettings.notificationsEnabled ? 'Yes'.hardCoded : 'No'.hardCoded,
                              ),
                              _LabeledItem(label: 'Limit:'.hardCoded, value: usersettings.limit.toString()),
                              _LabeledItem(label: 'Currency:'.hardCoded, value: usersettings.currency.toString()),
                              _LabeledItem(
                                label: 'Biometrics enabled:'.hardCoded,
                                value: usersettings.biometricEnabled ? 'Yes'.hardCoded : 'No'.hardCoded,
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                            if (state is AuthenticationLoadedState) {
                              return ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(AppDimensions.r4),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: state.userAccount.profilePicture,
                                  width: AppDimensions.r120,
                                  height: AppDimensions.r120,
                                  progressIndicatorBuilder: (_, _, _) => const _ImagePlaceholder(),
                                  errorWidget: (_, _, _) => const _ImagePlaceholder(),
                                ),
                              );
                            } else {
                              return const _ImagePlaceholder();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationInitialState) {
                      AppRoot.reset(context);
                    }
                  },
                  child: GestureDetector(
                    onTap: () {
                      context.read<AuthenticationBloc>().add(const AuthenticationLogoutEvent());
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppDimensions.r8),
                        boxShadow: const [AppShadows.shadowDarkS10],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: AppDimensions.w16, vertical: AppDimensions.h12),
                      child: Center(
                        child: Text(
                          'Logout'.hardCoded,
                          style: AppTextStyles.uiLabel.copyWith(color: AppColors.warning),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return ShimmerContainer(height: AppDimensions.r120, width: AppDimensions.r120, radius: AppDimensions.r4);
  }
}

class _LabeledItem extends StatelessWidget {
  const _LabeledItem({required this.label, this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimensions.h4,
      children: [
        Text(label, style: AppTextStyles.uiLabelSmall.copyWith(color: AppColors.gray55)),
        Text(value ?? '-', style: AppTextStyles.uiLabelSmall),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:io_mindtechapps_hw/app/domain/transactions/bloc/bloc.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/base_screen.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/screen_error_display.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/shimmer_container.dart';
import 'package:io_mindtechapps_hw/core/authentication/authentication.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:io_mindtechapps_hw/core/utils/date_formatters.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/string_extensions.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TransactionsBloc>();

    return BaseScreen(
      isRootScreen: true,
      body: BlocBuilder<TransactionsBloc, TransactionsState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is TransactionsErrorState) {
            return ScreenErrorDisplay(onRetry: () => bloc.add(const TransactionsLoadEvent(forceRefresh: true)));
          } else if (state is TransactionsLoadedState) {
            return Column(
              spacing: AppDimensions.h32,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Transactions'.hardCoded, style: AppTextStyles.mobileHeadersHeaderMobile3)),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state is AuthenticationLoadedState) {
                      return Text.rich(
                        TextSpan(
                          text: 'Hello, ',
                          children: [
                            TextSpan(
                              text: '${state.userAccount.name}!',
                              style: AppTextStyles.mobileTitlesTitleMobile2.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        style: AppTextStyles.mobileTitlesTitleMobile2.copyWith(fontWeight: FontWeight.w400),
                      );
                    } else {
                      return ShimmerContainer(
                        height: AppDimensions.h48,
                        width: AppDimensions.w160,
                        radius: AppDimensions.r4,
                      );
                    }
                  },
                ),
                Expanded(
                  child: state.transactions.isNotEmpty
                      ? ListView.separated(
                          itemCount: state.transactions.length,
                          separatorBuilder: (_, _) =>
                              Divider(thickness: 0, indent: AppDimensions.w24, endIndent: AppDimensions.w24),
                          itemBuilder: (context, index) {
                            final transaction = state.transactions[index];
                            return ListTile(
                              title: Text(DateFormatters.yyyyMMdd.format(transaction.date)),
                              subtitle: Text(transaction.merchant),
                              trailing: Text(
                                '${transaction.amount.toStringAsFixed(2)} ${transaction.currency}',
                                style: AppTextStyles.uiLabelSmallBold.copyWith(
                                  color: transaction.amount < 0 ? AppColors.warning : AppColors.success,
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "You don't have any transactions yet. Check back later.".hardCoded,
                            style: AppTextStyles.bodyBook,
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

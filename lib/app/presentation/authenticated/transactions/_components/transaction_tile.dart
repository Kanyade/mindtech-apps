part of '../screen.dart';

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        unawaited(
          showModalBottomSheet(
            context: context,
            backgroundColor: AppColors.white,
            isScrollControlled: true,
            constraints: BoxConstraints(minHeight: AppDimensions.h160, maxHeight: AppDimensions.screenHeight * 0.85),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.r16))),
            builder: (context) => _SheetContent(transaction: transaction),
          ),
        );
      },
      title: Text(DateFormatters.yyyyMMdd.format(transaction.date)),
      subtitle: Text(transaction.merchant),
      trailing: _AmountText(amount: transaction.amount, currency: transaction.currency),
    );
  }
}

class _SheetContent extends StatelessWidget {
  const _SheetContent({required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: AppDimensions.h32,
          bottom: AppDimensions.h32,
          left: AppDimensions.w24,
          right: AppDimensions.w24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppDimensions.h32,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction details'.hardCoded,
              style: AppTextStyles.mobileHeadersHeaderMobile3.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Expanded(child: Text(transaction.description)),
                _AmountText(amount: transaction.amount, currency: transaction.currency),
              ],
            ),
            Column(
              children: [
                _RowItem(label: 'Date'.hardCoded, value: DateFormatters.yyyyMMdd.format(transaction.date)),
                _RowItem(label: 'Merchant'.hardCoded, value: transaction.merchant),
                _RowItem(label: 'Category'.hardCoded, value: transaction.category),
                _RowItem(label: 'To Account'.hardCoded, value: transaction.toAccount),
                _RowItem(label: 'From Account'.hardCoded, value: transaction.fromAccount),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Text(value),
      ],
    );
  }
}

class _AmountText extends StatelessWidget {
  const _AmountText({required this.amount, required this.currency});

  final double amount;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${amount.toStringAsFixed(2)} $currency',
      style: AppTextStyles.uiLabelSmallBold.copyWith(color: amount < 0 ? AppColors.warning : AppColors.success),
    );
  }
}

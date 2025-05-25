part of '../screen.dart';

class _Footer extends StatelessWidget {
  const _Footer({required this.settings});

  final Settings settings;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.viewInsetsOf(context).bottom < 70) return Text('© 2025 SimuBank - Ver. ${settings.appVersion}');
    return const SizedBox.shrink();
  }
}

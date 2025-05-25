part of '../screen.dart';

class _Footer extends StatelessWidget {
  const _Footer({required this.showText, required this.settings});

  final bool showText;
  final Settings settings;

  @override
  Widget build(BuildContext context) {
    if (showText) return Text('© 2025 SimuBank - Ver. ${settings.appVersion}');
    return const SizedBox.shrink();
  }
}

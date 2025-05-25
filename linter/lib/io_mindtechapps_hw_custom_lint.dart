import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:io_mindtechapps_hw_custom_lint/router_lint_rules.dart';

// This is the entrypoint of our custom linter
PluginBase createPlugin() => _Linter();

class _Linter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    const RouterGoUsageLint(),
    const RouterPopUsageLint(),
    const GetItImportLint(),
    const BootstrapImportLint(),
    const ScreenUtilUsageLint(),
    const DiModuleUsageLint(),
  ];
}

import 'package:app_skeleton_custom_lint/router_lint_rules.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

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

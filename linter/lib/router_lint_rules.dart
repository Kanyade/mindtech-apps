import 'package:analyzer/error/listener.dart';
import 'package:app_skeleton_custom_lint/extensions.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class RouterGoUsageLint extends DartLintRule {
  const RouterGoUsageLint() : super(code: _code);

  static const _code = LintCode(name: 'go_usage', problemMessage: 'You should use context.navigate instead of go');

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addMethodInvocation((node) {
      const forbiddenMethodNames = ['go', 'goNamed', 'push', 'pushNamed', 'pushReplacement', 'pushReplacementNamed'];
      final methodName = node.methodName.name;
      if (!forbiddenMethodNames.contains(methodName)) return;

      reporter.atNode(
        node,
        LintCode(
          name: 'go_usage',
          problemMessage: 'You should use context.navigate${methodName.capitalize()} instead of $methodName',
        ),
      );
    });
  }
}

class RouterPopUsageLint extends DartLintRule {
  const RouterPopUsageLint() : super(code: _code);

  static const _code = LintCode(name: 'pop_usage', problemMessage: 'You should use context.popNavigate instead of pop');

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addMethodInvocation((node) {
      const forbiddenMethodNames = ['pop'];
      final methodName = node.methodName.name;
      if (!forbiddenMethodNames.contains(methodName)) return;

      reporter.atNode(node, _code);
    });
  }
}

class GetItImportLint extends DartLintRule {
  const GetItImportLint() : super(code: _code);

  static const _code = LintCode(
    name: 'get_it_import',
    problemMessage: 'You should not import get_it freely in the code',
  );

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addImportDirective((node) {
      if (node.uri.stringValue == 'package:get_it/get_it.dart') {
        reporter.atNode(node, _code);
      }
    });
  }
}

class BootstrapImportLint extends DartLintRule {
  const BootstrapImportLint() : super(code: _code);

  static const _code = LintCode(
    name: 'bootstrap_import',
    problemMessage: 'You should not import bootstrap freely in the code',
  );

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addImportDirective((node) {
      if (node.uri.stringValue == 'package:app_skeleton/bootstrap.dart') {
        reporter.atNode(node, _code);
      }
    });
  }
}

class ScreenUtilUsageLint extends DartLintRule {
  const ScreenUtilUsageLint() : super(code: _code);

  static const _code = LintCode(
    name: 'screenutil_usage',
    problemMessage: 'You should not use ScreenUtil freely in the code. Use AppDimensions instead',
  );

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addInstanceCreationExpression((node) {
      final constructorElement = node.constructorName.staticElement;
      if (constructorElement?.enclosingElement3.name == 'ScreenUtil') {
        reporter.atNode(node, _code);
      }
    });
  }
}

class DiModuleUsageLint extends DartLintRule {
  const DiModuleUsageLint() : super(code: _code);

  static const _code = LintCode(
    name: 'di_module_usage',
    problemMessage: 'You should not use DiModule.getObject directly',
  );

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addMethodInvocation((node) {
      const forbiddenMethodNames = ['getObject'];
      final methodName = node.methodName.name;
      if (!forbiddenMethodNames.contains(methodName)) return;

      reporter.atNode(node, _code);
    });
  }
}

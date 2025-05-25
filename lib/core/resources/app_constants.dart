part of 'app_resources.dart';

enum AppFlavor { qa, prod }

sealed class AppConstants {
  static const storageDirectoryName = 'storage';
  static final kTestMode = Platform.environment.containsKey('FLUTTER_TEST');
  static const String compileFlavor = String.fromEnvironment('current_flavor', defaultValue: 'qa');
  static final AppFlavor flavor = AppFlavor.values.byName(compileFlavor);

  static const deeplinkAuthority = 'app.skeleton.com';
}

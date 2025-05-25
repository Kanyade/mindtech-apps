extension StringExtensions on String {
  String get snakeCase => trim().toLowerCase().replaceAll(' ', '_');

  String shorten({int count = 25}) => length > count ? '${substring(0, count - 1)}...' : this;

  String take(int maxLength) => (length <= maxLength) ? this : substring(0, maxLength);

  /// Used to find hardcoded texts easily when adding translations.
  /// Usage also removes warning for missing const keyword.
  String get hardCoded => this;
}

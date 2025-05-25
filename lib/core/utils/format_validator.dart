class FormatValidator {
  const FormatValidator._();

  static bool isValidEmail(String email) => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);

  static bool passwordLengthSatisfied(String password) => RegExp('.{8,}').hasMatch(password);

  static bool passwordNumberSatisfied(String password) => RegExp('[0-9]').hasMatch(password);

  static bool passwordUppercaseSatisfied(String password) => RegExp('[A-Z]').hasMatch(password);

  static bool passwordLowercaseSatisfied(String password) => RegExp('[a-z]').hasMatch(password);

  /// Either: ! @ # $ % ^ & * ( ) , . ? " : ; _ ~ + = { } | < > [ ] -
  static bool passwordSpecialCharacterSatisfied(String password) =>
      RegExp(r'[!@#$%^&*(),.?":;_~+={}|<>\[\]\-]').hasMatch(password);
}

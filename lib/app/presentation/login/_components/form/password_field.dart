part of '../../screen.dart';

class _PasswordField extends HookWidget {
  const _PasswordField({required this.enabled, required this.passwordHooks, required this.autoValidate});

  final bool enabled;
  final TextFieldHooks passwordHooks;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    final showPassword = useState(false);

    return UnfocusingTapRegion(
      focusNode: passwordHooks.focusNode,
      child: TextFormField(
        enabled: enabled,
        controller: passwordHooks.controller,
        focusNode: passwordHooks.focusNode,
        decoration: InputDecoration(hintText: 'Password'.hardCoded),
        obscureText: !showPassword.value,
        keyboardType: TextInputType.visiblePassword,
        autovalidateMode: autoValidate ? AutovalidateMode.onUserInteraction : null,
        validator: (_) {
          final input = passwordHooks.controller.text;
          // Login usually should not have more validations, only registration
          return input.isEmpty ? 'Password cannot be empty'.hardCoded : null;
        },
      ),
    );
  }
}

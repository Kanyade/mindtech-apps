part of '../../screen.dart';

class _EmailField extends StatelessWidget {
  const _EmailField({required this.enabled, required this.hooks, required this.autoValidate});

  final bool enabled;
  final TextFieldHooks hooks;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    return UnfocusingTapRegion(
      focusNode: hooks.focusNode,
      child: TextFormField(
        enabled: enabled,
        controller: hooks.controller,
        focusNode: hooks.focusNode,
        decoration: InputDecoration(hintText: 'Email'.hardCoded),
        keyboardType: TextInputType.emailAddress,
        autovalidateMode: autoValidate ? AutovalidateMode.onUserInteraction : null,
        validator: (_) {
          if (!FormatValidator.isValidEmail(hooks.controller.text)) {
            return 'Invalid email format'.hardCoded;
          }
          return null;
        },
      ),
    );
  }
}

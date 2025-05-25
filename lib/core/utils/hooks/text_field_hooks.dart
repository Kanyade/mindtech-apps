import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef TextFieldHooks = ({TextEditingController controller, FocusNode focusNode});

mixin TextFieldHooksMixin on HookWidget {
  TextFieldHooks useTextFieldHooks({String? initialValue}) {
    return (
      controller: useTextEditingController.fromValue(TextEditingValue(text: initialValue ?? '')),
      focusNode: useFocusNode(),
    );
  }
}

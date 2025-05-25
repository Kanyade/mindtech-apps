import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UnfocusingTapRegion extends HookWidget {
  const UnfocusingTapRegion({super.key, required this.focusNode, required this.child});

  final FocusNode focusNode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final lastOnTapOutside = useRef<Offset?>(null);

    return TapRegion(
      onTapOutside: (event) => lastOnTapOutside.value = event.position,
      onTapUpOutside: (event) {
        if (lastOnTapOutside.value != null) {
          final difference = event.position - lastOnTapOutside.value!;
          if (difference.distanceSquared < 100) {
            focusNode.unfocus();
          }
        }
        lastOnTapOutside.value = null;
      },
      child: child,
    );
  }
}

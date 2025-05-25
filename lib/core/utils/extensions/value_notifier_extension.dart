import 'package:flutter/material.dart';

extension Toggle on ValueNotifier<bool> {
  void toggle() => value = !value;
}

part of 'bloc.dart';

sealed class ClipboardState extends BaseState {
  const ClipboardState();
}

class InitializedClipboardState extends ClipboardState {
  const InitializedClipboardState();

  @override
  List<Object?> get props => [];
}

class GettingFromClipboardState extends ClipboardState {
  const GettingFromClipboardState();

  @override
  List<Object?> get props => [];
}

class CopyingToClipboardState extends ClipboardState {
  const CopyingToClipboardState();

  @override
  List<Object?> get props => [];
}

class TextCopiedClipboardState extends ClipboardState {
  const TextCopiedClipboardState({required this.text});

  final String text;

  @override
  List<Object?> get props => [text];
}

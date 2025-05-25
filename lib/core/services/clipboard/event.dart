part of 'bloc.dart';

sealed class ClipboardEvent implements BaseEvent {
  const ClipboardEvent();
}

class CopyToClipboardEvent extends ClipboardEvent {
  const CopyToClipboardEvent(this.text);

  final String text;
}

class GetFromClipboardEvent extends ClipboardEvent {
  const GetFromClipboardEvent();
}

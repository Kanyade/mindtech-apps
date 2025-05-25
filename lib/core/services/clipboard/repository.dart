part of 'bloc.dart';

class ClipboardRepository {
  const ClipboardRepository();

  Future<String> getClipboardString() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text ?? '';
  }

  Future<void> putClipboardString(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }
}

import 'package:flutter/services.dart';
import 'package:io_mindtechapps_hw/core/bloc_base/base_bloc.dart';

part 'event.dart';
part 'repository.dart';
part 'state.dart';

class ClipboardBloc extends BaseBloc<ClipboardEvent, ClipboardState> {
  final ClipboardRepository _clipboardRepository;

  ClipboardBloc(this._clipboardRepository) : super(const InitializedClipboardState()) {
    on<GetFromClipboardEvent>((_, emit) async {
      emit(const GettingFromClipboardState());
      final text = await _clipboardRepository.getClipboardString();
      emit(TextCopiedClipboardState(text: text));
    });
    on<CopyToClipboardEvent>((event, emit) async {
      emit(const CopyingToClipboardState());
      await _clipboardRepository.putClipboardString(event.text);
      emit(TextCopiedClipboardState(text: event.text));
    });
  }
}

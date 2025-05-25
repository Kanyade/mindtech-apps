import 'package:io_mindtechapps_hw/app/domain/transactions/bloc/models/model.jsn.dart';
import 'package:io_mindtechapps_hw/app/domain/transactions/repository.dart';
import 'package:io_mindtechapps_hw/core/bloc_base/base_bloc.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/safe_event_adding.dart';
import 'package:io_mindtechapps_hw/core/utils/result.dart';

part 'event.dart';
part 'state.dart';

class TransactionsBloc extends BaseBloc<TransactionsEvent, TransactionsState> with SafeAddingMixin {
  final TransactionsRepository _repository;

  TransactionsBloc(this._repository) : super(const TransactionsInitialState()) {
    on<TransactionsLoadEvent>((event, emit) async {
      if (event.forceRefresh || state is! TransactionsLoadedState) {
        emit(const TransactionsLoadingState());

        final result = await _repository.getTransactions(forceRefresh: event.forceRefresh);

        emitSafe(emit, switch (result) {
          ResultData<List<Transaction>, TransactionsError>(:final value) => TransactionsLoadedState(
            transactions: value,
          ),
          ResultError(:final exception) => TransactionsErrorState(exception: exception),
        });
      }
    });
  }
}

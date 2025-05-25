// ignore_for_file: get_it_import

import 'package:get_it/get_it.dart';

abstract interface class DisposableRefreshRepository implements DisposableRepository {
  const DisposableRefreshRepository();

  Future<void> refresh();
}

abstract interface class DisposableRepository implements Disposable {
  const DisposableRepository();
}

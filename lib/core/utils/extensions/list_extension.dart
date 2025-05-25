extension UnwrapList<T> on List<T?>? {
  List<T> unwrap() => (this ?? []).whereType<T>().toList();
}

extension UnwrapIterable<T> on Iterable<T?>? {
  List<T> unwrap() => (this ?? []).whereType<T>().toList();
}

extension MergeList<T> on List<T> {
  List<T> merge(List<T> items, {bool unique = false}) {
    final list = <T>[].followedBy(this).toList();
    if (unique) {
      for (final item in items) {
        if (!list.contains(item)) list.add(item);
      }
      return list;
    } else {
      return list.followedBy(items).toList();
    }
  }
}

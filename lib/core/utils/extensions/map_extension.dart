extension Merge<K, V> on Map<K, V> {
  Map<K, V> merge(Map<K, V>? other) => {...this}..addEntries(other?.entries ?? {});
}

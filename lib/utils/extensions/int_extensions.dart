extension IntExtensions on int {
  bool isIn(int fromInclusive, int toInclusive) =>
      this >= fromInclusive && this <= toInclusive;
}

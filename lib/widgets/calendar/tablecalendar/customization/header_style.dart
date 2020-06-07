part of table_calendar;

class HeaderStyle {

  final TextBuilder titleTextBuilder;

  /// Style for title Text (month-year) displayed in header.
  final TextStyle titleTextStyle;

  /// Inside padding of the whole header.
  final EdgeInsets headerPadding;

  /// Outside margin of the whole header.
  final EdgeInsets headerMargin;

  /// Inside padding for left chevron.
  final EdgeInsets leftChevronPadding;

  /// Inside padding for right chevron.
  final EdgeInsets rightChevronPadding;

  /// Outside margin for left chevron.
  final EdgeInsets leftChevronMargin;

  /// Outside margin for right chevron.
  final EdgeInsets rightChevronMargin;

  /// Icon used for left chevron.
  /// Defaults to black `Icons.chevron_left`.
  final Icon leftChevronIcon;

  /// Icon used for right chevron.
  /// Defaults to black `Icons.chevron_right`.
  final Icon rightChevronIcon;

  /// Header decoration, used to draw border or shadow or change color of the header
  /// Defaults to empty BoxDecoration.
  final BoxDecoration decoration;

  const HeaderStyle({
    this.titleTextBuilder,
    this.titleTextStyle = const TextStyle(fontSize: 17.0),
    this.headerMargin,
    this.headerPadding = const EdgeInsets.symmetric(vertical: 8.0),
    this.leftChevronPadding = const EdgeInsets.all(12.0),
    this.rightChevronPadding = const EdgeInsets.all(12.0),
    this.leftChevronMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.rightChevronMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.leftChevronIcon = const Icon(Icons.chevron_left, color: Colors.black),
    this.rightChevronIcon = const Icon(Icons.chevron_right, color: Colors.black),
    this.decoration = const BoxDecoration(),
  });
}

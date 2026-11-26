abstract final class HomeDateFormatter {
  static const String _apiDateSeparator = ', ';
  static const String _arabicComma = '،';
  static const String _latinComma = ',';

  /// Shortens the API's formatted delivery date, e.g. `Today, 13 Nov` →
  /// `Today, 13` (`اليوم، 13` in Arabic). Returns the input unchanged when it
  /// does not have the expected shape.
  static String shortDeliveryDate(String formattedDate, {required bool isRtl}) {
    final parts = formattedDate.split(_apiDateSeparator);
    if (parts.length < 2) return formattedDate;
    final day = parts.first;
    final dayOfMonth = parts[1].split(' ').first;
    final comma = isRtl ? _arabicComma : _latinComma;
    return '$day$comma $dayOfMonth';
  }
}

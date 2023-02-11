import 'dart:ui';

extension ColorUtils on Color {
  static Color fromHex(String value) {
    final intValue = int.parse('0xFF$value');
    return Color(intValue);
  }

  Color withAlphaPercent(int alphaPercent) {
    final alpha = (alphaPercent / 100 * 255).round();
    return withAlpha(alpha);
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

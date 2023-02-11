import 'dart:ui';

extension ColorUtils on Color {
  static Color fromHex(String value) {
    final intValue = int.parse('0xFF$value');
    return Color(intValue);
  }
}

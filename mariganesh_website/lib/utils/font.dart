import 'dart:ui';

class Font {
  static const Font fontSpringRegular = Font('Fontspring');
  static const Font fontSpringBold = Font('Fontspring-bold');

  final String _fontName;

  String get value => _fontName;

  // ignore: sort_constructors_first
  const Font(this._fontName);
}

class FontWeights {
  static const FontWeight bold = FontWeight.bold;
  static const FontWeight normal = FontWeight.normal;
}

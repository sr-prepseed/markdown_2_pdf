import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Predefined styles for PDF generation
class PdfStyles {
  static pw.Font? _regularFont;
  static pw.Font? _boldFont;
  static pw.Font? _italicFont;
  static pw.Font? _monospaceFont;

  /// Set fonts for the styles
  static void setFonts({
    pw.Font? regularFont,
    pw.Font? boldFont,
    pw.Font? italicFont,
    pw.Font? monospaceFont,
  }) {
    _regularFont = regularFont;
    _boldFont = boldFont;
    _italicFont = italicFont;
    _monospaceFont = monospaceFont;
  }

  static const PdfColor primaryColor = PdfColor.fromInt(0xFF2196F3);
  static const PdfColor secondaryColor = PdfColor.fromInt(0xFF757575);
  static const PdfColor textColor = PdfColor.fromInt(0xFF212121);
  static const PdfColor backgroundColor = PdfColor.fromInt(0xFFFFFFFF);
  static const PdfColor borderColor = PdfColor.fromInt(0xFFE0E0E0);

  /// Default text style
  static pw.TextStyle get defaultText => pw.TextStyle(
        fontSize: 12,
        color: textColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );

  /// Heading 1 style
  static pw.TextStyle get heading1 => pw.TextStyle(
        fontSize: 24,
        color: primaryColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Heading 2 style
  static pw.TextStyle get heading2 => pw.TextStyle(
        fontSize: 20,
        color: primaryColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Heading 3 style
  static pw.TextStyle get heading3 => pw.TextStyle(
        fontSize: 18,
        color: primaryColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Heading 4 style
  static pw.TextStyle get heading4 => pw.TextStyle(
        fontSize: 16,
        color: primaryColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Heading 5 style
  static pw.TextStyle get heading5 => pw.TextStyle(
        fontSize: 14,
        color: primaryColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Heading 6 style
  static pw.TextStyle get heading6 => pw.TextStyle(
        fontSize: 12,
        color: primaryColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Code style
  static pw.TextStyle get code => pw.TextStyle(
        fontSize: 10,
        color: PdfColor.fromInt(0xFFD32F2F),
        font: _monospaceFont,
        fontFallback:
            [_monospaceFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Blockquote style
  static pw.TextStyle get blockquote => pw.TextStyle(
        fontSize: 12,
        color: secondaryColor,
        font: _italicFont,
        fontFallback: [_italicFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Link style
  static pw.TextStyle get link => pw.TextStyle(
        fontSize: 12,
        color: primaryColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );

  /// Bold text style
  static pw.TextStyle get bold => pw.TextStyle(
        fontSize: 12,
        color: textColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Italic text style
  static pw.TextStyle get italic => pw.TextStyle(
        fontSize: 12,
        color: textColor,
        font: _italicFont,
        fontFallback: [_italicFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Table header style
  static pw.TextStyle get tableHeader => pw.TextStyle(
        fontSize: 12,
        color: backgroundColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Table cell style
  static pw.TextStyle get tableCell => pw.TextStyle(
        fontSize: 11,
        color: textColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );

  /// Header style
  static pw.TextStyle get header => pw.TextStyle(
        fontSize: 10,
        color: secondaryColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );

  /// Footer style
  static pw.TextStyle get footer => pw.TextStyle(
        fontSize: 10,
        color: secondaryColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );

  /// Page number style
  static pw.TextStyle get pageNumber => pw.TextStyle(
        fontSize: 10,
        color: secondaryColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );
}

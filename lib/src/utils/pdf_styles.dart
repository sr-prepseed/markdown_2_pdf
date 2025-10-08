import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/pdf_options.dart';

/// Predefined styles for PDF generation
class PdfStyles {
  static pw.Font? _regularFont;
  static pw.Font? _boldFont;
  static pw.Font? _italicFont;
  static pw.Font? _monospaceFont;
  static PdfTheme _theme = const PdfTheme();

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

  /// Set theme for the styles
  static void setTheme(PdfTheme theme) {
    _theme = theme;
  }

  /// Get current theme
  static PdfTheme get theme => _theme;

  /// Default text style
  static pw.TextStyle get defaultText => pw.TextStyle(
        fontSize: 12,
        color: _theme.textColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );

  /// Heading 1 style
  static pw.TextStyle get heading1 => pw.TextStyle(
        fontSize: 24,
        color: _theme.primaryColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Heading 2 style
  static pw.TextStyle get heading2 => pw.TextStyle(
        fontSize: 20,
        color: _theme.primaryColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Heading 3 style
  static pw.TextStyle get heading3 => pw.TextStyle(
        fontSize: 18,
        color: _theme.primaryColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Heading 4 style
  static pw.TextStyle get heading4 => pw.TextStyle(
        fontSize: 16,
        color: _theme.primaryColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Heading 5 style
  static pw.TextStyle get heading5 => pw.TextStyle(
        fontSize: 14,
        color: _theme.primaryColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Heading 6 style
  static pw.TextStyle get heading6 => pw.TextStyle(
        fontSize: 12,
        color: _theme.primaryColor,
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
        color: _theme.secondaryColor,
        font: _italicFont,
        fontFallback: [_italicFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Link style
  static pw.TextStyle get link => pw.TextStyle(
        fontSize: 12,
        color: _theme.primaryColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );

  /// Bold text style
  static pw.TextStyle get bold => pw.TextStyle(
        fontSize: 12,
        color: _theme.textColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Italic text style
  static pw.TextStyle get italic => pw.TextStyle(
        fontSize: 12,
        color: _theme.textColor,
        font: _italicFont,
        fontFallback: [_italicFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Table header style
  static pw.TextStyle get tableHeader => pw.TextStyle(
        fontSize: 12,
        color: _theme.backgroundColor,
        font: _boldFont,
        fontFallback: [_boldFont, _regularFont].whereType<pw.Font>().toList(),
      );

  /// Table cell style
  static pw.TextStyle get tableCell => pw.TextStyle(
        fontSize: 11,
        color: _theme.textColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );

  /// Header style
  static pw.TextStyle get header => pw.TextStyle(
        fontSize: 10,
        color: _theme.secondaryColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );

  /// Footer style
  static pw.TextStyle get footer => pw.TextStyle(
        fontSize: 10,
        color: _theme.secondaryColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );

  /// Page number style
  static pw.TextStyle get pageNumber => pw.TextStyle(
        fontSize: 10,
        color: _theme.secondaryColor,
        font: _regularFont,
        fontFallback: [_regularFont, _boldFont].whereType<pw.Font>().toList(),
      );
}

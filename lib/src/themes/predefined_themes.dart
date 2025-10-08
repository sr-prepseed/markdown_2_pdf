import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/pdf_options.dart';

/// Predefined themes for easy customization
class PredefinedThemes {
  /// Default blue theme
  static const PdfTheme defaultTheme = PdfTheme(
    primaryColor: PdfColor.fromInt(0xFF2196F3),
    secondaryColor: PdfColor.fromInt(0xFF757575),
    textColor: PdfColor.fromInt(0xFF212121),
    backgroundColor: PdfColor.fromInt(0xFFFFFFFF),
    borderColor: PdfColor.fromInt(0xFFE0E0E0),
    codeBackgroundColor: PdfColor.fromInt(0xFFF5F5F5),
    tableHeaderColor: PdfColor.fromInt(0xFF2196F3),
    blockquoteColor: PdfColor.fromInt(0xFF2196F3),
  );

  /// Dark theme
  static const PdfTheme darkTheme = PdfTheme(
    primaryColor: PdfColor.fromInt(0xFF64B5F6),
    secondaryColor: PdfColor.fromInt(0xFFB0BEC5),
    textColor: PdfColor.fromInt(0xFFE0E0E0),
    backgroundColor: PdfColor.fromInt(0xFF121212),
    borderColor: PdfColor.fromInt(0xFF424242),
    codeBackgroundColor: PdfColor.fromInt(0xFF1E1E1E),
    tableHeaderColor: PdfColor.fromInt(0xFF1976D2),
    blockquoteColor: PdfColor.fromInt(0xFF64B5F6),
  );

  /// Green theme
  static const PdfTheme greenTheme = PdfTheme(
    primaryColor: PdfColor.fromInt(0xFF4CAF50),
    secondaryColor: PdfColor.fromInt(0xFF757575),
    textColor: PdfColor.fromInt(0xFF212121),
    backgroundColor: PdfColor.fromInt(0xFFFFFFFF),
    borderColor: PdfColor.fromInt(0xFFE0E0E0),
    codeBackgroundColor: PdfColor.fromInt(0xFFF1F8E9),
    tableHeaderColor: PdfColor.fromInt(0xFF4CAF50),
    blockquoteColor: PdfColor.fromInt(0xFF4CAF50),
  );

  /// Purple theme
  static const PdfTheme purpleTheme = PdfTheme(
    primaryColor: PdfColor.fromInt(0xFF9C27B0),
    secondaryColor: PdfColor.fromInt(0xFF757575),
    textColor: PdfColor.fromInt(0xFF212121),
    backgroundColor: PdfColor.fromInt(0xFFFFFFFF),
    borderColor: PdfColor.fromInt(0xFFE0E0E0),
    codeBackgroundColor: PdfColor.fromInt(0xFFF3E5F5),
    tableHeaderColor: PdfColor.fromInt(0xFF9C27B0),
    blockquoteColor: PdfColor.fromInt(0xFF9C27B0),
  );

  /// Orange theme
  static const PdfTheme orangeTheme = PdfTheme(
    primaryColor: PdfColor.fromInt(0xFFFF9800),
    secondaryColor: PdfColor.fromInt(0xFF757575),
    textColor: PdfColor.fromInt(0xFF212121),
    backgroundColor: PdfColor.fromInt(0xFFFFFFFF),
    borderColor: PdfColor.fromInt(0xFFE0E0E0),
    codeBackgroundColor: PdfColor.fromInt(0xFFFFF3E0),
    tableHeaderColor: PdfColor.fromInt(0xFFFF9800),
    blockquoteColor: PdfColor.fromInt(0xFFFF9800),
  );

  /// Professional theme (minimal, clean)
  static const PdfTheme professionalTheme = PdfTheme(
    primaryColor: PdfColor.fromInt(0xFF2C3E50),
    secondaryColor: PdfColor.fromInt(0xFF7F8C8D),
    textColor: PdfColor.fromInt(0xFF2C3E50),
    backgroundColor: PdfColor.fromInt(0xFFFFFFFF),
    borderColor: PdfColor.fromInt(0xFFBDC3C7),
    codeBackgroundColor: PdfColor.fromInt(0xFFF8F9FA),
    tableHeaderColor: PdfColor.fromInt(0xFF34495E),
    blockquoteColor: PdfColor.fromInt(0xFF3498DB),
  );
}

/// Predefined font configurations
class PredefinedFonts {
  /// Default Roboto fonts
  static const PdfFonts defaultFonts = PdfFonts(
    regularFontFamily: 'Roboto',
    boldFontFamily: 'Roboto',
    italicFontFamily: 'Roboto',
    monospaceFontFamily: 'RobotoMono',
  );

  /// Open Sans fonts
  static const PdfFonts openSansFonts = PdfFonts(
    regularFontFamily: 'OpenSans',
    boldFontFamily: 'OpenSans',
    italicFontFamily: 'OpenSans',
    monospaceFontFamily: 'SourceCodePro',
  );

  /// Lato fonts
  static const PdfFonts latoFonts = PdfFonts(
    regularFontFamily: 'Lato',
    boldFontFamily: 'Lato',
    italicFontFamily: 'Lato',
    monospaceFontFamily: 'RobotoMono',
  );
}

/// Predefined table styles
class PredefinedTableStyles {
  /// Default table style
  static const TableStyle defaultTableStyle = TableStyle(
    showBorders: true,
    borderColor: PdfColor.fromInt(0xFFE0E0E0),
    headerBackgroundColor: PdfColor.fromInt(0xFF2196F3),
    headerTextColor: PdfColor.fromInt(0xFFFFFFFF),
    cellPadding: pw.EdgeInsets.all(8.0),
    alternateRowColors: false,
    alternateRowColor: PdfColor.fromInt(0xFFF5F5F5),
  );

  /// Minimal table style (no borders)
  static const TableStyle minimalTableStyle = TableStyle(
    showBorders: false,
    borderColor: PdfColor.fromInt(0xFFE0E0E0),
    headerBackgroundColor: PdfColor.fromInt(0xFFF5F5F5),
    headerTextColor: PdfColor.fromInt(0xFF212121),
    cellPadding: pw.EdgeInsets.all(8.0),
    alternateRowColors: true,
    alternateRowColor: PdfColor.fromInt(0xFFF9F9F9),
  );

  /// Professional table style
  static const TableStyle professionalTableStyle = TableStyle(
    showBorders: true,
    borderColor: PdfColor.fromInt(0xFFBDC3C7),
    headerBackgroundColor: PdfColor.fromInt(0xFF2C3E50),
    headerTextColor: PdfColor.fromInt(0xFFFFFFFF),
    cellPadding: pw.EdgeInsets.all(10.0),
    alternateRowColors: true,
    alternateRowColor: PdfColor.fromInt(0xFFF8F9FA),
  );
}

/// Predefined PDF options for common use cases
class PredefinedPdfOptions {
  /// Default options
  static const PdfOptions defaultOptions = PdfOptions(
    pageFormat: PdfPageFormat.a4,
    margins: pw.EdgeInsets.all(2.0),
    title: 'Document',
    creator: 'Markdown2PDF',
    includePageNumbers: true,
    includeTableOfContents: false,
    fontSize: 12.0,
    headingFontSize: 16.0,
    lineHeight: 1.4,
    debugMode: false,
    theme: PredefinedThemes.defaultTheme,
    fonts: PredefinedFonts.defaultFonts,
    tableStyle: PredefinedTableStyles.defaultTableStyle,
    customStyles: {},
    enableAdvancedTables: true,
    enableSyntaxHighlighting: false,
    pageBreakBeforeHeadings: false,
  );

  /// Professional document options
  static const PdfOptions professionalOptions = PdfOptions(
    pageFormat: PdfPageFormat.a4,
    margins: pw.EdgeInsets.all(2.0),
    title: 'Professional Document',
    creator: 'Markdown2PDF',
    includePageNumbers: true,
    includeTableOfContents: true,
    fontSize: 11.0,
    headingFontSize: 14.0,
    lineHeight: 1.5,
    debugMode: false,
    theme: PredefinedThemes.professionalTheme,
    fonts: PredefinedFonts.openSansFonts,
    tableStyle: PredefinedTableStyles.professionalTableStyle,
    customStyles: {},
    enableAdvancedTables: true,
    enableSyntaxHighlighting: false,
    pageBreakBeforeHeadings: true,
  );

  /// Academic paper options
  static const PdfOptions academicOptions = PdfOptions(
    pageFormat: PdfPageFormat.a4,
    margins: pw.EdgeInsets.all(2.0),
    title: 'Academic Paper',
    creator: 'Markdown2PDF',
    includePageNumbers: true,
    includeTableOfContents: true,
    fontSize: 12.0,
    headingFontSize: 14.0,
    lineHeight: 1.6,
    debugMode: false,
    theme: PredefinedThemes.defaultTheme,
    fonts: PredefinedFonts.defaultFonts,
    tableStyle: PredefinedTableStyles.defaultTableStyle,
    customStyles: {},
    enableAdvancedTables: true,
    enableSyntaxHighlighting: false,
    pageBreakBeforeHeadings: false,
  );

  /// Presentation options
  static const PdfOptions presentationOptions = PdfOptions(
    pageFormat: PdfPageFormat.a4,
    margins: pw.EdgeInsets.all(1.5),
    title: 'Presentation',
    creator: 'Markdown2PDF',
    includePageNumbers: true,
    includeTableOfContents: false,
    fontSize: 14.0,
    headingFontSize: 18.0,
    lineHeight: 1.3,
    debugMode: false,
    theme: PredefinedThemes.purpleTheme,
    fonts: PredefinedFonts.latoFonts,
    tableStyle: PredefinedTableStyles.minimalTableStyle,
    customStyles: {},
    enableAdvancedTables: true,
    enableSyntaxHighlighting: false,
    pageBreakBeforeHeadings: true,
  );
}

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Theme configuration for PDF styling
class PdfTheme {
  /// Primary color for headings and accents
  final PdfColor primaryColor;

  /// Secondary color for subheadings and secondary text
  final PdfColor secondaryColor;

  /// Text color for body content
  final PdfColor textColor;

  /// Background color for the document
  final PdfColor backgroundColor;

  /// Border color for tables, code blocks, etc.
  final PdfColor borderColor;

  /// Code block background color
  final PdfColor codeBackgroundColor;

  /// Table header background color
  final PdfColor tableHeaderColor;

  /// Blockquote border color
  final PdfColor blockquoteColor;

  const PdfTheme({
    this.primaryColor = const PdfColor.fromInt(0xFF2196F3),
    this.secondaryColor = const PdfColor.fromInt(0xFF757575),
    this.textColor = const PdfColor.fromInt(0xFF212121),
    this.backgroundColor = const PdfColor.fromInt(0xFFFFFFFF),
    this.borderColor = const PdfColor.fromInt(0xFFE0E0E0),
    this.codeBackgroundColor = const PdfColor.fromInt(0xFFF5F5F5),
    this.tableHeaderColor = const PdfColor.fromInt(0xFF2196F3),
    this.blockquoteColor = const PdfColor.fromInt(0xFF2196F3),
  });
}

/// Font configuration for PDF generation
class PdfFonts {
  /// Regular font family
  final String regularFontFamily;

  /// Bold font family
  final String boldFontFamily;

  /// Italic font family
  final String italicFontFamily;

  /// Monospace font family for code
  final String monospaceFontFamily;

  const PdfFonts({
    this.regularFontFamily = 'Roboto',
    this.boldFontFamily = 'Roboto',
    this.italicFontFamily = 'Roboto',
    this.monospaceFontFamily = 'RobotoMono',
  });
}

/// Table styling configuration
class TableStyle {
  /// Whether to show table borders
  final bool showBorders;

  /// Border color for tables
  final PdfColor borderColor;

  /// Header background color
  final PdfColor headerBackgroundColor;

  /// Header text color
  final PdfColor headerTextColor;

  /// Cell padding
  final pw.EdgeInsets cellPadding;

  /// Whether to alternate row colors
  final bool alternateRowColors;

  /// Alternate row background color
  final PdfColor alternateRowColor;

  const TableStyle({
    this.showBorders = true,
    this.borderColor = const PdfColor.fromInt(0xFFE0E0E0),
    this.headerBackgroundColor = const PdfColor.fromInt(0xFF2196F3),
    this.headerTextColor = const PdfColor.fromInt(0xFFFFFFFF),
    this.cellPadding = const pw.EdgeInsets.all(8.0),
    this.alternateRowColors = false,
    this.alternateRowColor = const PdfColor.fromInt(0xFFF5F5F5),
  });
}

/// Configuration options for PDF generation
class PdfOptions {
  /// Page format for the PDF
  final PdfPageFormat pageFormat;

  /// Page margins
  final pw.EdgeInsets margins;

  /// Title of the PDF document
  final String? title;

  /// Author of the PDF document
  final String? author;

  /// Subject of the PDF document
  final String? subject;

  /// Keywords for the PDF document
  final String? keywords;

  /// Creator of the PDF document
  final String? creator;

  /// Whether to include page numbers
  final bool includePageNumbers;

  /// Whether to include table of contents
  final bool includeTableOfContents;

  /// Custom header text
  final String? headerText;

  /// Custom footer text
  final String? footerText;

  /// Font size for body text
  final double fontSize;

  /// Font size for headings
  final double headingFontSize;

  /// Line height multiplier
  final double lineHeight;

  /// Whether to enable debug mode
  final bool debugMode;

  /// Theme configuration
  final PdfTheme theme;

  /// Font configuration
  final PdfFonts fonts;

  /// Table styling configuration
  final TableStyle tableStyle;

  /// Custom CSS-like styles for specific elements
  final Map<String, pw.TextStyle> customStyles;

  /// Whether to enable advanced table formatting
  final bool enableAdvancedTables;

  /// Whether to enable syntax highlighting for code blocks
  final bool enableSyntaxHighlighting;

  /// Whether to add page breaks before major headings
  final bool pageBreakBeforeHeadings;

  /// Custom header widget builder
  final pw.Widget Function(pw.Context context)? customHeader;

  /// Custom footer widget builder
  final pw.Widget Function(pw.Context context)? customFooter;

  const PdfOptions({
    this.pageFormat = PdfPageFormat.a4,
    this.margins = const pw.EdgeInsets.all(2.0),
    this.title,
    this.author,
    this.subject,
    this.keywords,
    this.creator = 'Markdown2PDF',
    this.includePageNumbers = true,
    this.includeTableOfContents = false,
    this.headerText,
    this.footerText,
    this.fontSize = 12.0,
    this.headingFontSize = 16.0,
    this.lineHeight = 1.4,
    this.debugMode = false,
    this.theme = const PdfTheme(),
    this.fonts = const PdfFonts(),
    this.tableStyle = const TableStyle(),
    this.customStyles = const {},
    this.enableAdvancedTables = true,
    this.enableSyntaxHighlighting = false,
    this.pageBreakBeforeHeadings = false,
    this.customHeader,
    this.customFooter,
  });

  /// Create a copy of this options with some fields overridden
  PdfOptions copyWith({
    PdfPageFormat? pageFormat,
    pw.EdgeInsets? margins,
    String? title,
    String? author,
    String? subject,
    String? keywords,
    String? creator,
    bool? includePageNumbers,
    bool? includeTableOfContents,
    String? headerText,
    String? footerText,
    double? fontSize,
    double? headingFontSize,
    double? lineHeight,
    bool? debugMode,
    PdfTheme? theme,
    PdfFonts? fonts,
    TableStyle? tableStyle,
    Map<String, pw.TextStyle>? customStyles,
    bool? enableAdvancedTables,
    bool? enableSyntaxHighlighting,
    bool? pageBreakBeforeHeadings,
    pw.Widget Function(pw.Context context)? customHeader,
    pw.Widget Function(pw.Context context)? customFooter,
  }) {
    return PdfOptions(
      pageFormat: pageFormat ?? this.pageFormat,
      margins: margins ?? this.margins,
      title: title ?? this.title,
      author: author ?? this.author,
      subject: subject ?? this.subject,
      keywords: keywords ?? this.keywords,
      creator: creator ?? this.creator,
      includePageNumbers: includePageNumbers ?? this.includePageNumbers,
      includeTableOfContents:
          includeTableOfContents ?? this.includeTableOfContents,
      headerText: headerText ?? this.headerText,
      footerText: footerText ?? this.footerText,
      fontSize: fontSize ?? this.fontSize,
      headingFontSize: headingFontSize ?? this.headingFontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      debugMode: debugMode ?? this.debugMode,
      theme: theme ?? this.theme,
      fonts: fonts ?? this.fonts,
      tableStyle: tableStyle ?? this.tableStyle,
      customStyles: customStyles ?? this.customStyles,
      enableAdvancedTables: enableAdvancedTables ?? this.enableAdvancedTables,
      enableSyntaxHighlighting:
          enableSyntaxHighlighting ?? this.enableSyntaxHighlighting,
      pageBreakBeforeHeadings:
          pageBreakBeforeHeadings ?? this.pageBreakBeforeHeadings,
      customHeader: customHeader ?? this.customHeader,
      customFooter: customFooter ?? this.customFooter,
    );
  }
}

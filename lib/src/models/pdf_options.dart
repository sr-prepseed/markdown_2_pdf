import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
    );
  }
}

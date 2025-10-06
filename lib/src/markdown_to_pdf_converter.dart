import 'dart:io';
import 'dart:typed_data';
import 'package:markdown/markdown.dart' as md;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'models/markdown_source.dart';
import 'models/pdf_options.dart';
import 'utils/pdf_styles.dart';

/// Main class for converting markdown to PDF
class MarkdownToPdfConverter {
  final PdfOptions _options;
  late pw.Document _document;
  late pw.Font _regularFont;
  late pw.Font _boldFont;
  late pw.Font _italicFont;
  late pw.Font _monospaceFont;

  MarkdownToPdfConverter({PdfOptions? options})
      : _options = options ?? const PdfOptions();

  /// Convert markdown from HTTP response to PDF and save to file
  Future<File> convertToFile(
    MarkdownSource source, {
    String? fileName,
  }) async {
    await _initializeFonts();
    await _buildDocument(source);

    final directory = await getApplicationDocumentsDirectory();
    final file =
        File('${directory.path}/${fileName ?? 'markdown_document.pdf'}');

    final pdfBytes = await _document.save();
    await file.writeAsBytes(pdfBytes);

    return file;
  }

  /// Convert markdown from HTTP response to PDF and return as bytes
  Future<Uint8List> convertToBytes(MarkdownSource source) async {
    await _initializeFonts();
    await _buildDocument(source);
    return await _document.save();
  }

  /// Convert markdown from HTTP response to PDF and share/print
  Future<void> convertAndShare(MarkdownSource source) async {
    await _initializeFonts();
    await _buildDocument(source);

    final pdfBytes = await _document.save();
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: _options.title ?? 'markdown_document.pdf',
    );
  }

  /// Convert markdown from HTTP response to PDF and print
  Future<void> convertAndPrint(MarkdownSource source) async {
    await _initializeFonts();
    await _buildDocument(source);

    final pdfBytes = await _document.save();
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }

  /// Initialize fonts for PDF generation
  Future<void> _initializeFonts() async {
    try {
      _regularFont = await PdfGoogleFonts.robotoRegular();
      _boldFont = await PdfGoogleFonts.robotoBold();
      _italicFont = await PdfGoogleFonts.robotoItalic();
      _monospaceFont = await PdfGoogleFonts.robotoRegular();
    } catch (e) {
      // Fallback to default fonts if Google Fonts fail
      _regularFont = await PdfGoogleFonts.openSansRegular();
      _boldFont = await PdfGoogleFonts.openSansBold();
      _italicFont = await PdfGoogleFonts.openSansItalic();
      _monospaceFont = await PdfGoogleFonts.openSansRegular();
    }

    // Set fonts in styles
    PdfStyles.setFonts(
      regularFont: _regularFont,
      boldFont: _boldFont,
      italicFont: _italicFont,
      monospaceFont: _monospaceFont,
    );
  }

  /// Build the PDF document from markdown source
  Future<void> _buildDocument(MarkdownSource source) async {
    _document = pw.Document();

    final markdownContent = await source.getContent();
    final document = md.Document();
    final nodes = document.parse(markdownContent);

    _document.addPage(
      pw.MultiPage(
        pageFormat: _options.pageFormat,
        margin: _options.margins,
        header: _options.headerText != null ? _buildHeader : null,
        footer: _buildFooter,
        build: (pw.Context context) {
          return _buildContent(nodes);
        },
      ),
    );
  }

  /// Build header for PDF pages
  pw.Widget _buildHeader(pw.Context context) {
    if (_options.headerText == null) return pw.Container();

    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.only(bottom: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfStyles.borderColor),
        ),
      ),
      child: pw.Text(
        _options.headerText!,
        style: PdfStyles.header,
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  /// Build footer for PDF pages
  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.only(top: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(color: PdfStyles.borderColor),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          if (_options.footerText != null)
            pw.Text(
              _options.footerText!,
              style: PdfStyles.footer,
            ),
          if (_options.includePageNumbers)
            pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: PdfStyles.pageNumber,
            ),
        ],
      ),
    );
  }

  /// Build content from markdown nodes
  List<pw.Widget> _buildContent(List<md.Node> nodes) {
    final widgets = <pw.Widget>[];

    for (final node in nodes) {
      final widget = _buildNode(node);
      if (widget != null) {
        widgets.add(widget);
      }
    }

    return widgets;
  }

  /// Build a single markdown node
  pw.Widget? _buildNode(md.Node node) {
    if (node is md.Element) {
      return _buildElement(node);
    } else if (node is md.Text) {
      return pw.Text(
        _sanitizeText(node.text),
        style: PdfStyles.defaultText,
      );
    }
    return null;
  }

  /// Sanitize text to handle special characters
  String _sanitizeText(String text) {
    return text
        .replaceAll('•', '-') // Replace bullet points with dashes
        .replaceAll('–', '-') // Replace en-dash with regular dash
        .replaceAll('—', '-') // Replace em-dash with regular dash
        .replaceAll('"', '"') // Replace smart quotes
        .replaceAll('"', '"')
        .replaceAll(''', "'")  // Replace smart apostrophes
        .replaceAll(''', "'");
  }

  /// Build an element from markdown
  pw.Widget? _buildElement(md.Element element) {
    switch (element.tag) {
      case 'h1':
        return pw.Padding(
          padding: const pw.EdgeInsets.only(top: 20, bottom: 10),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.heading1,
          ),
        );
      case 'h2':
        return pw.Padding(
          padding: const pw.EdgeInsets.only(top: 18, bottom: 8),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.heading2,
          ),
        );
      case 'h3':
        return pw.Padding(
          padding: const pw.EdgeInsets.only(top: 16, bottom: 6),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.heading3,
          ),
        );
      case 'h4':
        return pw.Padding(
          padding: const pw.EdgeInsets.only(top: 14, bottom: 4),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.heading4,
          ),
        );
      case 'h5':
        return pw.Padding(
          padding: const pw.EdgeInsets.only(top: 12, bottom: 4),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.heading5,
          ),
        );
      case 'h6':
        return pw.Padding(
          padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.heading6,
          ),
        );
      case 'p':
        return pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 8),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.defaultText,
          ),
        );
      case 'blockquote':
        return pw.Container(
          margin: const pw.EdgeInsets.only(left: 20, bottom: 8),
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            border: const pw.Border(
              left: pw.BorderSide(color: PdfStyles.primaryColor, width: 3),
            ),
          ),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.blockquote,
          ),
        );
      case 'code':
        return pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 8),
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: PdfColor.fromInt(0xFFF5F5F5),
            border: pw.Border.all(color: PdfStyles.borderColor),
          ),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.code,
          ),
        );
      case 'pre':
        return pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 8),
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: PdfColor.fromInt(0xFFF5F5F5),
            border: pw.Border.all(color: PdfStyles.borderColor),
          ),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.code,
          ),
        );
      case 'ul':
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: element.children
                  ?.map((child) => _buildNode(child))
                  .where((widget) => widget != null)
                  .cast<pw.Widget>()
                  .toList() ??
              [],
        );
      case 'ol':
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: element.children
                  ?.asMap()
                  .entries
                  .map((entry) => pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            '${entry.key + 1}. ',
                            style: PdfStyles.defaultText,
                          ),
                          pw.Expanded(
                            child: _buildNode(entry.value) ?? pw.Container(),
                          ),
                        ],
                      ))
                  .toList() ??
              [],
        );
      case 'li':
        return pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 4),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '- ',
                style: PdfStyles.defaultText,
              ),
              pw.Expanded(
                child: pw.Text(
                  _sanitizeText(element.textContent),
                  style: PdfStyles.defaultText,
                ),
              ),
            ],
          ),
        );
      case 'table':
        return _buildTable(element);
      case 'strong':
      case 'b':
        return pw.Text(
          element.textContent,
          style: PdfStyles.bold,
        );
      case 'em':
      case 'i':
        return pw.Text(
          element.textContent,
          style: PdfStyles.italic,
        );
      case 'a':
        return pw.Text(
          element.textContent,
          style: PdfStyles.link,
        );
      case 'hr':
        return pw.Container(
          margin: const pw.EdgeInsets.symmetric(vertical: 16),
          height: 1,
          color: PdfStyles.borderColor,
        );
      default:
        return pw.Text(
          element.textContent,
          style: PdfStyles.defaultText,
        );
    }
  }

  /// Build a table from markdown
  pw.Widget _buildTable(md.Element table) {
    final rows = <List<String>>[];

    for (final child in table.children ?? []) {
      if (child is md.Element && child.tag == 'tr') {
        final cells = <String>[];
        for (final cell in child.children ?? []) {
          if (cell is md.Element && (cell.tag == 'td' || cell.tag == 'th')) {
            cells.add(cell.textContent);
          }
        }
        rows.add(cells);
      }
    }

    if (rows.isEmpty) return pw.Container();

    return pw.Table(
      border: pw.TableBorder.all(color: PdfStyles.borderColor),
      columnWidths: {
        for (int i = 0; i < rows.first.length; i++)
          i: const pw.FlexColumnWidth(),
      },
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        return pw.TableRow(
          decoration: isHeader
              ? const pw.BoxDecoration(color: PdfStyles.primaryColor)
              : null,
          children: entry.value
              .map((cell) => pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      cell,
                      style: isHeader
                          ? PdfStyles.tableHeader
                          : PdfStyles.tableCell,
                    ),
                  ))
              .toList(),
        );
      }).toList(),
    );
  }
}

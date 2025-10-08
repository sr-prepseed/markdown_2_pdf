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
      // Try to load fonts based on configuration
      switch (_options.fonts.regularFontFamily.toLowerCase()) {
        case 'roboto':
          _regularFont = await PdfGoogleFonts.robotoRegular();
          break;
        case 'opensans':
          _regularFont = await PdfGoogleFonts.openSansRegular();
          break;
        case 'lato':
          _regularFont = await PdfGoogleFonts.latoRegular();
          break;
        default:
          _regularFont = await PdfGoogleFonts.robotoRegular();
      }

      switch (_options.fonts.boldFontFamily.toLowerCase()) {
        case 'roboto':
          _boldFont = await PdfGoogleFonts.robotoBold();
          break;
        case 'opensans':
          _boldFont = await PdfGoogleFonts.openSansBold();
          break;
        case 'lato':
          _boldFont = await PdfGoogleFonts.latoBold();
          break;
        default:
          _boldFont = await PdfGoogleFonts.robotoBold();
      }

      switch (_options.fonts.italicFontFamily.toLowerCase()) {
        case 'roboto':
          _italicFont = await PdfGoogleFonts.robotoItalic();
          break;
        case 'opensans':
          _italicFont = await PdfGoogleFonts.openSansItalic();
          break;
        case 'lato':
          _italicFont = await PdfGoogleFonts.latoItalic();
          break;
        default:
          _italicFont = await PdfGoogleFonts.robotoItalic();
      }

      switch (_options.fonts.monospaceFontFamily.toLowerCase()) {
        case 'robotomono':
          _monospaceFont = await PdfGoogleFonts.robotoMonoRegular();
          break;
        case 'sourcecodepro':
          _monospaceFont = await PdfGoogleFonts.sourceCodeProRegular();
          break;
        default:
          _monospaceFont = await PdfGoogleFonts.robotoMonoRegular();
      }
    } catch (e) {
      // Fallback to default fonts if Google Fonts fail
      _regularFont = await PdfGoogleFonts.openSansRegular();
      _boldFont = await PdfGoogleFonts.openSansBold();
      _italicFont = await PdfGoogleFonts.openSansItalic();
      _monospaceFont = await PdfGoogleFonts.openSansRegular();
    }

    // Set fonts and theme in styles
    PdfStyles.setFonts(
      regularFont: _regularFont,
      boldFont: _boldFont,
      italicFont: _italicFont,
      monospaceFont: _monospaceFont,
    );
    PdfStyles.setTheme(_options.theme);
  }

  /// Build the PDF document from markdown source
  Future<void> _buildDocument(MarkdownSource source) async {
    _document = pw.Document();

    final markdownContent = await source.getContent();
    final document = md.Document(
      extensionSet: md.ExtensionSet.gitHubFlavored,
    );
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
    // Use custom header if provided
    if (_options.customHeader != null) {
      return _options.customHeader!(context);
    }

    if (_options.headerText == null) return pw.Container();

    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.only(bottom: 10),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: _options.theme.borderColor),
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
    // Use custom footer if provided
    if (_options.customFooter != null) {
      return _options.customFooter!(context);
    }

    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.only(top: 10),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(color: _options.theme.borderColor),
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
        return pw.Container(
          margin: const pw.EdgeInsets.only(top: 24, bottom: 16),
          padding: const pw.EdgeInsets.only(bottom: 8),
          decoration: pw.BoxDecoration(
            border: pw.Border(
              bottom:
                  pw.BorderSide(color: _options.theme.primaryColor, width: 2),
            ),
          ),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.heading1,
          ),
        );
      case 'h2':
        return pw.Container(
          margin: const pw.EdgeInsets.only(top: 20, bottom: 12),
          padding: const pw.EdgeInsets.only(bottom: 6),
          decoration: pw.BoxDecoration(
            border: pw.Border(
              bottom:
                  pw.BorderSide(color: _options.theme.borderColor, width: 1),
            ),
          ),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.heading2,
          ),
        );
      case 'h3':
        return pw.Padding(
          padding: const pw.EdgeInsets.only(top: 16, bottom: 8),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.heading3,
          ),
        );
      case 'h4':
        return pw.Padding(
          padding: const pw.EdgeInsets.only(top: 14, bottom: 6),
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
          margin: const pw.EdgeInsets.only(left: 20, bottom: 12),
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            border: pw.Border(
              left: pw.BorderSide(
                  color: _options.theme.blockquoteColor, width: 4),
            ),
            color: _options.theme.backgroundColor,
          ),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.blockquote,
          ),
        );
      case 'code':
        return pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 8),
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: pw.BoxDecoration(
            color: _options.theme.codeBackgroundColor,
            border: pw.Border.all(color: _options.theme.borderColor),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Text(
            _sanitizeText(element.textContent),
            style: PdfStyles.code,
          ),
        );
      case 'pre':
        return pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 16),
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: _options.theme.codeBackgroundColor,
            border: pw.Border.all(color: _options.theme.borderColor),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
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
          margin: const pw.EdgeInsets.symmetric(vertical: 20),
          height: 2,
          decoration: pw.BoxDecoration(
            gradient: pw.LinearGradient(
              colors: [
                _options.theme.borderColor,
                _options.theme.primaryColor,
                _options.theme.borderColor,
              ],
            ),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(1)),
          ),
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
    final rows = <List<Map<String, dynamic>>>[];

    // Handle GitHub Flavored markdown table structure
    for (final child in table.children ?? []) {
      if (child is md.Element &&
          (child.tag == 'thead' || child.tag == 'tbody')) {
        for (final row in child.children ?? []) {
          if (row is md.Element && row.tag == 'tr') {
            final cells = <Map<String, dynamic>>[];
            for (final cell in row.children ?? []) {
              if (cell is md.Element &&
                  (cell.tag == 'td' || cell.tag == 'th')) {
                cells.add({
                  'content': cell.textContent,
                  'isHeader': cell.tag == 'th' || child.tag == 'thead',
                  'alignment': _getCellAlignment(cell),
                });
              }
            }
            if (cells.isNotEmpty) {
              rows.add(cells);
            }
          }
        }
      } else if (child is md.Element && child.tag == 'tr') {
        // Fallback for direct tr elements
        final cells = <Map<String, dynamic>>[];
        for (final cell in child.children ?? []) {
          if (cell is md.Element && (cell.tag == 'td' || cell.tag == 'th')) {
            cells.add({
              'content': cell.textContent,
              'isHeader': cell.tag == 'th',
              'alignment': _getCellAlignment(cell),
            });
          }
        }
        if (cells.isNotEmpty) {
          rows.add(cells);
        }
      }
    }

    if (rows.isEmpty) return pw.Container();

    // Calculate column widths based on content
    final columnWidths = _calculateColumnWidths(rows);

    // Build table with advanced styling
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 16),
      child: pw.Table(
        border: _options.tableStyle.showBorders
            ? pw.TableBorder.all(color: _options.tableStyle.borderColor)
            : null,
        columnWidths: columnWidths,
        children: rows.asMap().entries.map((entry) {
          final rowIndex = entry.key;
          final cells = entry.value;
          final isHeaderRow = rowIndex == 0;

          return pw.TableRow(
            decoration: _getRowDecoration(rowIndex, isHeaderRow),
            children: cells
                .map((cell) => _buildTableCell(cell, isHeaderRow))
                .toList(),
          );
        }).toList(),
      ),
    );
  }

  /// Calculate optimal column widths based on content
  Map<int, pw.TableColumnWidth> _calculateColumnWidths(
      List<List<Map<String, dynamic>>> rows) {
    if (rows.isEmpty) return {};

    final columnCount = rows.first.length;
    final columnWidths = <int, pw.TableColumnWidth>{};

    if (_options.enableAdvancedTables) {
      // Calculate content-based widths
      final maxLengths = List<int>.filled(columnCount, 0);

      for (final row in rows) {
        for (int i = 0; i < row.length && i < columnCount; i++) {
          final contentLength = row[i]['content'].toString().length;
          if (contentLength > maxLengths[i]) {
            maxLengths[i] = contentLength;
          }
        }
      }

      final totalLength = maxLengths.reduce((a, b) => a + b);

      for (int i = 0; i < columnCount; i++) {
        if (totalLength > 0) {
          final ratio = maxLengths[i] / totalLength;
          columnWidths[i] = pw.FlexColumnWidth(ratio);
        } else {
          columnWidths[i] = const pw.FlexColumnWidth(1.0);
        }
      }
    } else {
      // Use equal width columns
      for (int i = 0; i < columnCount; i++) {
        columnWidths[i] = const pw.FlexColumnWidth(1.0);
      }
    }

    return columnWidths;
  }

  /// Get row decoration based on styling options
  pw.BoxDecoration? _getRowDecoration(int rowIndex, bool isHeaderRow) {
    if (isHeaderRow) {
      return pw.BoxDecoration(
        color: _options.tableStyle.headerBackgroundColor,
      );
    }

    if (_options.tableStyle.alternateRowColors && rowIndex % 2 == 1) {
      return pw.BoxDecoration(
        color: _options.tableStyle.alternateRowColor,
      );
    }

    return null;
  }

  /// Build individual table cell
  pw.Widget _buildTableCell(Map<String, dynamic> cell, bool isHeaderRow) {
    final content = cell['content'].toString();
    final isHeader = cell['isHeader'] as bool || isHeaderRow;
    final alignment = cell['alignment'] as pw.TextAlign;

    return pw.Padding(
      padding: _options.tableStyle.cellPadding,
      child: pw.Text(
        content,
        style: isHeader
            ? PdfStyles.tableHeader
                .copyWith(color: _options.tableStyle.headerTextColor)
            : PdfStyles.tableCell,
        textAlign: alignment,
      ),
    );
  }

  /// Get cell alignment from markdown attributes
  pw.TextAlign _getCellAlignment(md.Element cell) {
    // Check for alignment attributes in the cell
    final attributes = cell.attributes;
    final align = attributes['align']?.toLowerCase();
    switch (align) {
      case 'left':
        return pw.TextAlign.left;
      case 'center':
        return pw.TextAlign.center;
      case 'right':
        return pw.TextAlign.right;
      case 'justify':
        return pw.TextAlign.justify;
      default:
        return pw.TextAlign.left;
    }
  }
}

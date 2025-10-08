# Markdown2PDF

A powerful Flutter package for converting markdown content to beautifully formatted PDFs with advanced customization options.

## Features

- **Convert markdown** from HTTP URLs, strings, or HTTP responses to PDF
- **Highly customizable** themes and styling with predefined options
- **Advanced table formatting** with professional styling and alignment
- **Beautiful default design** with improved visual hierarchy
- **Multiple font families** (Roboto, Open Sans, Lato, etc.)
- **Share and print PDFs** directly
- **Extensive customization options** for every aspect
- **Well-tested** with comprehensive test coverage
- **Easy-to-use API** with predefined configurations

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  markdown_2_pdf: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:markdown_2_pdf/markdown_2_pdf.dart';

// Convert from URL
final source = HttpMarkdownSource(url: 'https://example.com/README.md');
final converter = MarkdownToPdfConverter();

// Save to file
final file = await converter.convertToFile(source, fileName: 'document.pdf');

// Or share directly
await converter.convertAndShare(source);
```

### Convert from String

```dart
final markdownContent = '''
# My Document

This is a **bold** text and this is *italic*.

## Features
- Feature 1
- Feature 2
- Feature 3

### Code Example
```dart
void main() {
  print('Hello, World!');
}
```
''';

final source = StringMarkdownSource(markdownContent);
final converter = MarkdownToPdfConverter();
await converter.convertAndShare(source);
```

### Using Predefined Themes

```dart
// Use predefined professional theme
final converter = MarkdownToPdfConverter(
  options: PredefinedPdfOptions.professionalOptions.copyWith(
    title: 'My Professional Document',
    author: 'John Doe',
  ),
);

// Use custom theme
final customTheme = const PdfTheme(
  primaryColor: PdfColor.fromInt(0xFF4CAF50),
  secondaryColor: PdfColor.fromInt(0xFF757575),
  textColor: PdfColor.fromInt(0xFF212121),
  backgroundColor: PdfColor.fromInt(0xFFFFFFFF),
  borderColor: PdfColor.fromInt(0xFFE0E0E0),
  codeBackgroundColor: PdfColor.fromInt(0xFFF1F8E9),
  tableHeaderColor: PdfColor.fromInt(0xFF4CAF50),
  blockquoteColor: PdfColor.fromInt(0xFF4CAF50),
);

final options = const PdfOptions(
  title: 'My Custom Document',
  author: 'John Doe',
  pageFormat: PdfPageFormat.a4,
  fontSize: 14.0,
  includePageNumbers: true,
  headerText: 'Company Document',
  footerText: 'Confidential',
  theme: customTheme,
  fonts: PdfFonts(
    regularFontFamily: 'Lato',
    boldFontFamily: 'Lato',
    italicFontFamily: 'Lato',
    monospaceFontFamily: 'SourceCodePro',
  ),
  tableStyle: TableStyle(
    showBorders: true,
    headerBackgroundColor: PdfColor.fromInt(0xFF4CAF50),
    headerTextColor: PdfColor.fromInt(0xFFFFFFFF),
    alternateRowColors: true,
    alternateRowColor: PdfColor.fromInt(0xFFF1F8E9),
  ),
);

final converter = MarkdownToPdfConverter(options: options);
```

### HTTP with Custom Headers

```dart
final source = HttpMarkdownSource(
  url: 'https://api.github.com/repos/user/repo/contents/README.md',
  headers: {
    'Authorization': 'Bearer your-token',
    'Accept': 'application/vnd.github.v3.raw',
  },
  timeout: const Duration(seconds: 30),
);

final converter = MarkdownToPdfConverter();
await converter.convertAndShare(source);
```

## API Reference

### MarkdownToPdfConverter

Main class for converting markdown to PDF.

#### Methods

- `convertToFile(MarkdownSource source, {String? fileName})` - Convert to PDF file
- `convertToBytes(MarkdownSource source)` - Convert to PDF bytes
- `convertAndShare(MarkdownSource source)` - Convert and share PDF
- `convertAndPrint(MarkdownSource source)` - Convert and print PDF

### MarkdownSource

Abstract class for markdown content sources.

#### Implementations

- `HttpMarkdownSource` - Fetch markdown from HTTP URL
- `StringMarkdownSource` - Use markdown from string
- `HttpResponseMarkdownSource` - Use markdown from HTTP response

### PdfOptions

Configuration options for PDF generation.

#### Basic Properties

- `pageFormat` - PDF page format (default: A4)
- `margins` - Page margins
- `title` - Document title
- `author` - Document author
- `subject` - Document subject
- `keywords` - Document keywords
- `creator` - Document creator
- `includePageNumbers` - Include page numbers (default: true)
- `includeTableOfContents` - Include table of contents (default: false)
- `headerText` - Custom header text
- `footerText` - Custom footer text
- `fontSize` - Body text font size (default: 12.0)
- `headingFontSize` - Heading font size (default: 16.0)
- `lineHeight` - Line height multiplier (default: 1.4)
- `debugMode` - Enable debug mode (default: false)

#### Advanced Properties

- `theme` - PdfTheme configuration for colors and styling
- `fonts` - PdfFonts configuration for font families
- `tableStyle` - TableStyle configuration for table appearance
- `customStyles` - Map of custom CSS-like styles for specific elements
- `enableAdvancedTables` - Enable advanced table formatting (default: true)
- `enableSyntaxHighlighting` - Enable syntax highlighting for code blocks (default: false)
- `pageBreakBeforeHeadings` - Add page breaks before major headings (default: false)
- `customHeader` - Custom header widget builder function
- `customFooter` - Custom footer widget builder function

### Predefined Themes

The package includes several predefined themes for quick setup:

- `PredefinedThemes.defaultTheme` - Default blue theme
- `PredefinedThemes.darkTheme` - Dark theme
- `PredefinedThemes.greenTheme` - Green theme
- `PredefinedThemes.purpleTheme` - Purple theme
- `PredefinedThemes.orangeTheme` - Orange theme
- `PredefinedThemes.professionalTheme` - Professional minimal theme

### Predefined Fonts

- `PredefinedFonts.defaultFonts` - Roboto fonts
- `PredefinedFonts.openSansFonts` - Open Sans fonts
- `PredefinedFonts.latoFonts` - Lato fonts

### Predefined Table Styles

- `PredefinedTableStyles.defaultTableStyle` - Default table with borders
- `PredefinedTableStyles.minimalTableStyle` - Minimal table without borders
- `PredefinedTableStyles.professionalTableStyle` - Professional table styling

### Predefined PDF Options

- `PredefinedPdfOptions.defaultOptions` - Default configuration
- `PredefinedPdfOptions.professionalOptions` - Professional document settings
- `PredefinedPdfOptions.academicOptions` - Academic paper settings
- `PredefinedPdfOptions.presentationOptions` - Presentation settings

## Supported Markdown Features

- **Headers (H1-H6)** with enhanced styling and visual hierarchy
- **Bold and italic text** with proper font rendering
- **Code blocks and inline code** with syntax highlighting support
- **Lists (ordered and unordered)** with proper indentation
- **Advanced tables** with professional formatting, borders, and alignment
- **Blockquotes** with beautiful styling and borders
- **Links** with proper color coding
- **Horizontal rules** with gradient styling
- **Line breaks** and paragraph spacing
- **Custom styling** for all elements

## Permissions

### Android

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

### iOS

Add to `ios/Runner/Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## Example App

Check out the example app in the `example/` directory to see the package in action.

```bash
cd example
flutter run
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

### 2.0.0 (Enhanced Version)
- **Highly customizable themes** with predefined options
- **Advanced table formatting** with professional styling
- **Beautiful default design** with improved visual hierarchy
- **Multiple font families** (Roboto, Open Sans, Lato, Source Code Pro)
- **Extensive customization options** for every aspect
- **Predefined configurations** for quick setup
- **Enhanced styling** for all markdown elements
- **Custom header/footer builders** for advanced layouts

### 1.0.0
- Initial release
- Support for HTTP and string markdown sources
- Basic PDF formatting
- Customizable PDF options
- Share and print functionality

# Markdown2PDF

A Flutter package for converting markdown content from HTTP responses to PDF with proper formatting.

## Features

- 📄 Convert markdown from HTTP URLs to PDF
- 📝 Convert markdown from strings to PDF
- 🎨 Beautiful PDF formatting with customizable styles
- 📊 Support for tables, code blocks, lists, and more
- 🔗 HTTP response handling with timeout and headers
- 📱 Share and print PDFs directly
- ⚙️ Highly customizable PDF options
- 🧪 Well-tested with comprehensive test coverage

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

### Custom PDF Options

```dart
final options = const PdfOptions(
  title: 'My Custom Document',
  author: 'John Doe',
  pageFormat: PdfPageFormat.a4,
  fontSize: 14.0,
  includePageNumbers: true,
  headerText: 'Company Document',
  footerText: 'Confidential',
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

#### Properties

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

## Supported Markdown Features

- ✅ Headers (H1-H6)
- ✅ Bold and italic text
- ✅ Code blocks and inline code
- ✅ Lists (ordered and unordered)
- ✅ Tables
- ✅ Blockquotes
- ✅ Links
- ✅ Horizontal rules
- ✅ Line breaks

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

### 1.0.0
- Initial release
- Support for HTTP and string markdown sources
- Comprehensive PDF formatting
- Customizable PDF options
- Share and print functionality

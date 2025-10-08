import 'package:flutter/material.dart';
import 'package:markdown_2_pdf/markdown_2_pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markdown2PDF Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Markdown2PDF Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _markdownController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Example markdown content with enhanced features
    _markdownController.text = '''
# Enhanced Markdown Document

This is a **comprehensive sample** that demonstrates the new features and improved formatting.

## Key Features

- **Bold text** and *italic text*
- `Inline code` and code blocks
- [External links](https://example.com)
- Advanced table formatting
- Beautiful blockquotes
- Custom themes and styling

### Code Examples

Here's some inline `code` and a code block:

```dart
class MarkdownToPdfConverter {
  final PdfOptions options;
  
  Future<File> convertToFile(MarkdownSource source) async {
    // Implementation here
    return file;
  }
}
```

### Advanced Table

| Feature | Status | Priority | Notes |
|---------|--------|----------|-------|
| Custom Themes | [OK] | High | Multiple predefined themes |
| Advanced Tables | [OK] | High | Better formatting and styling |
| Font Customization | [OK] | Medium | Multiple font families |
| Table Styling | [OK] | High | Borders, colors, alignment |
| Code Highlighting | [WIP] | Low | Coming soon |

### Blockquote Examples

> This is a beautiful blockquote with enhanced styling.
> It demonstrates the improved visual design.

> Another blockquote to show the consistent styling
> across different elements.

### Lists

#### Unordered List
- First item
- Second item with **bold text**
- Third item with *italic text*
- Fourth item with `code`

#### Ordered List
1. First numbered item
2. Second numbered item
3. Third numbered item with [link](https://example.com)

---

## Conclusion

This enhanced package now provides:
- **Highly customizable** themes and styling
- **Professional table formatting** with advanced options
- **Beautiful default design** with improved visual hierarchy
- **Multiple predefined themes** for quick setup
- **Flexible font configuration** with multiple families

**End of enhanced document**
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Convert Markdown to PDF',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // URL Input Section
            const Text(
              'From URL:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                hintText:
                    'Enter markdown URL (e.g., https://raw.githubusercontent.com/user/repo/main/README.md)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _convertFromUrl,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Convert from URL'),
            ),

            const SizedBox(height: 30),

            // Direct Markdown Input Section
            const Text(
              'From Text:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _markdownController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: 'Enter markdown content here...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _convertFromText,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Convert from Text'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _convertFromUrl() async {
    if (_urlController.text.isEmpty) {
      _showSnackBar('Please enter a URL');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final source = HttpMarkdownSource(url: _urlController.text);
      final converter = MarkdownToPdfConverter(
        options: PredefinedPdfOptions.professionalOptions.copyWith(
          title: 'Document from URL',
          author: 'Markdown2PDF',
        ),
      );

      await converter.convertAndShare(source);
      _showSnackBar('PDF generated successfully!');
    } catch (e) {
      _showSnackBar('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _convertFromText() async {
    if (_markdownController.text.isEmpty) {
      _showSnackBar('Please enter markdown content');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final source = StringMarkdownSource(_markdownController.text);
      final converter = MarkdownToPdfConverter(
        options: PredefinedPdfOptions.defaultOptions.copyWith(
          title: 'Enhanced Document',
          author: 'Markdown2PDF',
          headerText: 'Generated Document',
          footerText: 'Created with Enhanced Markdown2PDF',
          theme: PredefinedThemes.greenTheme,
          tableStyle: PredefinedTableStyles.professionalTableStyle,
        ),
      );

      await converter.convertAndShare(source);
      _showSnackBar('PDF generated successfully!');
    } catch (e) {
      _showSnackBar('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    _markdownController.dispose();
    super.dispose();
  }
}

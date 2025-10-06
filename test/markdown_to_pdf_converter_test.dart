import 'package:flutter_test/flutter_test.dart';
import 'package:markdown_2_pdf/markdown_2_pdf.dart';

void main() {
  group('MarkdownToPdfConverter', () {
    late MarkdownToPdfConverter converter;

    setUp(() {
      converter = MarkdownToPdfConverter();
    });

    test('should create converter with default options', () {
      expect(converter, isNotNull);
    });

    test('should create converter with custom options', () {
      final options = const PdfOptions(
        title: 'Test Document',
        author: 'Test Author',
        fontSize: 14.0,
      );
      
      final customConverter = MarkdownToPdfConverter(options: options);
      expect(customConverter, isNotNull);
    });
  });

  group('MarkdownSource', () {
    test('StringMarkdownSource should return content', () async {
      const content = '# Test Markdown\n\nThis is a test.';
      final source = StringMarkdownSource(content);
      
      final result = await source.getContent();
      expect(result, equals(content));
    });

    test('HttpMarkdownSource should have correct properties', () {
      const url = 'https://example.com/test.md';
      final headers = {'Authorization': 'Bearer token'};
      final timeout = const Duration(seconds: 10);
      
      final source = HttpMarkdownSource(
        url: url,
        headers: headers,
        timeout: timeout,
      );
      
      expect(source.url, equals(url));
      expect(source.headers, equals(headers));
      expect(source.timeout, equals(timeout));
    });
  });

  group('PdfOptions', () {
    test('should create with default values', () {
      const options = PdfOptions();
      
      expect(options.title, isNull);
      expect(options.author, isNull);
      expect(options.fontSize, equals(12.0));
      expect(options.includePageNumbers, isTrue);
    });

    test('should create with custom values', () {
      const options = PdfOptions(
        title: 'Custom Title',
        author: 'Custom Author',
        fontSize: 16.0,
        includePageNumbers: false,
      );
      
      expect(options.title, equals('Custom Title'));
      expect(options.author, equals('Custom Author'));
      expect(options.fontSize, equals(16.0));
      expect(options.includePageNumbers, isFalse);
    });

    test('should copy with new values', () {
      const original = PdfOptions(
        title: 'Original Title',
        fontSize: 12.0,
      );
      
      final copied = original.copyWith(
        title: 'New Title',
        fontSize: 14.0,
      );
      
      expect(copied.title, equals('New Title'));
      expect(copied.fontSize, equals(14.0));
      expect(copied.author, isNull); // Should remain unchanged
    });
  });
}

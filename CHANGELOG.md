# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-01

### Added
- Initial release of Markdown2PDF package
- Support for converting markdown from HTTP URLs to PDF
- Support for converting markdown from strings to PDF
- Comprehensive PDF formatting with customizable styles
- Support for all major markdown elements:
  - Headers (H1-H6)
  - Bold and italic text
  - Code blocks and inline code
  - Lists (ordered and unordered)
  - Tables
  - Blockquotes
  - Links
  - Horizontal rules
- HTTP response handling with custom headers and timeout
- Multiple output options:
  - Save to file
  - Get as bytes
  - Share directly
  - Print directly
- Highly customizable PDF options
- Beautiful default styling with professional appearance
- Comprehensive test coverage
- Example application demonstrating usage
- Complete documentation and README

### Features
- `MarkdownToPdfConverter` - Main conversion class
- `MarkdownSource` - Abstract source class with implementations:
  - `HttpMarkdownSource` - For HTTP URLs
  - `StringMarkdownSource` - For string content
  - `HttpResponseMarkdownSource` - For HTTP responses
- `PdfOptions` - Comprehensive PDF configuration
- `PdfStyles` - Predefined styling options
- Support for page numbers, headers, and footers
- Customizable fonts, colors, and layouts

import 'package:flutter/widgets.dart';

/// Renders [text] with every case-insensitive occurrence of [query]
/// wrapped in [highlightStyle] instead of [style] — the "highlighted
/// matched text" search requirement, done once and reused everywhere a
/// search result renders its title.
class HighlightText extends StatelessWidget {
  const HighlightText({
    super.key,
    required this.text,
    required this.query,
    required this.style,
    required this.highlightStyle,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final String query;
  final TextStyle style;
  final TextStyle highlightStyle;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return Text(text, style: style, maxLines: maxLines, overflow: overflow);
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = trimmed.toLowerCase();
    final spans = <TextSpan>[];
    var start = 0;
    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index < 0) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }
      if (index > start) spans.add(TextSpan(text: text.substring(start, index)));
      spans.add(TextSpan(text: text.substring(index, index + trimmed.length), style: highlightStyle));
      start = index + trimmed.length;
    }

    return Text.rich(TextSpan(style: style, children: spans), maxLines: maxLines, overflow: overflow);
  }
}

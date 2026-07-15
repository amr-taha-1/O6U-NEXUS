import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// Loads and decodes a JSON asset. Every temporary local repository in
/// `shared/data/` and `features/*/data/` reads through this instead of
/// `rootBundle`/`jsonDecode` directly, so the moment an official API exists,
/// only the repository's fetch call changes — not how it's parsed.
abstract final class JsonAssetLoader {
  static Future<Map<String, dynamic>> loadObject(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<List<dynamic>> loadList(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    return jsonDecode(raw) as List<dynamic>;
  }
}

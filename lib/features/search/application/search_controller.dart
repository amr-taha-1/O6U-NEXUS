import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/search_result.dart';
import 'search_index.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

/// Recent searches, most-recent first, capped at 8 — session-scoped
/// in-memory state, the same pattern as the class-reminder toggles
/// (`ClassReminderSettings`). Upgradeable to `shared_preferences`
/// persistence later without touching any consumer.
class SearchHistoryNotifier extends Notifier<List<String>> {
  static const _maxEntries = 8;

  @override
  List<String> build() => [];

  void add(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    final deduped = [trimmed, ...state.where((q) => q.toLowerCase() != trimmed.toLowerCase())];
    state = deduped.take(_maxEntries).toList();
  }

  void remove(String query) => state = [for (final q in state) if (q != query) q];

  void clear() => state = [];
}

final searchHistoryProvider = NotifierProvider<SearchHistoryNotifier, List<String>>(SearchHistoryNotifier.new);

/// Suggested searches shown before the student types anything — the same
/// handful of high-value destinations called out by name in the feature
/// request (Transcript, Schedule, GPA, Degree Progress, Course Catalog).
const suggestedSearches = ['Transcript', 'Schedule', 'GPA', 'Degree Progress', 'Course Catalog', 'Advisor'];

/// Instant, ranked, substring search over [searchIndexProvider] — matches
/// on title first (and ranks a title match above a subtitle-only match),
/// then falls back to subtitle text. Case-insensitive, partial-text, works
/// by code or by name because both are baked into each result's title.
final searchResultsProvider = Provider<AsyncValue<List<SearchResult>>>((ref) {
  final indexAsync = ref.watch(searchIndexProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  return indexAsync.whenData((results) {
    if (query.isEmpty) return const <SearchResult>[];

    final titleMatches = <SearchResult>[];
    final subtitleMatches = <SearchResult>[];
    for (final result in results) {
      if (result.title.toLowerCase().contains(query)) {
        titleMatches.add(result);
      } else if (result.subtitle?.toLowerCase().contains(query) ?? false) {
        subtitleMatches.add(result);
      }
    }

    int byRelevance(SearchResult a, SearchResult b) {
      final aStarts = a.title.toLowerCase().startsWith(query);
      final bStarts = b.title.toLowerCase().startsWith(query);
      if (aStarts != bStarts) return aStarts ? -1 : 1;
      return a.title.length.compareTo(b.title.length);
    }

    titleMatches.sort(byRelevance);
    return [...titleMatches, ...subtitleMatches];
  });
});

/// [searchResultsProvider]'s matches grouped by category, in a stable
/// display order — the shape the search screen renders directly.
final groupedSearchResultsProvider = Provider<AsyncValue<Map<SearchCategory, List<SearchResult>>>>((ref) {
  return ref.watch(searchResultsProvider).whenData((results) {
    final grouped = <SearchCategory, List<SearchResult>>{};
    for (final result in results) {
      grouped.putIfAbsent(result.category, () => []).add(result);
    }
    return grouped;
  });
});

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../application/search_controller.dart';
import '../../domain/search_result.dart';
import '../widgets/highlight_text.dart';

IconData _categoryIcon(SearchCategory category) => switch (category) {
      SearchCategory.profile => CupertinoIcons.person_crop_circle,
      SearchCategory.transcript => CupertinoIcons.doc_text,
      SearchCategory.currentCourses => CupertinoIcons.book,
      SearchCategory.schedule => CupertinoIcons.calendar,
      SearchCategory.degreeProgress => CupertinoIcons.flag,
      SearchCategory.gpaAnalytics => CupertinoIcons.chart_bar_alt_fill,
      SearchCategory.catalog => CupertinoIcons.square_stack_3d_up,
      SearchCategory.notifications => CupertinoIcons.bell,
    };

/// One unified, cross-app entry point: Student Profile, Transcript, Current
/// Courses, Schedule, Degree Progress, GPA & Analytics, Course Catalog,
/// Bylaw/Prerequisites, and Notifications — searchable by course code or
/// name, partial text, instantly. See [searchIndexProvider] for the index
/// itself and docs/Architecture.md "Real data" for the sourcing rules every
/// result obeys.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setQuery(String value) {
    _controller.text = value;
    _controller.selection = TextSelection.collapsed(offset: value.length);
    ref.read(searchQueryProvider.notifier).state = value;
  }

  void _onSubmit(String value) {
    if (value.trim().isNotEmpty) {
      ref.read(searchHistoryProvider.notifier).add(value);
    }
  }

  void _onResultTap(SearchResult result) {
    ref.read(searchHistoryProvider.notifier).add(_controller.text);
    context.push(result.route);
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final groupedAsync = ref.watch(groupedSearchResultsProvider);
    final history = ref.watch(searchHistoryProvider);

    return AppPushScaffold(
      title: 'Search',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppSearchBar(
              hintText: 'Search courses, grades, schedule, advisor…',
              controller: _controller,
              autofocus: true,
              onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
              onSubmitted: _onSubmit,
            ),
          ),
          if (query.trim().isEmpty)
            _EmptyQueryBody(history: history, onSelect: _setQuery)
          else
            groupedAsync.when(
              data: (grouped) => grouped.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                      child: StatusPlaceholder.empty(
                        icon: CupertinoIcons.search,
                        title: 'No matches',
                        message: 'Nothing in your academic record or campus data matches "$query".',
                      ),
                    )
                  : _ResultsBody(grouped: grouped, query: query, onTap: _onResultTap),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                child: Column(
                  children: [
                    SkeletonListTile(isFirst: true),
                    SkeletonListTile(),
                  ],
                ),
              ),
              error: (error, stackTrace) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                child: StatusPlaceholder.error(message: 'Search is unavailable right now: $error'),
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyQueryBody extends StatelessWidget {
  const _EmptyQueryBody({required this.history, required this.onSelect});
  final List<String> history;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (history.isNotEmpty) ...[
          const SectionHeader('Recent searches'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final entry in history)
                  GestureDetector(
                    onTap: () => onSelect(entry),
                    child: TagChip(label: entry, color: colors.textMuted, icon: CupertinoIcons.clock),
                  ),
              ],
            ),
          ),
        ],
        const SectionHeader('Try searching for'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final suggestion in suggestedSearches)
                GestureDetector(
                  onTap: () => onSelect(suggestion),
                  child: TagChip(label: suggestion, color: colors.accent),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ResultsBody extends StatelessWidget {
  const _ResultsBody({required this.grouped, required this.query, required this.onTap});
  final Map<SearchCategory, List<SearchResult>> grouped;
  final String query;
  final ValueChanged<SearchResult> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final category in SearchCategory.values)
          if (grouped[category]?.isNotEmpty ?? false) ...[
            SectionHeader(category.label),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (var i = 0; i < grouped[category]!.length; i++)
                      _ResultRow(
                        result: grouped[category]![i],
                        query: query,
                        isFirst: i == 0,
                        onTap: onTap,
                      ),
                  ],
                ),
              ),
            ),
          ],
      ],
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({required this.result, required this.query, required this.isFirst, required this.onTap});
  final SearchResult result;
  final String query;
  final bool isFirst;
  final ValueChanged<SearchResult> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(result),
      child: Container(
        constraints: const BoxConstraints(minHeight: 56),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(border: isFirst ? null : Border(top: BorderSide(color: colors.hairline, width: 0.5))),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: AppColors.tint(colors.accent, 0.14), borderRadius: AppRadius.smRadius),
              alignment: Alignment.center,
              child: Icon(_categoryIcon(result.category), size: 15, color: colors.accent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  HighlightText(
                    text: result.title,
                    query: query,
                    style: text.bodyEmphasized.copyWith(fontSize: 14.5),
                    highlightStyle: text.bodyEmphasized.copyWith(fontSize: 14.5, color: colors.accent),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (result.subtitle != null) ...[
                    const SizedBox(height: 1),
                    Text(
                      result.subtitle!,
                      style: text.footnote.copyWith(color: colors.textMuted),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            Icon(CupertinoIcons.chevron_forward, size: 14, color: colors.textDim),
          ],
        ),
      ),
    );
  }
}

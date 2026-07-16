import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/campus_post.dart';

const _typeOptions = [
  (CampusPostType.text, 'Post', CupertinoIcons.text_bubble),
  (CampusPostType.question, 'Question', CupertinoIcons.question_circle),
  (CampusPostType.note, 'Study Note', CupertinoIcons.doc_text),
  (CampusPostType.projectUpdate, 'Project Update', CupertinoIcons.hammer),
  (CampusPostType.achievement, 'Achievement', CupertinoIcons.rosette),
  (CampusPostType.poll, 'Poll', CupertinoIcons.chart_bar),
];

/// Composing a post is real, working UI; *publishing* it is simulated (no
/// social backend exists in this build) — the same "Export official PDF"
/// pattern used elsewhere. Image/document attachment is a labelled
/// placeholder rather than a real file picker: this environment cannot add
/// new native dependencies like `image_picker` (see docs/CHANGELOG.md).
class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _bodyController = TextEditingController();
  CampusPostType _type = CampusPostType.text;

  @override
  void dispose() {
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppPushScaffold(
      title: 'Create Post',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader('Type', topPadding: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (final option in _typeOptions)
                  GestureDetector(
                    onTap: () => setState(() => _type = option.$1),
                    child: TagChip(
                      label: option.$2,
                      icon: option.$3,
                      color: colors.accent,
                      filled: _type == option.$1,
                      selected: _type == option.$1,
                    ),
                  ),
              ],
            ),
          ),
          const SectionHeader('What\'s on your mind?'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: AppCard(
              child: Material(
                type: MaterialType.transparency,
                child: TextField(
                  controller: _bodyController,
                  maxLines: 6,
                  onChanged: (_) => setState(() {}),
                  style: context.textStyles.body,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Share an update, ask a question, or post a study note. Use #hashtags and @mentions.',
                    hintStyle: context.textStyles.body.copyWith(color: colors.textDim),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 10, AppSpacing.screenMargin, 0),
            child: AppCard(
              dashed: true,
              onTap: () => AppSnackbar.show(context, message: 'Attachment picker unavailable in this build — no file/image picker dependency.'),
              child: Row(
                children: [
                  Icon(CupertinoIcons.paperclip, size: 16, color: colors.textDim),
                  const SizedBox(width: 10),
                  Text('Attach an image or document', style: context.textStyles.footnote),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 16, AppSpacing.screenMargin, 0),
            child: AppButton(
              label: 'Post',
              expand: true,
              onPressed: _bodyController.text.trim().isEmpty
                  ? null
                  : () {
                      AppSnackbar.show(context, message: 'Posted · simulated, no backend in this build.');
                      Navigator.of(context).pop();
                    },
            ),
          ),
        ],
      ),
    );
  }
}

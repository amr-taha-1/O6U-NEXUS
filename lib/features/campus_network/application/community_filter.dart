import 'package:flutter_riverpod/flutter_riverpod.dart';

/// `null` means "no hashtag filter" — show every post.
final communityHashtagFilterProvider = StateProvider<String?>((ref) => null);

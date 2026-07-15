import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/json_asset_loader.dart';
import '../../../shared/domain/semester.dart';
import '../domain/transcript_course.dart';

const _assetPath = 'assets/data/transcript.json';

/// Reads the official transcript from `assets/data/transcript.json` — see
/// the note on [StudentRepository] re: temporary local data source.
class TranscriptRepository {
  const TranscriptRepository();

  Future<List<Semester>> getTranscript() async {
    final json = await JsonAssetLoader.loadObject(_assetPath);
    final semesters = json['semesters'] as List<dynamic>;
    return [for (final s in semesters) _parseSemester(s as Map<String, dynamic>)];
  }

  Semester _parseSemester(Map<String, dynamic> json) {
    final courses = json['courses'] as List<dynamic>;
    return Semester(
      label: json['label'] as String,
      gpa: (json['gpa'] as num).toDouble(),
      creditHours: json['hours'] as int,
      points: (json['points'] as num).toDouble(),
      courses: [for (final c in courses) _parseCourse(c as Map<String, dynamic>)],
    );
  }

  TranscriptCourse _parseCourse(Map<String, dynamic> json) {
    return TranscriptCourse(
      code: json['code'] as String,
      name: json['name'] as String,
      grade: json['grade'] as String,
      creditHours: json['hours'] as int?,
      points: (json['points'] as num?)?.toDouble(),
    );
  }
}

final transcriptRepositoryProvider = Provider<TranscriptRepository>((ref) => const TranscriptRepository());

final transcriptProvider = FutureProvider<List<Semester>>((ref) {
  return ref.watch(transcriptRepositoryProvider).getTranscript();
});

/// Chronological semester-GPA trend, for the Academics hub's sparkline —
/// derived from [transcriptProvider], not stored separately, so it can
/// never drift out of sync with the transcript itself.
final semesterGpaTrendProvider = FutureProvider<List<double>>((ref) async {
  final semesters = await ref.watch(transcriptProvider.future);
  return [for (final s in semesters) s.gpa];
});

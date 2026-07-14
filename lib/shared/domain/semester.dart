import 'package:freezed_annotation/freezed_annotation.dart';

part 'semester.freezed.dart';

@freezed
abstract class Semester with _$Semester {
  const factory Semester({
    required String label,
    required double gpa,
    required int creditHours,
  }) = _Semester;
}

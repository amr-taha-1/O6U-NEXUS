import 'package:freezed_annotation/freezed_annotation.dart';

part 'club.freezed.dart';

@freezed
abstract class ClubEvent with _$ClubEvent {
  const factory ClubEvent({
    required String id,
    required String title,
    required DateTime dateTime,
    required String location,
  }) = _ClubEvent;
}

/// One university club's page — posts reuse [CampusPost] filtered by
/// [Club.id] rather than being duplicated here.
@freezed
abstract class Club with _$Club {
  const factory Club({
    required String id,
    required String name,
    required String shortName,
    required String description,
    required int memberCount,
    required List<String> announcements,
    required List<ClubEvent> events,
    required List<String> galleryAssetPaths,
  }) = _Club;
}

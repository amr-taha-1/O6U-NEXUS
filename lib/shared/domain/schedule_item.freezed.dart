// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ScheduleItem {
  String get time => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get meta => throw _privateConstructorUsedError;
  Color get accent => throw _privateConstructorUsedError;
  IconData get icon => throw _privateConstructorUsedError;
  ScheduleItemKind get kind => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleItemCopyWith<ScheduleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleItemCopyWith<$Res> {
  factory $ScheduleItemCopyWith(
    ScheduleItem value,
    $Res Function(ScheduleItem) then,
  ) = _$ScheduleItemCopyWithImpl<$Res, ScheduleItem>;
  @useResult
  $Res call({
    String time,
    String title,
    String meta,
    Color accent,
    IconData icon,
    ScheduleItemKind kind,
  });
}

/// @nodoc
class _$ScheduleItemCopyWithImpl<$Res, $Val extends ScheduleItem>
    implements $ScheduleItemCopyWith<$Res> {
  _$ScheduleItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? title = null,
    Object? meta = null,
    Object? accent = null,
    Object? icon = null,
    Object? kind = null,
  }) {
    return _then(
      _value.copyWith(
            time: null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            meta: null == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as String,
            accent: null == accent
                ? _value.accent
                : accent // ignore: cast_nullable_to_non_nullable
                      as Color,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as IconData,
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as ScheduleItemKind,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduleItemImplCopyWith<$Res>
    implements $ScheduleItemCopyWith<$Res> {
  factory _$$ScheduleItemImplCopyWith(
    _$ScheduleItemImpl value,
    $Res Function(_$ScheduleItemImpl) then,
  ) = __$$ScheduleItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String time,
    String title,
    String meta,
    Color accent,
    IconData icon,
    ScheduleItemKind kind,
  });
}

/// @nodoc
class __$$ScheduleItemImplCopyWithImpl<$Res>
    extends _$ScheduleItemCopyWithImpl<$Res, _$ScheduleItemImpl>
    implements _$$ScheduleItemImplCopyWith<$Res> {
  __$$ScheduleItemImplCopyWithImpl(
    _$ScheduleItemImpl _value,
    $Res Function(_$ScheduleItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? title = null,
    Object? meta = null,
    Object? accent = null,
    Object? icon = null,
    Object? kind = null,
  }) {
    return _then(
      _$ScheduleItemImpl(
        time: null == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        meta: null == meta
            ? _value.meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as String,
        accent: null == accent
            ? _value.accent
            : accent // ignore: cast_nullable_to_non_nullable
                  as Color,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as IconData,
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as ScheduleItemKind,
      ),
    );
  }
}

/// @nodoc

class _$ScheduleItemImpl extends _ScheduleItem {
  const _$ScheduleItemImpl({
    required this.time,
    required this.title,
    required this.meta,
    required this.accent,
    required this.icon,
    required this.kind,
  }) : super._();

  @override
  final String time;
  @override
  final String title;
  @override
  final String meta;
  @override
  final Color accent;
  @override
  final IconData icon;
  @override
  final ScheduleItemKind kind;

  @override
  String toString() {
    return 'ScheduleItem(time: $time, title: $title, meta: $meta, accent: $accent, icon: $icon, kind: $kind)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleItemImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.accent, accent) || other.accent == accent) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.kind, kind) || other.kind == kind));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, time, title, meta, accent, icon, kind);

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleItemImplCopyWith<_$ScheduleItemImpl> get copyWith =>
      __$$ScheduleItemImplCopyWithImpl<_$ScheduleItemImpl>(this, _$identity);
}

abstract class _ScheduleItem extends ScheduleItem {
  const factory _ScheduleItem({
    required final String time,
    required final String title,
    required final String meta,
    required final Color accent,
    required final IconData icon,
    required final ScheduleItemKind kind,
  }) = _$ScheduleItemImpl;
  const _ScheduleItem._() : super._();

  @override
  String get time;
  @override
  String get title;
  @override
  String get meta;
  @override
  Color get accent;
  @override
  IconData get icon;
  @override
  ScheduleItemKind get kind;

  /// Create a copy of ScheduleItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleItemImplCopyWith<_$ScheduleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

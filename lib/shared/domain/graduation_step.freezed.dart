// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'graduation_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GraduationStep {
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get statusLabel => throw _privateConstructorUsedError;
  GraduationStepStatus get status => throw _privateConstructorUsedError;
  Color get accent => throw _privateConstructorUsedError;

  /// Create a copy of GraduationStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GraduationStepCopyWith<GraduationStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GraduationStepCopyWith<$Res> {
  factory $GraduationStepCopyWith(
    GraduationStep value,
    $Res Function(GraduationStep) then,
  ) = _$GraduationStepCopyWithImpl<$Res, GraduationStep>;
  @useResult
  $Res call({
    String title,
    String subtitle,
    String statusLabel,
    GraduationStepStatus status,
    Color accent,
  });
}

/// @nodoc
class _$GraduationStepCopyWithImpl<$Res, $Val extends GraduationStep>
    implements $GraduationStepCopyWith<$Res> {
  _$GraduationStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GraduationStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? statusLabel = null,
    Object? status = null,
    Object? accent = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            statusLabel: null == statusLabel
                ? _value.statusLabel
                : statusLabel // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GraduationStepStatus,
            accent: null == accent
                ? _value.accent
                : accent // ignore: cast_nullable_to_non_nullable
                      as Color,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GraduationStepImplCopyWith<$Res>
    implements $GraduationStepCopyWith<$Res> {
  factory _$$GraduationStepImplCopyWith(
    _$GraduationStepImpl value,
    $Res Function(_$GraduationStepImpl) then,
  ) = __$$GraduationStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String subtitle,
    String statusLabel,
    GraduationStepStatus status,
    Color accent,
  });
}

/// @nodoc
class __$$GraduationStepImplCopyWithImpl<$Res>
    extends _$GraduationStepCopyWithImpl<$Res, _$GraduationStepImpl>
    implements _$$GraduationStepImplCopyWith<$Res> {
  __$$GraduationStepImplCopyWithImpl(
    _$GraduationStepImpl _value,
    $Res Function(_$GraduationStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GraduationStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? statusLabel = null,
    Object? status = null,
    Object? accent = null,
  }) {
    return _then(
      _$GraduationStepImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        statusLabel: null == statusLabel
            ? _value.statusLabel
            : statusLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GraduationStepStatus,
        accent: null == accent
            ? _value.accent
            : accent // ignore: cast_nullable_to_non_nullable
                  as Color,
      ),
    );
  }
}

/// @nodoc

class _$GraduationStepImpl implements _GraduationStep {
  const _$GraduationStepImpl({
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    required this.status,
    required this.accent,
  });

  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String statusLabel;
  @override
  final GraduationStepStatus status;
  @override
  final Color accent;

  @override
  String toString() {
    return 'GraduationStep(title: $title, subtitle: $subtitle, statusLabel: $statusLabel, status: $status, accent: $accent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GraduationStepImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.statusLabel, statusLabel) ||
                other.statusLabel == statusLabel) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.accent, accent) || other.accent == accent));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, title, subtitle, statusLabel, status, accent);

  /// Create a copy of GraduationStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GraduationStepImplCopyWith<_$GraduationStepImpl> get copyWith =>
      __$$GraduationStepImplCopyWithImpl<_$GraduationStepImpl>(
        this,
        _$identity,
      );
}

abstract class _GraduationStep implements GraduationStep {
  const factory _GraduationStep({
    required final String title,
    required final String subtitle,
    required final String statusLabel,
    required final GraduationStepStatus status,
    required final Color accent,
  }) = _$GraduationStepImpl;

  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get statusLabel;
  @override
  GraduationStepStatus get status;
  @override
  Color get accent;

  /// Create a copy of GraduationStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GraduationStepImplCopyWith<_$GraduationStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CatalogCourse {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get creditHours => throw _privateConstructorUsedError;
  int get yearLevel => throw _privateConstructorUsedError;
  CourseCategory get category => throw _privateConstructorUsedError;
  List<String> get prerequisites => throw _privateConstructorUsedError;

  /// Create a copy of CatalogCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogCourseCopyWith<CatalogCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogCourseCopyWith<$Res> {
  factory $CatalogCourseCopyWith(
    CatalogCourse value,
    $Res Function(CatalogCourse) then,
  ) = _$CatalogCourseCopyWithImpl<$Res, CatalogCourse>;
  @useResult
  $Res call({
    String code,
    String name,
    int creditHours,
    int yearLevel,
    CourseCategory category,
    List<String> prerequisites,
  });
}

/// @nodoc
class _$CatalogCourseCopyWithImpl<$Res, $Val extends CatalogCourse>
    implements $CatalogCourseCopyWith<$Res> {
  _$CatalogCourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? creditHours = null,
    Object? yearLevel = null,
    Object? category = null,
    Object? prerequisites = null,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            creditHours: null == creditHours
                ? _value.creditHours
                : creditHours // ignore: cast_nullable_to_non_nullable
                      as int,
            yearLevel: null == yearLevel
                ? _value.yearLevel
                : yearLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as CourseCategory,
            prerequisites: null == prerequisites
                ? _value.prerequisites
                : prerequisites // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CatalogCourseImplCopyWith<$Res>
    implements $CatalogCourseCopyWith<$Res> {
  factory _$$CatalogCourseImplCopyWith(
    _$CatalogCourseImpl value,
    $Res Function(_$CatalogCourseImpl) then,
  ) = __$$CatalogCourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String name,
    int creditHours,
    int yearLevel,
    CourseCategory category,
    List<String> prerequisites,
  });
}

/// @nodoc
class __$$CatalogCourseImplCopyWithImpl<$Res>
    extends _$CatalogCourseCopyWithImpl<$Res, _$CatalogCourseImpl>
    implements _$$CatalogCourseImplCopyWith<$Res> {
  __$$CatalogCourseImplCopyWithImpl(
    _$CatalogCourseImpl _value,
    $Res Function(_$CatalogCourseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? creditHours = null,
    Object? yearLevel = null,
    Object? category = null,
    Object? prerequisites = null,
  }) {
    return _then(
      _$CatalogCourseImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        creditHours: null == creditHours
            ? _value.creditHours
            : creditHours // ignore: cast_nullable_to_non_nullable
                  as int,
        yearLevel: null == yearLevel
            ? _value.yearLevel
            : yearLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as CourseCategory,
        prerequisites: null == prerequisites
            ? _value._prerequisites
            : prerequisites // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$CatalogCourseImpl extends _CatalogCourse {
  const _$CatalogCourseImpl({
    required this.code,
    required this.name,
    required this.creditHours,
    required this.yearLevel,
    required this.category,
    required final List<String> prerequisites,
  }) : _prerequisites = prerequisites,
       super._();

  @override
  final String code;
  @override
  final String name;
  @override
  final int creditHours;
  @override
  final int yearLevel;
  @override
  final CourseCategory category;
  final List<String> _prerequisites;
  @override
  List<String> get prerequisites {
    if (_prerequisites is EqualUnmodifiableListView) return _prerequisites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prerequisites);
  }

  @override
  String toString() {
    return 'CatalogCourse(code: $code, name: $name, creditHours: $creditHours, yearLevel: $yearLevel, category: $category, prerequisites: $prerequisites)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogCourseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.creditHours, creditHours) ||
                other.creditHours == creditHours) &&
            (identical(other.yearLevel, yearLevel) ||
                other.yearLevel == yearLevel) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(
              other._prerequisites,
              _prerequisites,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    name,
    creditHours,
    yearLevel,
    category,
    const DeepCollectionEquality().hash(_prerequisites),
  );

  /// Create a copy of CatalogCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogCourseImplCopyWith<_$CatalogCourseImpl> get copyWith =>
      __$$CatalogCourseImplCopyWithImpl<_$CatalogCourseImpl>(this, _$identity);
}

abstract class _CatalogCourse extends CatalogCourse {
  const factory _CatalogCourse({
    required final String code,
    required final String name,
    required final int creditHours,
    required final int yearLevel,
    required final CourseCategory category,
    required final List<String> prerequisites,
  }) = _$CatalogCourseImpl;
  const _CatalogCourse._() : super._();

  @override
  String get code;
  @override
  String get name;
  @override
  int get creditHours;
  @override
  int get yearLevel;
  @override
  CourseCategory get category;
  @override
  List<String> get prerequisites;

  /// Create a copy of CatalogCourse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogCourseImplCopyWith<_$CatalogCourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

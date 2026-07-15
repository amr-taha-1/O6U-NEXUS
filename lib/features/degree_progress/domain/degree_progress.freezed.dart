// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'degree_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DegreeRequirementCategory {
  String get name => throw _privateConstructorUsedError;
  int get requiredHours => throw _privateConstructorUsedError;
  int get completedHours => throw _privateConstructorUsedError;

  /// Create a copy of DegreeRequirementCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DegreeRequirementCategoryCopyWith<DegreeRequirementCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DegreeRequirementCategoryCopyWith<$Res> {
  factory $DegreeRequirementCategoryCopyWith(
    DegreeRequirementCategory value,
    $Res Function(DegreeRequirementCategory) then,
  ) = _$DegreeRequirementCategoryCopyWithImpl<$Res, DegreeRequirementCategory>;
  @useResult
  $Res call({String name, int requiredHours, int completedHours});
}

/// @nodoc
class _$DegreeRequirementCategoryCopyWithImpl<
  $Res,
  $Val extends DegreeRequirementCategory
>
    implements $DegreeRequirementCategoryCopyWith<$Res> {
  _$DegreeRequirementCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DegreeRequirementCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? requiredHours = null,
    Object? completedHours = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            requiredHours: null == requiredHours
                ? _value.requiredHours
                : requiredHours // ignore: cast_nullable_to_non_nullable
                      as int,
            completedHours: null == completedHours
                ? _value.completedHours
                : completedHours // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DegreeRequirementCategoryImplCopyWith<$Res>
    implements $DegreeRequirementCategoryCopyWith<$Res> {
  factory _$$DegreeRequirementCategoryImplCopyWith(
    _$DegreeRequirementCategoryImpl value,
    $Res Function(_$DegreeRequirementCategoryImpl) then,
  ) = __$$DegreeRequirementCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int requiredHours, int completedHours});
}

/// @nodoc
class __$$DegreeRequirementCategoryImplCopyWithImpl<$Res>
    extends
        _$DegreeRequirementCategoryCopyWithImpl<
          $Res,
          _$DegreeRequirementCategoryImpl
        >
    implements _$$DegreeRequirementCategoryImplCopyWith<$Res> {
  __$$DegreeRequirementCategoryImplCopyWithImpl(
    _$DegreeRequirementCategoryImpl _value,
    $Res Function(_$DegreeRequirementCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DegreeRequirementCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? requiredHours = null,
    Object? completedHours = null,
  }) {
    return _then(
      _$DegreeRequirementCategoryImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        requiredHours: null == requiredHours
            ? _value.requiredHours
            : requiredHours // ignore: cast_nullable_to_non_nullable
                  as int,
        completedHours: null == completedHours
            ? _value.completedHours
            : completedHours // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$DegreeRequirementCategoryImpl extends _DegreeRequirementCategory {
  const _$DegreeRequirementCategoryImpl({
    required this.name,
    required this.requiredHours,
    required this.completedHours,
  }) : super._();

  @override
  final String name;
  @override
  final int requiredHours;
  @override
  final int completedHours;

  @override
  String toString() {
    return 'DegreeRequirementCategory(name: $name, requiredHours: $requiredHours, completedHours: $completedHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DegreeRequirementCategoryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.requiredHours, requiredHours) ||
                other.requiredHours == requiredHours) &&
            (identical(other.completedHours, completedHours) ||
                other.completedHours == completedHours));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, requiredHours, completedHours);

  /// Create a copy of DegreeRequirementCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DegreeRequirementCategoryImplCopyWith<_$DegreeRequirementCategoryImpl>
  get copyWith =>
      __$$DegreeRequirementCategoryImplCopyWithImpl<
        _$DegreeRequirementCategoryImpl
      >(this, _$identity);
}

abstract class _DegreeRequirementCategory extends DegreeRequirementCategory {
  const factory _DegreeRequirementCategory({
    required final String name,
    required final int requiredHours,
    required final int completedHours,
  }) = _$DegreeRequirementCategoryImpl;
  const _DegreeRequirementCategory._() : super._();

  @override
  String get name;
  @override
  int get requiredHours;
  @override
  int get completedHours;

  /// Create a copy of DegreeRequirementCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DegreeRequirementCategoryImplCopyWith<_$DegreeRequirementCategoryImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DegreeProgress {
  List<DegreeRequirementCategory> get categories =>
      throw _privateConstructorUsedError;
  int get graduationHoursRequired => throw _privateConstructorUsedError;
  int get graduationHoursCompleted => throw _privateConstructorUsedError;
  double get cgpa => throw _privateConstructorUsedError;

  /// Create a copy of DegreeProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DegreeProgressCopyWith<DegreeProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DegreeProgressCopyWith<$Res> {
  factory $DegreeProgressCopyWith(
    DegreeProgress value,
    $Res Function(DegreeProgress) then,
  ) = _$DegreeProgressCopyWithImpl<$Res, DegreeProgress>;
  @useResult
  $Res call({
    List<DegreeRequirementCategory> categories,
    int graduationHoursRequired,
    int graduationHoursCompleted,
    double cgpa,
  });
}

/// @nodoc
class _$DegreeProgressCopyWithImpl<$Res, $Val extends DegreeProgress>
    implements $DegreeProgressCopyWith<$Res> {
  _$DegreeProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DegreeProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? graduationHoursRequired = null,
    Object? graduationHoursCompleted = null,
    Object? cgpa = null,
  }) {
    return _then(
      _value.copyWith(
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<DegreeRequirementCategory>,
            graduationHoursRequired: null == graduationHoursRequired
                ? _value.graduationHoursRequired
                : graduationHoursRequired // ignore: cast_nullable_to_non_nullable
                      as int,
            graduationHoursCompleted: null == graduationHoursCompleted
                ? _value.graduationHoursCompleted
                : graduationHoursCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            cgpa: null == cgpa
                ? _value.cgpa
                : cgpa // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DegreeProgressImplCopyWith<$Res>
    implements $DegreeProgressCopyWith<$Res> {
  factory _$$DegreeProgressImplCopyWith(
    _$DegreeProgressImpl value,
    $Res Function(_$DegreeProgressImpl) then,
  ) = __$$DegreeProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<DegreeRequirementCategory> categories,
    int graduationHoursRequired,
    int graduationHoursCompleted,
    double cgpa,
  });
}

/// @nodoc
class __$$DegreeProgressImplCopyWithImpl<$Res>
    extends _$DegreeProgressCopyWithImpl<$Res, _$DegreeProgressImpl>
    implements _$$DegreeProgressImplCopyWith<$Res> {
  __$$DegreeProgressImplCopyWithImpl(
    _$DegreeProgressImpl _value,
    $Res Function(_$DegreeProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DegreeProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? graduationHoursRequired = null,
    Object? graduationHoursCompleted = null,
    Object? cgpa = null,
  }) {
    return _then(
      _$DegreeProgressImpl(
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<DegreeRequirementCategory>,
        graduationHoursRequired: null == graduationHoursRequired
            ? _value.graduationHoursRequired
            : graduationHoursRequired // ignore: cast_nullable_to_non_nullable
                  as int,
        graduationHoursCompleted: null == graduationHoursCompleted
            ? _value.graduationHoursCompleted
            : graduationHoursCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        cgpa: null == cgpa
            ? _value.cgpa
            : cgpa // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$DegreeProgressImpl extends _DegreeProgress {
  const _$DegreeProgressImpl({
    required final List<DegreeRequirementCategory> categories,
    required this.graduationHoursRequired,
    required this.graduationHoursCompleted,
    required this.cgpa,
  }) : _categories = categories,
       super._();

  final List<DegreeRequirementCategory> _categories;
  @override
  List<DegreeRequirementCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final int graduationHoursRequired;
  @override
  final int graduationHoursCompleted;
  @override
  final double cgpa;

  @override
  String toString() {
    return 'DegreeProgress(categories: $categories, graduationHoursRequired: $graduationHoursRequired, graduationHoursCompleted: $graduationHoursCompleted, cgpa: $cgpa)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DegreeProgressImpl &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(
                  other.graduationHoursRequired,
                  graduationHoursRequired,
                ) ||
                other.graduationHoursRequired == graduationHoursRequired) &&
            (identical(
                  other.graduationHoursCompleted,
                  graduationHoursCompleted,
                ) ||
                other.graduationHoursCompleted == graduationHoursCompleted) &&
            (identical(other.cgpa, cgpa) || other.cgpa == cgpa));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_categories),
    graduationHoursRequired,
    graduationHoursCompleted,
    cgpa,
  );

  /// Create a copy of DegreeProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DegreeProgressImplCopyWith<_$DegreeProgressImpl> get copyWith =>
      __$$DegreeProgressImplCopyWithImpl<_$DegreeProgressImpl>(
        this,
        _$identity,
      );
}

abstract class _DegreeProgress extends DegreeProgress {
  const factory _DegreeProgress({
    required final List<DegreeRequirementCategory> categories,
    required final int graduationHoursRequired,
    required final int graduationHoursCompleted,
    required final double cgpa,
  }) = _$DegreeProgressImpl;
  const _DegreeProgress._() : super._();

  @override
  List<DegreeRequirementCategory> get categories;
  @override
  int get graduationHoursRequired;
  @override
  int get graduationHoursCompleted;
  @override
  double get cgpa;

  /// Create a copy of DegreeProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DegreeProgressImplCopyWith<_$DegreeProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

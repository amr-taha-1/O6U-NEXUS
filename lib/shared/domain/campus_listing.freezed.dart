// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CampusListing {
  String get id => throw _privateConstructorUsedError;
  CampusListingCategory get category => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  Color get accent => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  IconData? get icon => throw _privateConstructorUsedError;

  /// Create a copy of CampusListing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampusListingCopyWith<CampusListing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampusListingCopyWith<$Res> {
  factory $CampusListingCopyWith(
    CampusListing value,
    $Res Function(CampusListing) then,
  ) = _$CampusListingCopyWithImpl<$Res, CampusListing>;
  @useResult
  $Res call({
    String id,
    CampusListingCategory category,
    String title,
    String subtitle,
    String status,
    Color accent,
    String? price,
    IconData? icon,
  });
}

/// @nodoc
class _$CampusListingCopyWithImpl<$Res, $Val extends CampusListing>
    implements $CampusListingCopyWith<$Res> {
  _$CampusListingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CampusListing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? title = null,
    Object? subtitle = null,
    Object? status = null,
    Object? accent = null,
    Object? price = freezed,
    Object? icon = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as CampusListingCategory,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            accent: null == accent
                ? _value.accent
                : accent // ignore: cast_nullable_to_non_nullable
                      as Color,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as String?,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as IconData?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CampusListingImplCopyWith<$Res>
    implements $CampusListingCopyWith<$Res> {
  factory _$$CampusListingImplCopyWith(
    _$CampusListingImpl value,
    $Res Function(_$CampusListingImpl) then,
  ) = __$$CampusListingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    CampusListingCategory category,
    String title,
    String subtitle,
    String status,
    Color accent,
    String? price,
    IconData? icon,
  });
}

/// @nodoc
class __$$CampusListingImplCopyWithImpl<$Res>
    extends _$CampusListingCopyWithImpl<$Res, _$CampusListingImpl>
    implements _$$CampusListingImplCopyWith<$Res> {
  __$$CampusListingImplCopyWithImpl(
    _$CampusListingImpl _value,
    $Res Function(_$CampusListingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CampusListing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? title = null,
    Object? subtitle = null,
    Object? status = null,
    Object? accent = null,
    Object? price = freezed,
    Object? icon = freezed,
  }) {
    return _then(
      _$CampusListingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as CampusListingCategory,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        accent: null == accent
            ? _value.accent
            : accent // ignore: cast_nullable_to_non_nullable
                  as Color,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as String?,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as IconData?,
      ),
    );
  }
}

/// @nodoc

class _$CampusListingImpl implements _CampusListing {
  const _$CampusListingImpl({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.accent,
    this.price,
    this.icon,
  });

  @override
  final String id;
  @override
  final CampusListingCategory category;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String status;
  @override
  final Color accent;
  @override
  final String? price;
  @override
  final IconData? icon;

  @override
  String toString() {
    return 'CampusListing(id: $id, category: $category, title: $title, subtitle: $subtitle, status: $status, accent: $accent, price: $price, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampusListingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.accent, accent) || other.accent == accent) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    category,
    title,
    subtitle,
    status,
    accent,
    price,
    icon,
  );

  /// Create a copy of CampusListing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampusListingImplCopyWith<_$CampusListingImpl> get copyWith =>
      __$$CampusListingImplCopyWithImpl<_$CampusListingImpl>(this, _$identity);
}

abstract class _CampusListing implements CampusListing {
  const factory _CampusListing({
    required final String id,
    required final CampusListingCategory category,
    required final String title,
    required final String subtitle,
    required final String status,
    required final Color accent,
    final String? price,
    final IconData? icon,
  }) = _$CampusListingImpl;

  @override
  String get id;
  @override
  CampusListingCategory get category;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get status;
  @override
  Color get accent;
  @override
  String? get price;
  @override
  IconData? get icon;

  /// Create a copy of CampusListing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampusListingImplCopyWith<_$CampusListingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

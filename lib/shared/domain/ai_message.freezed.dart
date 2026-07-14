// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AiChip {
  String get label => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;

  /// Create a copy of AiChip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiChipCopyWith<AiChip> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChipCopyWith<$Res> {
  factory $AiChipCopyWith(AiChip value, $Res Function(AiChip) then) =
      _$AiChipCopyWithImpl<$Res, AiChip>;
  @useResult
  $Res call({String label, Color color});
}

/// @nodoc
class _$AiChipCopyWithImpl<$Res, $Val extends AiChip>
    implements $AiChipCopyWith<$Res> {
  _$AiChipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? color = null}) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as Color,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiChipImplCopyWith<$Res> implements $AiChipCopyWith<$Res> {
  factory _$$AiChipImplCopyWith(
    _$AiChipImpl value,
    $Res Function(_$AiChipImpl) then,
  ) = __$$AiChipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, Color color});
}

/// @nodoc
class __$$AiChipImplCopyWithImpl<$Res>
    extends _$AiChipCopyWithImpl<$Res, _$AiChipImpl>
    implements _$$AiChipImplCopyWith<$Res> {
  __$$AiChipImplCopyWithImpl(
    _$AiChipImpl _value,
    $Res Function(_$AiChipImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? color = null}) {
    return _then(
      _$AiChipImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as Color,
      ),
    );
  }
}

/// @nodoc

class _$AiChipImpl implements _AiChip {
  const _$AiChipImpl({required this.label, required this.color});

  @override
  final String label;
  @override
  final Color color;

  @override
  String toString() {
    return 'AiChip(label: $label, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChipImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, color);

  /// Create a copy of AiChip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChipImplCopyWith<_$AiChipImpl> get copyWith =>
      __$$AiChipImplCopyWithImpl<_$AiChipImpl>(this, _$identity);
}

abstract class _AiChip implements AiChip {
  const factory _AiChip({
    required final String label,
    required final Color color,
  }) = _$AiChipImpl;

  @override
  String get label;
  @override
  Color get color;

  /// Create a copy of AiChip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChipImplCopyWith<_$AiChipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AiMessage {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) user,
    required TResult Function(
      String verdict,
      String body,
      List<AiChip> chips,
      String ctaLabel,
    )
    assistant,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? user,
    TResult? Function(
      String verdict,
      String body,
      List<AiChip> chips,
      String ctaLabel,
    )?
    assistant,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? user,
    TResult Function(
      String verdict,
      String body,
      List<AiChip> chips,
      String ctaLabel,
    )?
    assistant,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AiUserMessage value) user,
    required TResult Function(AiAssistantMessage value) assistant,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AiUserMessage value)? user,
    TResult? Function(AiAssistantMessage value)? assistant,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AiUserMessage value)? user,
    TResult Function(AiAssistantMessage value)? assistant,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiMessageCopyWith<$Res> {
  factory $AiMessageCopyWith(AiMessage value, $Res Function(AiMessage) then) =
      _$AiMessageCopyWithImpl<$Res, AiMessage>;
}

/// @nodoc
class _$AiMessageCopyWithImpl<$Res, $Val extends AiMessage>
    implements $AiMessageCopyWith<$Res> {
  _$AiMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AiUserMessageImplCopyWith<$Res> {
  factory _$$AiUserMessageImplCopyWith(
    _$AiUserMessageImpl value,
    $Res Function(_$AiUserMessageImpl) then,
  ) = __$$AiUserMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$AiUserMessageImplCopyWithImpl<$Res>
    extends _$AiMessageCopyWithImpl<$Res, _$AiUserMessageImpl>
    implements _$$AiUserMessageImplCopyWith<$Res> {
  __$$AiUserMessageImplCopyWithImpl(
    _$AiUserMessageImpl _value,
    $Res Function(_$AiUserMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null}) {
    return _then(
      _$AiUserMessageImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AiUserMessageImpl implements AiUserMessage {
  const _$AiUserMessageImpl({required this.text});

  @override
  final String text;

  @override
  String toString() {
    return 'AiMessage.user(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiUserMessageImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiUserMessageImplCopyWith<_$AiUserMessageImpl> get copyWith =>
      __$$AiUserMessageImplCopyWithImpl<_$AiUserMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) user,
    required TResult Function(
      String verdict,
      String body,
      List<AiChip> chips,
      String ctaLabel,
    )
    assistant,
  }) {
    return user(text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? user,
    TResult? Function(
      String verdict,
      String body,
      List<AiChip> chips,
      String ctaLabel,
    )?
    assistant,
  }) {
    return user?.call(text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? user,
    TResult Function(
      String verdict,
      String body,
      List<AiChip> chips,
      String ctaLabel,
    )?
    assistant,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AiUserMessage value) user,
    required TResult Function(AiAssistantMessage value) assistant,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AiUserMessage value)? user,
    TResult? Function(AiAssistantMessage value)? assistant,
  }) {
    return user?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AiUserMessage value)? user,
    TResult Function(AiAssistantMessage value)? assistant,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this);
    }
    return orElse();
  }
}

abstract class AiUserMessage implements AiMessage {
  const factory AiUserMessage({required final String text}) =
      _$AiUserMessageImpl;

  String get text;

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiUserMessageImplCopyWith<_$AiUserMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AiAssistantMessageImplCopyWith<$Res> {
  factory _$$AiAssistantMessageImplCopyWith(
    _$AiAssistantMessageImpl value,
    $Res Function(_$AiAssistantMessageImpl) then,
  ) = __$$AiAssistantMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String verdict, String body, List<AiChip> chips, String ctaLabel});
}

/// @nodoc
class __$$AiAssistantMessageImplCopyWithImpl<$Res>
    extends _$AiMessageCopyWithImpl<$Res, _$AiAssistantMessageImpl>
    implements _$$AiAssistantMessageImplCopyWith<$Res> {
  __$$AiAssistantMessageImplCopyWithImpl(
    _$AiAssistantMessageImpl _value,
    $Res Function(_$AiAssistantMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verdict = null,
    Object? body = null,
    Object? chips = null,
    Object? ctaLabel = null,
  }) {
    return _then(
      _$AiAssistantMessageImpl(
        verdict: null == verdict
            ? _value.verdict
            : verdict // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        chips: null == chips
            ? _value._chips
            : chips // ignore: cast_nullable_to_non_nullable
                  as List<AiChip>,
        ctaLabel: null == ctaLabel
            ? _value.ctaLabel
            : ctaLabel // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AiAssistantMessageImpl implements AiAssistantMessage {
  const _$AiAssistantMessageImpl({
    required this.verdict,
    required this.body,
    required final List<AiChip> chips,
    required this.ctaLabel,
  }) : _chips = chips;

  @override
  final String verdict;
  @override
  final String body;
  final List<AiChip> _chips;
  @override
  List<AiChip> get chips {
    if (_chips is EqualUnmodifiableListView) return _chips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chips);
  }

  @override
  final String ctaLabel;

  @override
  String toString() {
    return 'AiMessage.assistant(verdict: $verdict, body: $body, chips: $chips, ctaLabel: $ctaLabel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiAssistantMessageImpl &&
            (identical(other.verdict, verdict) || other.verdict == verdict) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other._chips, _chips) &&
            (identical(other.ctaLabel, ctaLabel) ||
                other.ctaLabel == ctaLabel));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    verdict,
    body,
    const DeepCollectionEquality().hash(_chips),
    ctaLabel,
  );

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiAssistantMessageImplCopyWith<_$AiAssistantMessageImpl> get copyWith =>
      __$$AiAssistantMessageImplCopyWithImpl<_$AiAssistantMessageImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) user,
    required TResult Function(
      String verdict,
      String body,
      List<AiChip> chips,
      String ctaLabel,
    )
    assistant,
  }) {
    return assistant(verdict, body, chips, ctaLabel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? user,
    TResult? Function(
      String verdict,
      String body,
      List<AiChip> chips,
      String ctaLabel,
    )?
    assistant,
  }) {
    return assistant?.call(verdict, body, chips, ctaLabel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? user,
    TResult Function(
      String verdict,
      String body,
      List<AiChip> chips,
      String ctaLabel,
    )?
    assistant,
    required TResult orElse(),
  }) {
    if (assistant != null) {
      return assistant(verdict, body, chips, ctaLabel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AiUserMessage value) user,
    required TResult Function(AiAssistantMessage value) assistant,
  }) {
    return assistant(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AiUserMessage value)? user,
    TResult? Function(AiAssistantMessage value)? assistant,
  }) {
    return assistant?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AiUserMessage value)? user,
    TResult Function(AiAssistantMessage value)? assistant,
    required TResult orElse(),
  }) {
    if (assistant != null) {
      return assistant(this);
    }
    return orElse();
  }
}

abstract class AiAssistantMessage implements AiMessage {
  const factory AiAssistantMessage({
    required final String verdict,
    required final String body,
    required final List<AiChip> chips,
    required final String ctaLabel,
  }) = _$AiAssistantMessageImpl;

  String get verdict;
  String get body;
  List<AiChip> get chips;
  String get ctaLabel;

  /// Create a copy of AiMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiAssistantMessageImplCopyWith<_$AiAssistantMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

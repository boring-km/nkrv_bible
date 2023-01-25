// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bible_ui_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BibleUiEventTearOff {
  const _$BibleUiEventTearOff();

  ShowDialog<T> showDialog<T>(String message) {
    return ShowDialog<T>(
      message,
    );
  }
}

/// @nodoc
const $BibleUiEvent = _$BibleUiEventTearOff();

/// @nodoc
mixin _$BibleUiEvent<T> {
  String get message => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? showDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showDialog,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowDialog<T> value) showDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ShowDialog<T> value)? showDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowDialog<T> value)? showDialog,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BibleUiEventCopyWith<T, BibleUiEvent<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BibleUiEventCopyWith<T, $Res> {
  factory $BibleUiEventCopyWith(
          BibleUiEvent<T> value, $Res Function(BibleUiEvent<T>) then) =
      _$BibleUiEventCopyWithImpl<T, $Res>;
  $Res call({String message});
}

/// @nodoc
class _$BibleUiEventCopyWithImpl<T, $Res>
    implements $BibleUiEventCopyWith<T, $Res> {
  _$BibleUiEventCopyWithImpl(this._value, this._then);

  final BibleUiEvent<T> _value;
  // ignore: unused_field
  final $Res Function(BibleUiEvent<T>) _then;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $ShowDialogCopyWith<T, $Res>
    implements $BibleUiEventCopyWith<T, $Res> {
  factory $ShowDialogCopyWith(
          ShowDialog<T> value, $Res Function(ShowDialog<T>) then) =
      _$ShowDialogCopyWithImpl<T, $Res>;
  @override
  $Res call({String message});
}

/// @nodoc
class _$ShowDialogCopyWithImpl<T, $Res>
    extends _$BibleUiEventCopyWithImpl<T, $Res>
    implements $ShowDialogCopyWith<T, $Res> {
  _$ShowDialogCopyWithImpl(
      ShowDialog<T> _value, $Res Function(ShowDialog<T>) _then)
      : super(_value, (v) => _then(v as ShowDialog<T>));

  @override
  ShowDialog<T> get _value => super._value as ShowDialog<T>;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(ShowDialog<T>(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ShowDialog<T> implements ShowDialog<T> {
  const _$ShowDialog(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BibleUiEvent<$T>.showDialog(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShowDialog<T> &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  $ShowDialogCopyWith<T, ShowDialog<T>> get copyWith =>
      _$ShowDialogCopyWithImpl<T, ShowDialog<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showDialog,
  }) {
    return showDialog(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? showDialog,
  }) {
    return showDialog?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showDialog,
    required TResult orElse(),
  }) {
    if (showDialog != null) {
      return showDialog(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowDialog<T> value) showDialog,
  }) {
    return showDialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ShowDialog<T> value)? showDialog,
  }) {
    return showDialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowDialog<T> value)? showDialog,
    required TResult orElse(),
  }) {
    if (showDialog != null) {
      return showDialog(this);
    }
    return orElse();
  }
}

abstract class ShowDialog<T> implements BibleUiEvent<T> {
  const factory ShowDialog(String message) = _$ShowDialog<T>;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  $ShowDialogCopyWith<T, ShowDialog<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

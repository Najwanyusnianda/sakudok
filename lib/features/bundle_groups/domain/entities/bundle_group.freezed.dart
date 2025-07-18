// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bundle_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BundleGroup {

 int get id; String get name; String? get iconName; String? get colorHex; int get displayOrder; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of BundleGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BundleGroupCopyWith<BundleGroup> get copyWith => _$BundleGroupCopyWithImpl<BundleGroup>(this as BundleGroup, _$identity);

  /// Serializes this BundleGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BundleGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,iconName,colorHex,displayOrder,createdAt,updatedAt);

@override
String toString() {
  return 'BundleGroup(id: $id, name: $name, iconName: $iconName, colorHex: $colorHex, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BundleGroupCopyWith<$Res>  {
  factory $BundleGroupCopyWith(BundleGroup value, $Res Function(BundleGroup) _then) = _$BundleGroupCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? iconName, String? colorHex, int displayOrder, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$BundleGroupCopyWithImpl<$Res>
    implements $BundleGroupCopyWith<$Res> {
  _$BundleGroupCopyWithImpl(this._self, this._then);

  final BundleGroup _self;
  final $Res Function(BundleGroup) _then;

/// Create a copy of BundleGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? iconName = freezed,Object? colorHex = freezed,Object? displayOrder = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconName: freezed == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BundleGroup].
extension BundleGroupPatterns on BundleGroup {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BundleGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BundleGroup() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BundleGroup value)  $default,){
final _that = this;
switch (_that) {
case _BundleGroup():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BundleGroup value)?  $default,){
final _that = this;
switch (_that) {
case _BundleGroup() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? iconName,  String? colorHex,  int displayOrder,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BundleGroup() when $default != null:
return $default(_that.id,_that.name,_that.iconName,_that.colorHex,_that.displayOrder,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? iconName,  String? colorHex,  int displayOrder,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BundleGroup():
return $default(_that.id,_that.name,_that.iconName,_that.colorHex,_that.displayOrder,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? iconName,  String? colorHex,  int displayOrder,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BundleGroup() when $default != null:
return $default(_that.id,_that.name,_that.iconName,_that.colorHex,_that.displayOrder,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BundleGroup extends BundleGroup {
  const _BundleGroup({required this.id, required this.name, this.iconName, this.colorHex, this.displayOrder = 0, required this.createdAt, required this.updatedAt}): super._();
  factory _BundleGroup.fromJson(Map<String, dynamic> json) => _$BundleGroupFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? iconName;
@override final  String? colorHex;
@override@JsonKey() final  int displayOrder;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of BundleGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BundleGroupCopyWith<_BundleGroup> get copyWith => __$BundleGroupCopyWithImpl<_BundleGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BundleGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BundleGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,iconName,colorHex,displayOrder,createdAt,updatedAt);

@override
String toString() {
  return 'BundleGroup(id: $id, name: $name, iconName: $iconName, colorHex: $colorHex, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BundleGroupCopyWith<$Res> implements $BundleGroupCopyWith<$Res> {
  factory _$BundleGroupCopyWith(_BundleGroup value, $Res Function(_BundleGroup) _then) = __$BundleGroupCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? iconName, String? colorHex, int displayOrder, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$BundleGroupCopyWithImpl<$Res>
    implements _$BundleGroupCopyWith<$Res> {
  __$BundleGroupCopyWithImpl(this._self, this._then);

  final _BundleGroup _self;
  final $Res Function(_BundleGroup) _then;

/// Create a copy of BundleGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? iconName = freezed,Object? colorHex = freezed,Object? displayOrder = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_BundleGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconName: freezed == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

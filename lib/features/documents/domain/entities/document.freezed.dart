// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Document {

 int get id; String get title; String get type; String get filePath; DateTime get createdAt; DateTime get updatedAt; String? get description;// Core fields
 bool get hasReminder; DateTime? get reminderDate; String? get reminderNote; bool get isEncrypted; String? get tags; int? get bundleId;// Flexible metadata for all document types
 Map<String, dynamic> get metadata;
/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentCopyWith<Document> get copyWith => _$DocumentCopyWithImpl<Document>(this as Document, _$identity);

  /// Serializes this Document to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Document&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.hasReminder, hasReminder) || other.hasReminder == hasReminder)&&(identical(other.reminderDate, reminderDate) || other.reminderDate == reminderDate)&&(identical(other.reminderNote, reminderNote) || other.reminderNote == reminderNote)&&(identical(other.isEncrypted, isEncrypted) || other.isEncrypted == isEncrypted)&&(identical(other.tags, tags) || other.tags == tags)&&(identical(other.bundleId, bundleId) || other.bundleId == bundleId)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,filePath,createdAt,updatedAt,description,hasReminder,reminderDate,reminderNote,isEncrypted,tags,bundleId,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'Document(id: $id, title: $title, type: $type, filePath: $filePath, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, hasReminder: $hasReminder, reminderDate: $reminderDate, reminderNote: $reminderNote, isEncrypted: $isEncrypted, tags: $tags, bundleId: $bundleId, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $DocumentCopyWith<$Res>  {
  factory $DocumentCopyWith(Document value, $Res Function(Document) _then) = _$DocumentCopyWithImpl;
@useResult
$Res call({
 int id, String title, String type, String filePath, DateTime createdAt, DateTime updatedAt, String? description, bool hasReminder, DateTime? reminderDate, String? reminderNote, bool isEncrypted, String? tags, int? bundleId, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$DocumentCopyWithImpl<$Res>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._self, this._then);

  final Document _self;
  final $Res Function(Document) _then;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? type = null,Object? filePath = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,Object? hasReminder = null,Object? reminderDate = freezed,Object? reminderNote = freezed,Object? isEncrypted = null,Object? tags = freezed,Object? bundleId = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,hasReminder: null == hasReminder ? _self.hasReminder : hasReminder // ignore: cast_nullable_to_non_nullable
as bool,reminderDate: freezed == reminderDate ? _self.reminderDate : reminderDate // ignore: cast_nullable_to_non_nullable
as DateTime?,reminderNote: freezed == reminderNote ? _self.reminderNote : reminderNote // ignore: cast_nullable_to_non_nullable
as String?,isEncrypted: null == isEncrypted ? _self.isEncrypted : isEncrypted // ignore: cast_nullable_to_non_nullable
as bool,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as String?,bundleId: freezed == bundleId ? _self.bundleId : bundleId // ignore: cast_nullable_to_non_nullable
as int?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [Document].
extension DocumentPatterns on Document {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Document value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Document() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Document value)  $default,){
final _that = this;
switch (_that) {
case _Document():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Document value)?  $default,){
final _that = this;
switch (_that) {
case _Document() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String type,  String filePath,  DateTime createdAt,  DateTime updatedAt,  String? description,  bool hasReminder,  DateTime? reminderDate,  String? reminderNote,  bool isEncrypted,  String? tags,  int? bundleId,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Document() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.filePath,_that.createdAt,_that.updatedAt,_that.description,_that.hasReminder,_that.reminderDate,_that.reminderNote,_that.isEncrypted,_that.tags,_that.bundleId,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String type,  String filePath,  DateTime createdAt,  DateTime updatedAt,  String? description,  bool hasReminder,  DateTime? reminderDate,  String? reminderNote,  bool isEncrypted,  String? tags,  int? bundleId,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _Document():
return $default(_that.id,_that.title,_that.type,_that.filePath,_that.createdAt,_that.updatedAt,_that.description,_that.hasReminder,_that.reminderDate,_that.reminderNote,_that.isEncrypted,_that.tags,_that.bundleId,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String type,  String filePath,  DateTime createdAt,  DateTime updatedAt,  String? description,  bool hasReminder,  DateTime? reminderDate,  String? reminderNote,  bool isEncrypted,  String? tags,  int? bundleId,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _Document() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.filePath,_that.createdAt,_that.updatedAt,_that.description,_that.hasReminder,_that.reminderDate,_that.reminderNote,_that.isEncrypted,_that.tags,_that.bundleId,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Document implements Document {
  const _Document({required this.id, required this.title, required this.type, required this.filePath, required this.createdAt, required this.updatedAt, this.description, this.hasReminder = false, this.reminderDate, this.reminderNote, this.isEncrypted = false, this.tags, this.bundleId, final  Map<String, dynamic> metadata = const <String, dynamic>{}}): _metadata = metadata;
  factory _Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

@override final  int id;
@override final  String title;
@override final  String type;
@override final  String filePath;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? description;
// Core fields
@override@JsonKey() final  bool hasReminder;
@override final  DateTime? reminderDate;
@override final  String? reminderNote;
@override@JsonKey() final  bool isEncrypted;
@override final  String? tags;
@override final  int? bundleId;
// Flexible metadata for all document types
 final  Map<String, dynamic> _metadata;
// Flexible metadata for all document types
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentCopyWith<_Document> get copyWith => __$DocumentCopyWithImpl<_Document>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Document&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.hasReminder, hasReminder) || other.hasReminder == hasReminder)&&(identical(other.reminderDate, reminderDate) || other.reminderDate == reminderDate)&&(identical(other.reminderNote, reminderNote) || other.reminderNote == reminderNote)&&(identical(other.isEncrypted, isEncrypted) || other.isEncrypted == isEncrypted)&&(identical(other.tags, tags) || other.tags == tags)&&(identical(other.bundleId, bundleId) || other.bundleId == bundleId)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,filePath,createdAt,updatedAt,description,hasReminder,reminderDate,reminderNote,isEncrypted,tags,bundleId,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'Document(id: $id, title: $title, type: $type, filePath: $filePath, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, hasReminder: $hasReminder, reminderDate: $reminderDate, reminderNote: $reminderNote, isEncrypted: $isEncrypted, tags: $tags, bundleId: $bundleId, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$DocumentCopyWith<$Res> implements $DocumentCopyWith<$Res> {
  factory _$DocumentCopyWith(_Document value, $Res Function(_Document) _then) = __$DocumentCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String type, String filePath, DateTime createdAt, DateTime updatedAt, String? description, bool hasReminder, DateTime? reminderDate, String? reminderNote, bool isEncrypted, String? tags, int? bundleId, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$DocumentCopyWithImpl<$Res>
    implements _$DocumentCopyWith<$Res> {
  __$DocumentCopyWithImpl(this._self, this._then);

  final _Document _self;
  final $Res Function(_Document) _then;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? type = null,Object? filePath = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,Object? hasReminder = null,Object? reminderDate = freezed,Object? reminderNote = freezed,Object? isEncrypted = null,Object? tags = freezed,Object? bundleId = freezed,Object? metadata = null,}) {
  return _then(_Document(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,hasReminder: null == hasReminder ? _self.hasReminder : hasReminder // ignore: cast_nullable_to_non_nullable
as bool,reminderDate: freezed == reminderDate ? _self.reminderDate : reminderDate // ignore: cast_nullable_to_non_nullable
as DateTime?,reminderNote: freezed == reminderNote ? _self.reminderNote : reminderNote // ignore: cast_nullable_to_non_nullable
as String?,isEncrypted: null == isEncrypted ? _self.isEncrypted : isEncrypted // ignore: cast_nullable_to_non_nullable
as bool,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as String?,bundleId: freezed == bundleId ? _self.bundleId : bundleId // ignore: cast_nullable_to_non_nullable
as int?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on

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

 String get id; String get title; String? get description; String? get thumbnail; DocumentType get type; List<String> get tags; DateTime? get expiryDate; bool get isFavorite; int get bundleCount; DateTime get createdAt; DateTime get updatedAt; List<String> get filePaths; String? get ocrText; DocumentMetadata get metadata; Map<String, dynamic> get extractedData;
/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentCopyWith<Document> get copyWith => _$DocumentCopyWithImpl<Document>(this as Document, _$identity);

  /// Serializes this Document to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Document&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.bundleCount, bundleCount) || other.bundleCount == bundleCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.filePaths, filePaths)&&(identical(other.ocrText, ocrText) || other.ocrText == ocrText)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other.extractedData, extractedData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,thumbnail,type,const DeepCollectionEquality().hash(tags),expiryDate,isFavorite,bundleCount,createdAt,updatedAt,const DeepCollectionEquality().hash(filePaths),ocrText,metadata,const DeepCollectionEquality().hash(extractedData));

@override
String toString() {
  return 'Document(id: $id, title: $title, description: $description, thumbnail: $thumbnail, type: $type, tags: $tags, expiryDate: $expiryDate, isFavorite: $isFavorite, bundleCount: $bundleCount, createdAt: $createdAt, updatedAt: $updatedAt, filePaths: $filePaths, ocrText: $ocrText, metadata: $metadata, extractedData: $extractedData)';
}


}

/// @nodoc
abstract mixin class $DocumentCopyWith<$Res>  {
  factory $DocumentCopyWith(Document value, $Res Function(Document) _then) = _$DocumentCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, String? thumbnail, DocumentType type, List<String> tags, DateTime? expiryDate, bool isFavorite, int bundleCount, DateTime createdAt, DateTime updatedAt, List<String> filePaths, String? ocrText, DocumentMetadata metadata, Map<String, dynamic> extractedData
});


$DocumentMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$DocumentCopyWithImpl<$Res>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._self, this._then);

  final Document _self;
  final $Res Function(Document) _then;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? thumbnail = freezed,Object? type = null,Object? tags = null,Object? expiryDate = freezed,Object? isFavorite = null,Object? bundleCount = null,Object? createdAt = null,Object? updatedAt = null,Object? filePaths = null,Object? ocrText = freezed,Object? metadata = null,Object? extractedData = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DocumentType,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,bundleCount: null == bundleCount ? _self.bundleCount : bundleCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,filePaths: null == filePaths ? _self.filePaths : filePaths // ignore: cast_nullable_to_non_nullable
as List<String>,ocrText: freezed == ocrText ? _self.ocrText : ocrText // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as DocumentMetadata,extractedData: null == extractedData ? _self.extractedData : extractedData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentMetadataCopyWith<$Res> get metadata {
  
  return $DocumentMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? thumbnail,  DocumentType type,  List<String> tags,  DateTime? expiryDate,  bool isFavorite,  int bundleCount,  DateTime createdAt,  DateTime updatedAt,  List<String> filePaths,  String? ocrText,  DocumentMetadata metadata,  Map<String, dynamic> extractedData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Document() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.thumbnail,_that.type,_that.tags,_that.expiryDate,_that.isFavorite,_that.bundleCount,_that.createdAt,_that.updatedAt,_that.filePaths,_that.ocrText,_that.metadata,_that.extractedData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? thumbnail,  DocumentType type,  List<String> tags,  DateTime? expiryDate,  bool isFavorite,  int bundleCount,  DateTime createdAt,  DateTime updatedAt,  List<String> filePaths,  String? ocrText,  DocumentMetadata metadata,  Map<String, dynamic> extractedData)  $default,) {final _that = this;
switch (_that) {
case _Document():
return $default(_that.id,_that.title,_that.description,_that.thumbnail,_that.type,_that.tags,_that.expiryDate,_that.isFavorite,_that.bundleCount,_that.createdAt,_that.updatedAt,_that.filePaths,_that.ocrText,_that.metadata,_that.extractedData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  String? thumbnail,  DocumentType type,  List<String> tags,  DateTime? expiryDate,  bool isFavorite,  int bundleCount,  DateTime createdAt,  DateTime updatedAt,  List<String> filePaths,  String? ocrText,  DocumentMetadata metadata,  Map<String, dynamic> extractedData)?  $default,) {final _that = this;
switch (_that) {
case _Document() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.thumbnail,_that.type,_that.tags,_that.expiryDate,_that.isFavorite,_that.bundleCount,_that.createdAt,_that.updatedAt,_that.filePaths,_that.ocrText,_that.metadata,_that.extractedData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Document implements Document {
  const _Document({required this.id, required this.title, this.description, this.thumbnail, required this.type, final  List<String> tags = const [], this.expiryDate, this.isFavorite = false, this.bundleCount = 0, required this.createdAt, required this.updatedAt, final  List<String> filePaths = const [], this.ocrText, required this.metadata, final  Map<String, dynamic> extractedData = const {}}): _tags = tags,_filePaths = filePaths,_extractedData = extractedData;
  factory _Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  String? thumbnail;
@override final  DocumentType type;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  DateTime? expiryDate;
@override@JsonKey() final  bool isFavorite;
@override@JsonKey() final  int bundleCount;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
 final  List<String> _filePaths;
@override@JsonKey() List<String> get filePaths {
  if (_filePaths is EqualUnmodifiableListView) return _filePaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filePaths);
}

@override final  String? ocrText;
@override final  DocumentMetadata metadata;
 final  Map<String, dynamic> _extractedData;
@override@JsonKey() Map<String, dynamic> get extractedData {
  if (_extractedData is EqualUnmodifiableMapView) return _extractedData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extractedData);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Document&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.bundleCount, bundleCount) || other.bundleCount == bundleCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._filePaths, _filePaths)&&(identical(other.ocrText, ocrText) || other.ocrText == ocrText)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._extractedData, _extractedData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,thumbnail,type,const DeepCollectionEquality().hash(_tags),expiryDate,isFavorite,bundleCount,createdAt,updatedAt,const DeepCollectionEquality().hash(_filePaths),ocrText,metadata,const DeepCollectionEquality().hash(_extractedData));

@override
String toString() {
  return 'Document(id: $id, title: $title, description: $description, thumbnail: $thumbnail, type: $type, tags: $tags, expiryDate: $expiryDate, isFavorite: $isFavorite, bundleCount: $bundleCount, createdAt: $createdAt, updatedAt: $updatedAt, filePaths: $filePaths, ocrText: $ocrText, metadata: $metadata, extractedData: $extractedData)';
}


}

/// @nodoc
abstract mixin class _$DocumentCopyWith<$Res> implements $DocumentCopyWith<$Res> {
  factory _$DocumentCopyWith(_Document value, $Res Function(_Document) _then) = __$DocumentCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, String? thumbnail, DocumentType type, List<String> tags, DateTime? expiryDate, bool isFavorite, int bundleCount, DateTime createdAt, DateTime updatedAt, List<String> filePaths, String? ocrText, DocumentMetadata metadata, Map<String, dynamic> extractedData
});


@override $DocumentMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$DocumentCopyWithImpl<$Res>
    implements _$DocumentCopyWith<$Res> {
  __$DocumentCopyWithImpl(this._self, this._then);

  final _Document _self;
  final $Res Function(_Document) _then;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? thumbnail = freezed,Object? type = null,Object? tags = null,Object? expiryDate = freezed,Object? isFavorite = null,Object? bundleCount = null,Object? createdAt = null,Object? updatedAt = null,Object? filePaths = null,Object? ocrText = freezed,Object? metadata = null,Object? extractedData = null,}) {
  return _then(_Document(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DocumentType,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,bundleCount: null == bundleCount ? _self.bundleCount : bundleCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,filePaths: null == filePaths ? _self._filePaths : filePaths // ignore: cast_nullable_to_non_nullable
as List<String>,ocrText: freezed == ocrText ? _self.ocrText : ocrText // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as DocumentMetadata,extractedData: null == extractedData ? _self._extractedData : extractedData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentMetadataCopyWith<$Res> get metadata {
  
  return $DocumentMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on

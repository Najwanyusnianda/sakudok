// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
DocumentMetadata _$DocumentMetadataFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'ktp':
          return KTPMetadata.fromJson(
            json
          );
                case 'ielts':
          return IELTSMetadata.fromJson(
            json
          );
                case 'unknown':
          return UnknownMetadata.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'DocumentMetadata',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$DocumentMetadata {



  /// Serializes this DocumentMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentMetadata);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocumentMetadata()';
}


}

/// @nodoc
class $DocumentMetadataCopyWith<$Res>  {
$DocumentMetadataCopyWith(DocumentMetadata _, $Res Function(DocumentMetadata) __);
}


/// Adds pattern-matching-related methods to [DocumentMetadata].
extension DocumentMetadataPatterns on DocumentMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( KTPMetadata value)?  ktp,TResult Function( IELTSMetadata value)?  ielts,TResult Function( UnknownMetadata value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case KTPMetadata() when ktp != null:
return ktp(_that);case IELTSMetadata() when ielts != null:
return ielts(_that);case UnknownMetadata() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( KTPMetadata value)  ktp,required TResult Function( IELTSMetadata value)  ielts,required TResult Function( UnknownMetadata value)  unknown,}){
final _that = this;
switch (_that) {
case KTPMetadata():
return ktp(_that);case IELTSMetadata():
return ielts(_that);case UnknownMetadata():
return unknown(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( KTPMetadata value)?  ktp,TResult? Function( IELTSMetadata value)?  ielts,TResult? Function( UnknownMetadata value)?  unknown,}){
final _that = this;
switch (_that) {
case KTPMetadata() when ktp != null:
return ktp(_that);case IELTSMetadata() when ielts != null:
return ielts(_that);case UnknownMetadata() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String nik,  String fullName,  String birthPlace,  DateTime birthDate,  String gender,  String bloodType,  String address,  String rt,  String rw,  String kelurahan,  String kecamatan,  String religion,  String maritalStatus,  String occupation,  String citizenship,  DateTime issuedDate,  String issuedBy)?  ktp,TResult Function( String candidateNumber,  String testReportNumber,  DateTime testDate,  DateTime expiryDate,  double overallBand,  double listeningScore,  double readingScore,  double writingScore,  double speakingScore,  String testCenter)?  ielts,TResult Function( Map<String, dynamic> data)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case KTPMetadata() when ktp != null:
return ktp(_that.nik,_that.fullName,_that.birthPlace,_that.birthDate,_that.gender,_that.bloodType,_that.address,_that.rt,_that.rw,_that.kelurahan,_that.kecamatan,_that.religion,_that.maritalStatus,_that.occupation,_that.citizenship,_that.issuedDate,_that.issuedBy);case IELTSMetadata() when ielts != null:
return ielts(_that.candidateNumber,_that.testReportNumber,_that.testDate,_that.expiryDate,_that.overallBand,_that.listeningScore,_that.readingScore,_that.writingScore,_that.speakingScore,_that.testCenter);case UnknownMetadata() when unknown != null:
return unknown(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String nik,  String fullName,  String birthPlace,  DateTime birthDate,  String gender,  String bloodType,  String address,  String rt,  String rw,  String kelurahan,  String kecamatan,  String religion,  String maritalStatus,  String occupation,  String citizenship,  DateTime issuedDate,  String issuedBy)  ktp,required TResult Function( String candidateNumber,  String testReportNumber,  DateTime testDate,  DateTime expiryDate,  double overallBand,  double listeningScore,  double readingScore,  double writingScore,  double speakingScore,  String testCenter)  ielts,required TResult Function( Map<String, dynamic> data)  unknown,}) {final _that = this;
switch (_that) {
case KTPMetadata():
return ktp(_that.nik,_that.fullName,_that.birthPlace,_that.birthDate,_that.gender,_that.bloodType,_that.address,_that.rt,_that.rw,_that.kelurahan,_that.kecamatan,_that.religion,_that.maritalStatus,_that.occupation,_that.citizenship,_that.issuedDate,_that.issuedBy);case IELTSMetadata():
return ielts(_that.candidateNumber,_that.testReportNumber,_that.testDate,_that.expiryDate,_that.overallBand,_that.listeningScore,_that.readingScore,_that.writingScore,_that.speakingScore,_that.testCenter);case UnknownMetadata():
return unknown(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String nik,  String fullName,  String birthPlace,  DateTime birthDate,  String gender,  String bloodType,  String address,  String rt,  String rw,  String kelurahan,  String kecamatan,  String religion,  String maritalStatus,  String occupation,  String citizenship,  DateTime issuedDate,  String issuedBy)?  ktp,TResult? Function( String candidateNumber,  String testReportNumber,  DateTime testDate,  DateTime expiryDate,  double overallBand,  double listeningScore,  double readingScore,  double writingScore,  double speakingScore,  String testCenter)?  ielts,TResult? Function( Map<String, dynamic> data)?  unknown,}) {final _that = this;
switch (_that) {
case KTPMetadata() when ktp != null:
return ktp(_that.nik,_that.fullName,_that.birthPlace,_that.birthDate,_that.gender,_that.bloodType,_that.address,_that.rt,_that.rw,_that.kelurahan,_that.kecamatan,_that.religion,_that.maritalStatus,_that.occupation,_that.citizenship,_that.issuedDate,_that.issuedBy);case IELTSMetadata() when ielts != null:
return ielts(_that.candidateNumber,_that.testReportNumber,_that.testDate,_that.expiryDate,_that.overallBand,_that.listeningScore,_that.readingScore,_that.writingScore,_that.speakingScore,_that.testCenter);case UnknownMetadata() when unknown != null:
return unknown(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class KTPMetadata implements DocumentMetadata {
  const KTPMetadata({required this.nik, required this.fullName, required this.birthPlace, required this.birthDate, required this.gender, required this.bloodType, required this.address, required this.rt, required this.rw, required this.kelurahan, required this.kecamatan, required this.religion, required this.maritalStatus, required this.occupation, required this.citizenship, required this.issuedDate, required this.issuedBy, final  String? $type}): $type = $type ?? 'ktp';
  factory KTPMetadata.fromJson(Map<String, dynamic> json) => _$KTPMetadataFromJson(json);

 final  String nik;
 final  String fullName;
 final  String birthPlace;
 final  DateTime birthDate;
 final  String gender;
 final  String bloodType;
 final  String address;
 final  String rt;
 final  String rw;
 final  String kelurahan;
 final  String kecamatan;
 final  String religion;
 final  String maritalStatus;
 final  String occupation;
 final  String citizenship;
 final  DateTime issuedDate;
 final  String issuedBy;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KTPMetadataCopyWith<KTPMetadata> get copyWith => _$KTPMetadataCopyWithImpl<KTPMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KTPMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KTPMetadata&&(identical(other.nik, nik) || other.nik == nik)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&(identical(other.address, address) || other.address == address)&&(identical(other.rt, rt) || other.rt == rt)&&(identical(other.rw, rw) || other.rw == rw)&&(identical(other.kelurahan, kelurahan) || other.kelurahan == kelurahan)&&(identical(other.kecamatan, kecamatan) || other.kecamatan == kecamatan)&&(identical(other.religion, religion) || other.religion == religion)&&(identical(other.maritalStatus, maritalStatus) || other.maritalStatus == maritalStatus)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.citizenship, citizenship) || other.citizenship == citizenship)&&(identical(other.issuedDate, issuedDate) || other.issuedDate == issuedDate)&&(identical(other.issuedBy, issuedBy) || other.issuedBy == issuedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nik,fullName,birthPlace,birthDate,gender,bloodType,address,rt,rw,kelurahan,kecamatan,religion,maritalStatus,occupation,citizenship,issuedDate,issuedBy);

@override
String toString() {
  return 'DocumentMetadata.ktp(nik: $nik, fullName: $fullName, birthPlace: $birthPlace, birthDate: $birthDate, gender: $gender, bloodType: $bloodType, address: $address, rt: $rt, rw: $rw, kelurahan: $kelurahan, kecamatan: $kecamatan, religion: $religion, maritalStatus: $maritalStatus, occupation: $occupation, citizenship: $citizenship, issuedDate: $issuedDate, issuedBy: $issuedBy)';
}


}

/// @nodoc
abstract mixin class $KTPMetadataCopyWith<$Res> implements $DocumentMetadataCopyWith<$Res> {
  factory $KTPMetadataCopyWith(KTPMetadata value, $Res Function(KTPMetadata) _then) = _$KTPMetadataCopyWithImpl;
@useResult
$Res call({
 String nik, String fullName, String birthPlace, DateTime birthDate, String gender, String bloodType, String address, String rt, String rw, String kelurahan, String kecamatan, String religion, String maritalStatus, String occupation, String citizenship, DateTime issuedDate, String issuedBy
});




}
/// @nodoc
class _$KTPMetadataCopyWithImpl<$Res>
    implements $KTPMetadataCopyWith<$Res> {
  _$KTPMetadataCopyWithImpl(this._self, this._then);

  final KTPMetadata _self;
  final $Res Function(KTPMetadata) _then;

/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? nik = null,Object? fullName = null,Object? birthPlace = null,Object? birthDate = null,Object? gender = null,Object? bloodType = null,Object? address = null,Object? rt = null,Object? rw = null,Object? kelurahan = null,Object? kecamatan = null,Object? religion = null,Object? maritalStatus = null,Object? occupation = null,Object? citizenship = null,Object? issuedDate = null,Object? issuedBy = null,}) {
  return _then(KTPMetadata(
nik: null == nik ? _self.nik : nik // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,bloodType: null == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,rt: null == rt ? _self.rt : rt // ignore: cast_nullable_to_non_nullable
as String,rw: null == rw ? _self.rw : rw // ignore: cast_nullable_to_non_nullable
as String,kelurahan: null == kelurahan ? _self.kelurahan : kelurahan // ignore: cast_nullable_to_non_nullable
as String,kecamatan: null == kecamatan ? _self.kecamatan : kecamatan // ignore: cast_nullable_to_non_nullable
as String,religion: null == religion ? _self.religion : religion // ignore: cast_nullable_to_non_nullable
as String,maritalStatus: null == maritalStatus ? _self.maritalStatus : maritalStatus // ignore: cast_nullable_to_non_nullable
as String,occupation: null == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String,citizenship: null == citizenship ? _self.citizenship : citizenship // ignore: cast_nullable_to_non_nullable
as String,issuedDate: null == issuedDate ? _self.issuedDate : issuedDate // ignore: cast_nullable_to_non_nullable
as DateTime,issuedBy: null == issuedBy ? _self.issuedBy : issuedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class IELTSMetadata implements DocumentMetadata {
  const IELTSMetadata({required this.candidateNumber, required this.testReportNumber, required this.testDate, required this.expiryDate, required this.overallBand, required this.listeningScore, required this.readingScore, required this.writingScore, required this.speakingScore, required this.testCenter, final  String? $type}): $type = $type ?? 'ielts';
  factory IELTSMetadata.fromJson(Map<String, dynamic> json) => _$IELTSMetadataFromJson(json);

 final  String candidateNumber;
 final  String testReportNumber;
 final  DateTime testDate;
 final  DateTime expiryDate;
 final  double overallBand;
 final  double listeningScore;
 final  double readingScore;
 final  double writingScore;
 final  double speakingScore;
 final  String testCenter;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IELTSMetadataCopyWith<IELTSMetadata> get copyWith => _$IELTSMetadataCopyWithImpl<IELTSMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IELTSMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IELTSMetadata&&(identical(other.candidateNumber, candidateNumber) || other.candidateNumber == candidateNumber)&&(identical(other.testReportNumber, testReportNumber) || other.testReportNumber == testReportNumber)&&(identical(other.testDate, testDate) || other.testDate == testDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.overallBand, overallBand) || other.overallBand == overallBand)&&(identical(other.listeningScore, listeningScore) || other.listeningScore == listeningScore)&&(identical(other.readingScore, readingScore) || other.readingScore == readingScore)&&(identical(other.writingScore, writingScore) || other.writingScore == writingScore)&&(identical(other.speakingScore, speakingScore) || other.speakingScore == speakingScore)&&(identical(other.testCenter, testCenter) || other.testCenter == testCenter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,candidateNumber,testReportNumber,testDate,expiryDate,overallBand,listeningScore,readingScore,writingScore,speakingScore,testCenter);

@override
String toString() {
  return 'DocumentMetadata.ielts(candidateNumber: $candidateNumber, testReportNumber: $testReportNumber, testDate: $testDate, expiryDate: $expiryDate, overallBand: $overallBand, listeningScore: $listeningScore, readingScore: $readingScore, writingScore: $writingScore, speakingScore: $speakingScore, testCenter: $testCenter)';
}


}

/// @nodoc
abstract mixin class $IELTSMetadataCopyWith<$Res> implements $DocumentMetadataCopyWith<$Res> {
  factory $IELTSMetadataCopyWith(IELTSMetadata value, $Res Function(IELTSMetadata) _then) = _$IELTSMetadataCopyWithImpl;
@useResult
$Res call({
 String candidateNumber, String testReportNumber, DateTime testDate, DateTime expiryDate, double overallBand, double listeningScore, double readingScore, double writingScore, double speakingScore, String testCenter
});




}
/// @nodoc
class _$IELTSMetadataCopyWithImpl<$Res>
    implements $IELTSMetadataCopyWith<$Res> {
  _$IELTSMetadataCopyWithImpl(this._self, this._then);

  final IELTSMetadata _self;
  final $Res Function(IELTSMetadata) _then;

/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? candidateNumber = null,Object? testReportNumber = null,Object? testDate = null,Object? expiryDate = null,Object? overallBand = null,Object? listeningScore = null,Object? readingScore = null,Object? writingScore = null,Object? speakingScore = null,Object? testCenter = null,}) {
  return _then(IELTSMetadata(
candidateNumber: null == candidateNumber ? _self.candidateNumber : candidateNumber // ignore: cast_nullable_to_non_nullable
as String,testReportNumber: null == testReportNumber ? _self.testReportNumber : testReportNumber // ignore: cast_nullable_to_non_nullable
as String,testDate: null == testDate ? _self.testDate : testDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,overallBand: null == overallBand ? _self.overallBand : overallBand // ignore: cast_nullable_to_non_nullable
as double,listeningScore: null == listeningScore ? _self.listeningScore : listeningScore // ignore: cast_nullable_to_non_nullable
as double,readingScore: null == readingScore ? _self.readingScore : readingScore // ignore: cast_nullable_to_non_nullable
as double,writingScore: null == writingScore ? _self.writingScore : writingScore // ignore: cast_nullable_to_non_nullable
as double,speakingScore: null == speakingScore ? _self.speakingScore : speakingScore // ignore: cast_nullable_to_non_nullable
as double,testCenter: null == testCenter ? _self.testCenter : testCenter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UnknownMetadata implements DocumentMetadata {
  const UnknownMetadata(final  Map<String, dynamic> data, {final  String? $type}): _data = data,$type = $type ?? 'unknown';
  factory UnknownMetadata.fromJson(Map<String, dynamic> json) => _$UnknownMetadataFromJson(json);

 final  Map<String, dynamic> _data;
 Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownMetadataCopyWith<UnknownMetadata> get copyWith => _$UnknownMetadataCopyWithImpl<UnknownMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnknownMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownMetadata&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'DocumentMetadata.unknown(data: $data)';
}


}

/// @nodoc
abstract mixin class $UnknownMetadataCopyWith<$Res> implements $DocumentMetadataCopyWith<$Res> {
  factory $UnknownMetadataCopyWith(UnknownMetadata value, $Res Function(UnknownMetadata) _then) = _$UnknownMetadataCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> data
});




}
/// @nodoc
class _$UnknownMetadataCopyWithImpl<$Res>
    implements $UnknownMetadataCopyWith<$Res> {
  _$UnknownMetadataCopyWithImpl(this._self, this._then);

  final UnknownMetadata _self;
  final $Res Function(UnknownMetadata) _then;

/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(UnknownMetadata(
null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on

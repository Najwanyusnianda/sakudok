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
                case 'sim':
          return SIMMetadata.fromJson(
            json
          );
                case 'passport':
          return PassportMetadata.fromJson(
            json
          );
                case 'ielts':
          return IELTSMetadata.fromJson(
            json
          );
                case 'transcript':
          return TranscriptMetadata.fromJson(
            json
          );
                case 'cv':
          return CVMetadata.fromJson(
            json
          );
                case 'certificate':
          return CertificateMetadata.fromJson(
            json
          );
                case 'diploma':
          return DiplomaMetadata.fromJson(
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( KTPMetadata value)?  ktp,TResult Function( SIMMetadata value)?  sim,TResult Function( PassportMetadata value)?  passport,TResult Function( IELTSMetadata value)?  ielts,TResult Function( TranscriptMetadata value)?  transcript,TResult Function( CVMetadata value)?  cv,TResult Function( CertificateMetadata value)?  certificate,TResult Function( DiplomaMetadata value)?  diploma,TResult Function( UnknownMetadata value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case KTPMetadata() when ktp != null:
return ktp(_that);case SIMMetadata() when sim != null:
return sim(_that);case PassportMetadata() when passport != null:
return passport(_that);case IELTSMetadata() when ielts != null:
return ielts(_that);case TranscriptMetadata() when transcript != null:
return transcript(_that);case CVMetadata() when cv != null:
return cv(_that);case CertificateMetadata() when certificate != null:
return certificate(_that);case DiplomaMetadata() when diploma != null:
return diploma(_that);case UnknownMetadata() when unknown != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( KTPMetadata value)  ktp,required TResult Function( SIMMetadata value)  sim,required TResult Function( PassportMetadata value)  passport,required TResult Function( IELTSMetadata value)  ielts,required TResult Function( TranscriptMetadata value)  transcript,required TResult Function( CVMetadata value)  cv,required TResult Function( CertificateMetadata value)  certificate,required TResult Function( DiplomaMetadata value)  diploma,required TResult Function( UnknownMetadata value)  unknown,}){
final _that = this;
switch (_that) {
case KTPMetadata():
return ktp(_that);case SIMMetadata():
return sim(_that);case PassportMetadata():
return passport(_that);case IELTSMetadata():
return ielts(_that);case TranscriptMetadata():
return transcript(_that);case CVMetadata():
return cv(_that);case CertificateMetadata():
return certificate(_that);case DiplomaMetadata():
return diploma(_that);case UnknownMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( KTPMetadata value)?  ktp,TResult? Function( SIMMetadata value)?  sim,TResult? Function( PassportMetadata value)?  passport,TResult? Function( IELTSMetadata value)?  ielts,TResult? Function( TranscriptMetadata value)?  transcript,TResult? Function( CVMetadata value)?  cv,TResult? Function( CertificateMetadata value)?  certificate,TResult? Function( DiplomaMetadata value)?  diploma,TResult? Function( UnknownMetadata value)?  unknown,}){
final _that = this;
switch (_that) {
case KTPMetadata() when ktp != null:
return ktp(_that);case SIMMetadata() when sim != null:
return sim(_that);case PassportMetadata() when passport != null:
return passport(_that);case IELTSMetadata() when ielts != null:
return ielts(_that);case TranscriptMetadata() when transcript != null:
return transcript(_that);case CVMetadata() when cv != null:
return cv(_that);case CertificateMetadata() when certificate != null:
return certificate(_that);case DiplomaMetadata() when diploma != null:
return diploma(_that);case UnknownMetadata() when unknown != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String nik,  String fullName,  String birthPlace,  DateTime birthDate,  String gender,  String? bloodType,  String address,  String? rt,  String? rw,  String? kelurahan,  String? kecamatan,  String? religion,  String? maritalStatus,  String? occupation,  String? citizenship,  DateTime? issuedDate,  String? issuedBy,  DateTime? expiryDate)?  ktp,TResult Function( String simNumber,  String holderName,  String simType,  DateTime issuedDate,  DateTime expiryDate,  String? issuingOffice,  String? address,  DateTime? birthDate)?  sim,TResult Function( String passportNumber,  String holderName,  String nationality,  DateTime birthDate,  String birthPlace,  String gender,  DateTime issuedDate,  DateTime expiryDate,  String? issuingAuthority,  String? placeOfIssue)?  passport,TResult Function( String candidateNumber,  String testReportNumber,  DateTime testDate,  DateTime expiryDate,  double overallBand,  double listeningScore,  double readingScore,  double writingScore,  double speakingScore,  String testCenter,  String? candidateName)?  ielts,TResult Function( String studentId,  String studentName,  String university,  String degree,  String major,  double gpa,  DateTime graduationDate,  DateTime? issuedDate,  String? facultyDean)?  transcript,TResult Function( String fullName,  String profession,  String email,  String phoneNumber,  DateTime? lastUpdated,  String? summary,  int? yearsOfExperience)?  cv,TResult Function( String certificateName,  String holderName,  String issuingOrganization,  DateTime issuedDate,  DateTime? expiryDate,  String? certificateNumber,  String? level)?  certificate,TResult Function( String diplomaNumber,  String graduateName,  String institution,  String degree,  String major,  DateTime graduationDate,  String? gpa,  String? honors)?  diploma,TResult Function( Map<String, dynamic> data)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case KTPMetadata() when ktp != null:
return ktp(_that.nik,_that.fullName,_that.birthPlace,_that.birthDate,_that.gender,_that.bloodType,_that.address,_that.rt,_that.rw,_that.kelurahan,_that.kecamatan,_that.religion,_that.maritalStatus,_that.occupation,_that.citizenship,_that.issuedDate,_that.issuedBy,_that.expiryDate);case SIMMetadata() when sim != null:
return sim(_that.simNumber,_that.holderName,_that.simType,_that.issuedDate,_that.expiryDate,_that.issuingOffice,_that.address,_that.birthDate);case PassportMetadata() when passport != null:
return passport(_that.passportNumber,_that.holderName,_that.nationality,_that.birthDate,_that.birthPlace,_that.gender,_that.issuedDate,_that.expiryDate,_that.issuingAuthority,_that.placeOfIssue);case IELTSMetadata() when ielts != null:
return ielts(_that.candidateNumber,_that.testReportNumber,_that.testDate,_that.expiryDate,_that.overallBand,_that.listeningScore,_that.readingScore,_that.writingScore,_that.speakingScore,_that.testCenter,_that.candidateName);case TranscriptMetadata() when transcript != null:
return transcript(_that.studentId,_that.studentName,_that.university,_that.degree,_that.major,_that.gpa,_that.graduationDate,_that.issuedDate,_that.facultyDean);case CVMetadata() when cv != null:
return cv(_that.fullName,_that.profession,_that.email,_that.phoneNumber,_that.lastUpdated,_that.summary,_that.yearsOfExperience);case CertificateMetadata() when certificate != null:
return certificate(_that.certificateName,_that.holderName,_that.issuingOrganization,_that.issuedDate,_that.expiryDate,_that.certificateNumber,_that.level);case DiplomaMetadata() when diploma != null:
return diploma(_that.diplomaNumber,_that.graduateName,_that.institution,_that.degree,_that.major,_that.graduationDate,_that.gpa,_that.honors);case UnknownMetadata() when unknown != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String nik,  String fullName,  String birthPlace,  DateTime birthDate,  String gender,  String? bloodType,  String address,  String? rt,  String? rw,  String? kelurahan,  String? kecamatan,  String? religion,  String? maritalStatus,  String? occupation,  String? citizenship,  DateTime? issuedDate,  String? issuedBy,  DateTime? expiryDate)  ktp,required TResult Function( String simNumber,  String holderName,  String simType,  DateTime issuedDate,  DateTime expiryDate,  String? issuingOffice,  String? address,  DateTime? birthDate)  sim,required TResult Function( String passportNumber,  String holderName,  String nationality,  DateTime birthDate,  String birthPlace,  String gender,  DateTime issuedDate,  DateTime expiryDate,  String? issuingAuthority,  String? placeOfIssue)  passport,required TResult Function( String candidateNumber,  String testReportNumber,  DateTime testDate,  DateTime expiryDate,  double overallBand,  double listeningScore,  double readingScore,  double writingScore,  double speakingScore,  String testCenter,  String? candidateName)  ielts,required TResult Function( String studentId,  String studentName,  String university,  String degree,  String major,  double gpa,  DateTime graduationDate,  DateTime? issuedDate,  String? facultyDean)  transcript,required TResult Function( String fullName,  String profession,  String email,  String phoneNumber,  DateTime? lastUpdated,  String? summary,  int? yearsOfExperience)  cv,required TResult Function( String certificateName,  String holderName,  String issuingOrganization,  DateTime issuedDate,  DateTime? expiryDate,  String? certificateNumber,  String? level)  certificate,required TResult Function( String diplomaNumber,  String graduateName,  String institution,  String degree,  String major,  DateTime graduationDate,  String? gpa,  String? honors)  diploma,required TResult Function( Map<String, dynamic> data)  unknown,}) {final _that = this;
switch (_that) {
case KTPMetadata():
return ktp(_that.nik,_that.fullName,_that.birthPlace,_that.birthDate,_that.gender,_that.bloodType,_that.address,_that.rt,_that.rw,_that.kelurahan,_that.kecamatan,_that.religion,_that.maritalStatus,_that.occupation,_that.citizenship,_that.issuedDate,_that.issuedBy,_that.expiryDate);case SIMMetadata():
return sim(_that.simNumber,_that.holderName,_that.simType,_that.issuedDate,_that.expiryDate,_that.issuingOffice,_that.address,_that.birthDate);case PassportMetadata():
return passport(_that.passportNumber,_that.holderName,_that.nationality,_that.birthDate,_that.birthPlace,_that.gender,_that.issuedDate,_that.expiryDate,_that.issuingAuthority,_that.placeOfIssue);case IELTSMetadata():
return ielts(_that.candidateNumber,_that.testReportNumber,_that.testDate,_that.expiryDate,_that.overallBand,_that.listeningScore,_that.readingScore,_that.writingScore,_that.speakingScore,_that.testCenter,_that.candidateName);case TranscriptMetadata():
return transcript(_that.studentId,_that.studentName,_that.university,_that.degree,_that.major,_that.gpa,_that.graduationDate,_that.issuedDate,_that.facultyDean);case CVMetadata():
return cv(_that.fullName,_that.profession,_that.email,_that.phoneNumber,_that.lastUpdated,_that.summary,_that.yearsOfExperience);case CertificateMetadata():
return certificate(_that.certificateName,_that.holderName,_that.issuingOrganization,_that.issuedDate,_that.expiryDate,_that.certificateNumber,_that.level);case DiplomaMetadata():
return diploma(_that.diplomaNumber,_that.graduateName,_that.institution,_that.degree,_that.major,_that.graduationDate,_that.gpa,_that.honors);case UnknownMetadata():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String nik,  String fullName,  String birthPlace,  DateTime birthDate,  String gender,  String? bloodType,  String address,  String? rt,  String? rw,  String? kelurahan,  String? kecamatan,  String? religion,  String? maritalStatus,  String? occupation,  String? citizenship,  DateTime? issuedDate,  String? issuedBy,  DateTime? expiryDate)?  ktp,TResult? Function( String simNumber,  String holderName,  String simType,  DateTime issuedDate,  DateTime expiryDate,  String? issuingOffice,  String? address,  DateTime? birthDate)?  sim,TResult? Function( String passportNumber,  String holderName,  String nationality,  DateTime birthDate,  String birthPlace,  String gender,  DateTime issuedDate,  DateTime expiryDate,  String? issuingAuthority,  String? placeOfIssue)?  passport,TResult? Function( String candidateNumber,  String testReportNumber,  DateTime testDate,  DateTime expiryDate,  double overallBand,  double listeningScore,  double readingScore,  double writingScore,  double speakingScore,  String testCenter,  String? candidateName)?  ielts,TResult? Function( String studentId,  String studentName,  String university,  String degree,  String major,  double gpa,  DateTime graduationDate,  DateTime? issuedDate,  String? facultyDean)?  transcript,TResult? Function( String fullName,  String profession,  String email,  String phoneNumber,  DateTime? lastUpdated,  String? summary,  int? yearsOfExperience)?  cv,TResult? Function( String certificateName,  String holderName,  String issuingOrganization,  DateTime issuedDate,  DateTime? expiryDate,  String? certificateNumber,  String? level)?  certificate,TResult? Function( String diplomaNumber,  String graduateName,  String institution,  String degree,  String major,  DateTime graduationDate,  String? gpa,  String? honors)?  diploma,TResult? Function( Map<String, dynamic> data)?  unknown,}) {final _that = this;
switch (_that) {
case KTPMetadata() when ktp != null:
return ktp(_that.nik,_that.fullName,_that.birthPlace,_that.birthDate,_that.gender,_that.bloodType,_that.address,_that.rt,_that.rw,_that.kelurahan,_that.kecamatan,_that.religion,_that.maritalStatus,_that.occupation,_that.citizenship,_that.issuedDate,_that.issuedBy,_that.expiryDate);case SIMMetadata() when sim != null:
return sim(_that.simNumber,_that.holderName,_that.simType,_that.issuedDate,_that.expiryDate,_that.issuingOffice,_that.address,_that.birthDate);case PassportMetadata() when passport != null:
return passport(_that.passportNumber,_that.holderName,_that.nationality,_that.birthDate,_that.birthPlace,_that.gender,_that.issuedDate,_that.expiryDate,_that.issuingAuthority,_that.placeOfIssue);case IELTSMetadata() when ielts != null:
return ielts(_that.candidateNumber,_that.testReportNumber,_that.testDate,_that.expiryDate,_that.overallBand,_that.listeningScore,_that.readingScore,_that.writingScore,_that.speakingScore,_that.testCenter,_that.candidateName);case TranscriptMetadata() when transcript != null:
return transcript(_that.studentId,_that.studentName,_that.university,_that.degree,_that.major,_that.gpa,_that.graduationDate,_that.issuedDate,_that.facultyDean);case CVMetadata() when cv != null:
return cv(_that.fullName,_that.profession,_that.email,_that.phoneNumber,_that.lastUpdated,_that.summary,_that.yearsOfExperience);case CertificateMetadata() when certificate != null:
return certificate(_that.certificateName,_that.holderName,_that.issuingOrganization,_that.issuedDate,_that.expiryDate,_that.certificateNumber,_that.level);case DiplomaMetadata() when diploma != null:
return diploma(_that.diplomaNumber,_that.graduateName,_that.institution,_that.degree,_that.major,_that.graduationDate,_that.gpa,_that.honors);case UnknownMetadata() when unknown != null:
return unknown(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class KTPMetadata implements DocumentMetadata {
  const KTPMetadata({required this.nik, required this.fullName, required this.birthPlace, required this.birthDate, required this.gender, this.bloodType, required this.address, this.rt, this.rw, this.kelurahan, this.kecamatan, this.religion, this.maritalStatus, this.occupation, this.citizenship, this.issuedDate, this.issuedBy, this.expiryDate, final  String? $type}): $type = $type ?? 'ktp';
  factory KTPMetadata.fromJson(Map<String, dynamic> json) => _$KTPMetadataFromJson(json);

 final  String nik;
 final  String fullName;
 final  String birthPlace;
 final  DateTime birthDate;
 final  String gender;
 final  String? bloodType;
 final  String address;
 final  String? rt;
 final  String? rw;
 final  String? kelurahan;
 final  String? kecamatan;
 final  String? religion;
 final  String? maritalStatus;
 final  String? occupation;
 final  String? citizenship;
 final  DateTime? issuedDate;
 final  String? issuedBy;
 final  DateTime? expiryDate;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KTPMetadata&&(identical(other.nik, nik) || other.nik == nik)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&(identical(other.address, address) || other.address == address)&&(identical(other.rt, rt) || other.rt == rt)&&(identical(other.rw, rw) || other.rw == rw)&&(identical(other.kelurahan, kelurahan) || other.kelurahan == kelurahan)&&(identical(other.kecamatan, kecamatan) || other.kecamatan == kecamatan)&&(identical(other.religion, religion) || other.religion == religion)&&(identical(other.maritalStatus, maritalStatus) || other.maritalStatus == maritalStatus)&&(identical(other.occupation, occupation) || other.occupation == occupation)&&(identical(other.citizenship, citizenship) || other.citizenship == citizenship)&&(identical(other.issuedDate, issuedDate) || other.issuedDate == issuedDate)&&(identical(other.issuedBy, issuedBy) || other.issuedBy == issuedBy)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nik,fullName,birthPlace,birthDate,gender,bloodType,address,rt,rw,kelurahan,kecamatan,religion,maritalStatus,occupation,citizenship,issuedDate,issuedBy,expiryDate);

@override
String toString() {
  return 'DocumentMetadata.ktp(nik: $nik, fullName: $fullName, birthPlace: $birthPlace, birthDate: $birthDate, gender: $gender, bloodType: $bloodType, address: $address, rt: $rt, rw: $rw, kelurahan: $kelurahan, kecamatan: $kecamatan, religion: $religion, maritalStatus: $maritalStatus, occupation: $occupation, citizenship: $citizenship, issuedDate: $issuedDate, issuedBy: $issuedBy, expiryDate: $expiryDate)';
}


}

/// @nodoc
abstract mixin class $KTPMetadataCopyWith<$Res> implements $DocumentMetadataCopyWith<$Res> {
  factory $KTPMetadataCopyWith(KTPMetadata value, $Res Function(KTPMetadata) _then) = _$KTPMetadataCopyWithImpl;
@useResult
$Res call({
 String nik, String fullName, String birthPlace, DateTime birthDate, String gender, String? bloodType, String address, String? rt, String? rw, String? kelurahan, String? kecamatan, String? religion, String? maritalStatus, String? occupation, String? citizenship, DateTime? issuedDate, String? issuedBy, DateTime? expiryDate
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
@pragma('vm:prefer-inline') $Res call({Object? nik = null,Object? fullName = null,Object? birthPlace = null,Object? birthDate = null,Object? gender = null,Object? bloodType = freezed,Object? address = null,Object? rt = freezed,Object? rw = freezed,Object? kelurahan = freezed,Object? kecamatan = freezed,Object? religion = freezed,Object? maritalStatus = freezed,Object? occupation = freezed,Object? citizenship = freezed,Object? issuedDate = freezed,Object? issuedBy = freezed,Object? expiryDate = freezed,}) {
  return _then(KTPMetadata(
nik: null == nik ? _self.nik : nik // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,bloodType: freezed == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,rt: freezed == rt ? _self.rt : rt // ignore: cast_nullable_to_non_nullable
as String?,rw: freezed == rw ? _self.rw : rw // ignore: cast_nullable_to_non_nullable
as String?,kelurahan: freezed == kelurahan ? _self.kelurahan : kelurahan // ignore: cast_nullable_to_non_nullable
as String?,kecamatan: freezed == kecamatan ? _self.kecamatan : kecamatan // ignore: cast_nullable_to_non_nullable
as String?,religion: freezed == religion ? _self.religion : religion // ignore: cast_nullable_to_non_nullable
as String?,maritalStatus: freezed == maritalStatus ? _self.maritalStatus : maritalStatus // ignore: cast_nullable_to_non_nullable
as String?,occupation: freezed == occupation ? _self.occupation : occupation // ignore: cast_nullable_to_non_nullable
as String?,citizenship: freezed == citizenship ? _self.citizenship : citizenship // ignore: cast_nullable_to_non_nullable
as String?,issuedDate: freezed == issuedDate ? _self.issuedDate : issuedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,issuedBy: freezed == issuedBy ? _self.issuedBy : issuedBy // ignore: cast_nullable_to_non_nullable
as String?,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SIMMetadata implements DocumentMetadata {
  const SIMMetadata({required this.simNumber, required this.holderName, required this.simType, required this.issuedDate, required this.expiryDate, this.issuingOffice, this.address, this.birthDate, final  String? $type}): $type = $type ?? 'sim';
  factory SIMMetadata.fromJson(Map<String, dynamic> json) => _$SIMMetadataFromJson(json);

 final  String simNumber;
 final  String holderName;
 final  String simType;
// A, B1, B2, C
 final  DateTime issuedDate;
 final  DateTime expiryDate;
// Critical for 30-day renewal reminders
 final  String? issuingOffice;
 final  String? address;
 final  DateTime? birthDate;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SIMMetadataCopyWith<SIMMetadata> get copyWith => _$SIMMetadataCopyWithImpl<SIMMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SIMMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SIMMetadata&&(identical(other.simNumber, simNumber) || other.simNumber == simNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.simType, simType) || other.simType == simType)&&(identical(other.issuedDate, issuedDate) || other.issuedDate == issuedDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.issuingOffice, issuingOffice) || other.issuingOffice == issuingOffice)&&(identical(other.address, address) || other.address == address)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,simNumber,holderName,simType,issuedDate,expiryDate,issuingOffice,address,birthDate);

@override
String toString() {
  return 'DocumentMetadata.sim(simNumber: $simNumber, holderName: $holderName, simType: $simType, issuedDate: $issuedDate, expiryDate: $expiryDate, issuingOffice: $issuingOffice, address: $address, birthDate: $birthDate)';
}


}

/// @nodoc
abstract mixin class $SIMMetadataCopyWith<$Res> implements $DocumentMetadataCopyWith<$Res> {
  factory $SIMMetadataCopyWith(SIMMetadata value, $Res Function(SIMMetadata) _then) = _$SIMMetadataCopyWithImpl;
@useResult
$Res call({
 String simNumber, String holderName, String simType, DateTime issuedDate, DateTime expiryDate, String? issuingOffice, String? address, DateTime? birthDate
});




}
/// @nodoc
class _$SIMMetadataCopyWithImpl<$Res>
    implements $SIMMetadataCopyWith<$Res> {
  _$SIMMetadataCopyWithImpl(this._self, this._then);

  final SIMMetadata _self;
  final $Res Function(SIMMetadata) _then;

/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? simNumber = null,Object? holderName = null,Object? simType = null,Object? issuedDate = null,Object? expiryDate = null,Object? issuingOffice = freezed,Object? address = freezed,Object? birthDate = freezed,}) {
  return _then(SIMMetadata(
simNumber: null == simNumber ? _self.simNumber : simNumber // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,simType: null == simType ? _self.simType : simType // ignore: cast_nullable_to_non_nullable
as String,issuedDate: null == issuedDate ? _self.issuedDate : issuedDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,issuingOffice: freezed == issuingOffice ? _self.issuingOffice : issuingOffice // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PassportMetadata implements DocumentMetadata {
  const PassportMetadata({required this.passportNumber, required this.holderName, required this.nationality, required this.birthDate, required this.birthPlace, required this.gender, required this.issuedDate, required this.expiryDate, this.issuingAuthority, this.placeOfIssue, final  String? $type}): $type = $type ?? 'passport';
  factory PassportMetadata.fromJson(Map<String, dynamic> json) => _$PassportMetadataFromJson(json);

 final  String passportNumber;
 final  String holderName;
 final  String nationality;
 final  DateTime birthDate;
 final  String birthPlace;
 final  String gender;
 final  DateTime issuedDate;
 final  DateTime expiryDate;
// Critical for 6-month travel reminders
 final  String? issuingAuthority;
 final  String? placeOfIssue;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PassportMetadataCopyWith<PassportMetadata> get copyWith => _$PassportMetadataCopyWithImpl<PassportMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PassportMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PassportMetadata&&(identical(other.passportNumber, passportNumber) || other.passportNumber == passportNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.issuedDate, issuedDate) || other.issuedDate == issuedDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.issuingAuthority, issuingAuthority) || other.issuingAuthority == issuingAuthority)&&(identical(other.placeOfIssue, placeOfIssue) || other.placeOfIssue == placeOfIssue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,passportNumber,holderName,nationality,birthDate,birthPlace,gender,issuedDate,expiryDate,issuingAuthority,placeOfIssue);

@override
String toString() {
  return 'DocumentMetadata.passport(passportNumber: $passportNumber, holderName: $holderName, nationality: $nationality, birthDate: $birthDate, birthPlace: $birthPlace, gender: $gender, issuedDate: $issuedDate, expiryDate: $expiryDate, issuingAuthority: $issuingAuthority, placeOfIssue: $placeOfIssue)';
}


}

/// @nodoc
abstract mixin class $PassportMetadataCopyWith<$Res> implements $DocumentMetadataCopyWith<$Res> {
  factory $PassportMetadataCopyWith(PassportMetadata value, $Res Function(PassportMetadata) _then) = _$PassportMetadataCopyWithImpl;
@useResult
$Res call({
 String passportNumber, String holderName, String nationality, DateTime birthDate, String birthPlace, String gender, DateTime issuedDate, DateTime expiryDate, String? issuingAuthority, String? placeOfIssue
});




}
/// @nodoc
class _$PassportMetadataCopyWithImpl<$Res>
    implements $PassportMetadataCopyWith<$Res> {
  _$PassportMetadataCopyWithImpl(this._self, this._then);

  final PassportMetadata _self;
  final $Res Function(PassportMetadata) _then;

/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? passportNumber = null,Object? holderName = null,Object? nationality = null,Object? birthDate = null,Object? birthPlace = null,Object? gender = null,Object? issuedDate = null,Object? expiryDate = null,Object? issuingAuthority = freezed,Object? placeOfIssue = freezed,}) {
  return _then(PassportMetadata(
passportNumber: null == passportNumber ? _self.passportNumber : passportNumber // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,issuedDate: null == issuedDate ? _self.issuedDate : issuedDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,issuingAuthority: freezed == issuingAuthority ? _self.issuingAuthority : issuingAuthority // ignore: cast_nullable_to_non_nullable
as String?,placeOfIssue: freezed == placeOfIssue ? _self.placeOfIssue : placeOfIssue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class IELTSMetadata implements DocumentMetadata {
  const IELTSMetadata({required this.candidateNumber, required this.testReportNumber, required this.testDate, required this.expiryDate, required this.overallBand, required this.listeningScore, required this.readingScore, required this.writingScore, required this.speakingScore, required this.testCenter, this.candidateName, final  String? $type}): $type = $type ?? 'ielts';
  factory IELTSMetadata.fromJson(Map<String, dynamic> json) => _$IELTSMetadataFromJson(json);

 final  String candidateNumber;
 final  String testReportNumber;
 final  DateTime testDate;
 final  DateTime expiryDate;
// IELTS valid for 2 years
 final  double overallBand;
 final  double listeningScore;
 final  double readingScore;
 final  double writingScore;
 final  double speakingScore;
 final  String testCenter;
 final  String? candidateName;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IELTSMetadata&&(identical(other.candidateNumber, candidateNumber) || other.candidateNumber == candidateNumber)&&(identical(other.testReportNumber, testReportNumber) || other.testReportNumber == testReportNumber)&&(identical(other.testDate, testDate) || other.testDate == testDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.overallBand, overallBand) || other.overallBand == overallBand)&&(identical(other.listeningScore, listeningScore) || other.listeningScore == listeningScore)&&(identical(other.readingScore, readingScore) || other.readingScore == readingScore)&&(identical(other.writingScore, writingScore) || other.writingScore == writingScore)&&(identical(other.speakingScore, speakingScore) || other.speakingScore == speakingScore)&&(identical(other.testCenter, testCenter) || other.testCenter == testCenter)&&(identical(other.candidateName, candidateName) || other.candidateName == candidateName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,candidateNumber,testReportNumber,testDate,expiryDate,overallBand,listeningScore,readingScore,writingScore,speakingScore,testCenter,candidateName);

@override
String toString() {
  return 'DocumentMetadata.ielts(candidateNumber: $candidateNumber, testReportNumber: $testReportNumber, testDate: $testDate, expiryDate: $expiryDate, overallBand: $overallBand, listeningScore: $listeningScore, readingScore: $readingScore, writingScore: $writingScore, speakingScore: $speakingScore, testCenter: $testCenter, candidateName: $candidateName)';
}


}

/// @nodoc
abstract mixin class $IELTSMetadataCopyWith<$Res> implements $DocumentMetadataCopyWith<$Res> {
  factory $IELTSMetadataCopyWith(IELTSMetadata value, $Res Function(IELTSMetadata) _then) = _$IELTSMetadataCopyWithImpl;
@useResult
$Res call({
 String candidateNumber, String testReportNumber, DateTime testDate, DateTime expiryDate, double overallBand, double listeningScore, double readingScore, double writingScore, double speakingScore, String testCenter, String? candidateName
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
@pragma('vm:prefer-inline') $Res call({Object? candidateNumber = null,Object? testReportNumber = null,Object? testDate = null,Object? expiryDate = null,Object? overallBand = null,Object? listeningScore = null,Object? readingScore = null,Object? writingScore = null,Object? speakingScore = null,Object? testCenter = null,Object? candidateName = freezed,}) {
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
as String,candidateName: freezed == candidateName ? _self.candidateName : candidateName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TranscriptMetadata implements DocumentMetadata {
  const TranscriptMetadata({required this.studentId, required this.studentName, required this.university, required this.degree, required this.major, required this.gpa, required this.graduationDate, this.issuedDate, this.facultyDean, final  String? $type}): $type = $type ?? 'transcript';
  factory TranscriptMetadata.fromJson(Map<String, dynamic> json) => _$TranscriptMetadataFromJson(json);

 final  String studentId;
 final  String studentName;
 final  String university;
 final  String degree;
 final  String major;
 final  double gpa;
 final  DateTime graduationDate;
 final  DateTime? issuedDate;
 final  String? facultyDean;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptMetadataCopyWith<TranscriptMetadata> get copyWith => _$TranscriptMetadataCopyWithImpl<TranscriptMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranscriptMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranscriptMetadata&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.university, university) || other.university == university)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.major, major) || other.major == major)&&(identical(other.gpa, gpa) || other.gpa == gpa)&&(identical(other.graduationDate, graduationDate) || other.graduationDate == graduationDate)&&(identical(other.issuedDate, issuedDate) || other.issuedDate == issuedDate)&&(identical(other.facultyDean, facultyDean) || other.facultyDean == facultyDean));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,studentId,studentName,university,degree,major,gpa,graduationDate,issuedDate,facultyDean);

@override
String toString() {
  return 'DocumentMetadata.transcript(studentId: $studentId, studentName: $studentName, university: $university, degree: $degree, major: $major, gpa: $gpa, graduationDate: $graduationDate, issuedDate: $issuedDate, facultyDean: $facultyDean)';
}


}

/// @nodoc
abstract mixin class $TranscriptMetadataCopyWith<$Res> implements $DocumentMetadataCopyWith<$Res> {
  factory $TranscriptMetadataCopyWith(TranscriptMetadata value, $Res Function(TranscriptMetadata) _then) = _$TranscriptMetadataCopyWithImpl;
@useResult
$Res call({
 String studentId, String studentName, String university, String degree, String major, double gpa, DateTime graduationDate, DateTime? issuedDate, String? facultyDean
});




}
/// @nodoc
class _$TranscriptMetadataCopyWithImpl<$Res>
    implements $TranscriptMetadataCopyWith<$Res> {
  _$TranscriptMetadataCopyWithImpl(this._self, this._then);

  final TranscriptMetadata _self;
  final $Res Function(TranscriptMetadata) _then;

/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? studentId = null,Object? studentName = null,Object? university = null,Object? degree = null,Object? major = null,Object? gpa = null,Object? graduationDate = null,Object? issuedDate = freezed,Object? facultyDean = freezed,}) {
  return _then(TranscriptMetadata(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,university: null == university ? _self.university : university // ignore: cast_nullable_to_non_nullable
as String,degree: null == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String,major: null == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as String,gpa: null == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as double,graduationDate: null == graduationDate ? _self.graduationDate : graduationDate // ignore: cast_nullable_to_non_nullable
as DateTime,issuedDate: freezed == issuedDate ? _self.issuedDate : issuedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,facultyDean: freezed == facultyDean ? _self.facultyDean : facultyDean // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CVMetadata implements DocumentMetadata {
  const CVMetadata({required this.fullName, required this.profession, required this.email, required this.phoneNumber, this.lastUpdated, this.summary, this.yearsOfExperience, final  String? $type}): $type = $type ?? 'cv';
  factory CVMetadata.fromJson(Map<String, dynamic> json) => _$CVMetadataFromJson(json);

 final  String fullName;
 final  String profession;
 final  String email;
 final  String phoneNumber;
 final  DateTime? lastUpdated;
 final  String? summary;
 final  int? yearsOfExperience;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CVMetadataCopyWith<CVMetadata> get copyWith => _$CVMetadataCopyWithImpl<CVMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CVMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CVMetadata&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profession, profession) || other.profession == profession)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.yearsOfExperience, yearsOfExperience) || other.yearsOfExperience == yearsOfExperience));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,profession,email,phoneNumber,lastUpdated,summary,yearsOfExperience);

@override
String toString() {
  return 'DocumentMetadata.cv(fullName: $fullName, profession: $profession, email: $email, phoneNumber: $phoneNumber, lastUpdated: $lastUpdated, summary: $summary, yearsOfExperience: $yearsOfExperience)';
}


}

/// @nodoc
abstract mixin class $CVMetadataCopyWith<$Res> implements $DocumentMetadataCopyWith<$Res> {
  factory $CVMetadataCopyWith(CVMetadata value, $Res Function(CVMetadata) _then) = _$CVMetadataCopyWithImpl;
@useResult
$Res call({
 String fullName, String profession, String email, String phoneNumber, DateTime? lastUpdated, String? summary, int? yearsOfExperience
});




}
/// @nodoc
class _$CVMetadataCopyWithImpl<$Res>
    implements $CVMetadataCopyWith<$Res> {
  _$CVMetadataCopyWithImpl(this._self, this._then);

  final CVMetadata _self;
  final $Res Function(CVMetadata) _then;

/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? profession = null,Object? email = null,Object? phoneNumber = null,Object? lastUpdated = freezed,Object? summary = freezed,Object? yearsOfExperience = freezed,}) {
  return _then(CVMetadata(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,profession: null == profession ? _self.profession : profession // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,yearsOfExperience: freezed == yearsOfExperience ? _self.yearsOfExperience : yearsOfExperience // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CertificateMetadata implements DocumentMetadata {
  const CertificateMetadata({required this.certificateName, required this.holderName, required this.issuingOrganization, required this.issuedDate, this.expiryDate, this.certificateNumber, this.level, final  String? $type}): $type = $type ?? 'certificate';
  factory CertificateMetadata.fromJson(Map<String, dynamic> json) => _$CertificateMetadataFromJson(json);

 final  String certificateName;
 final  String holderName;
 final  String issuingOrganization;
 final  DateTime issuedDate;
 final  DateTime? expiryDate;
// Some certificates expire
 final  String? certificateNumber;
 final  String? level;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CertificateMetadataCopyWith<CertificateMetadata> get copyWith => _$CertificateMetadataCopyWithImpl<CertificateMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CertificateMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CertificateMetadata&&(identical(other.certificateName, certificateName) || other.certificateName == certificateName)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.issuingOrganization, issuingOrganization) || other.issuingOrganization == issuingOrganization)&&(identical(other.issuedDate, issuedDate) || other.issuedDate == issuedDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.certificateNumber, certificateNumber) || other.certificateNumber == certificateNumber)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,certificateName,holderName,issuingOrganization,issuedDate,expiryDate,certificateNumber,level);

@override
String toString() {
  return 'DocumentMetadata.certificate(certificateName: $certificateName, holderName: $holderName, issuingOrganization: $issuingOrganization, issuedDate: $issuedDate, expiryDate: $expiryDate, certificateNumber: $certificateNumber, level: $level)';
}


}

/// @nodoc
abstract mixin class $CertificateMetadataCopyWith<$Res> implements $DocumentMetadataCopyWith<$Res> {
  factory $CertificateMetadataCopyWith(CertificateMetadata value, $Res Function(CertificateMetadata) _then) = _$CertificateMetadataCopyWithImpl;
@useResult
$Res call({
 String certificateName, String holderName, String issuingOrganization, DateTime issuedDate, DateTime? expiryDate, String? certificateNumber, String? level
});




}
/// @nodoc
class _$CertificateMetadataCopyWithImpl<$Res>
    implements $CertificateMetadataCopyWith<$Res> {
  _$CertificateMetadataCopyWithImpl(this._self, this._then);

  final CertificateMetadata _self;
  final $Res Function(CertificateMetadata) _then;

/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? certificateName = null,Object? holderName = null,Object? issuingOrganization = null,Object? issuedDate = null,Object? expiryDate = freezed,Object? certificateNumber = freezed,Object? level = freezed,}) {
  return _then(CertificateMetadata(
certificateName: null == certificateName ? _self.certificateName : certificateName // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,issuingOrganization: null == issuingOrganization ? _self.issuingOrganization : issuingOrganization // ignore: cast_nullable_to_non_nullable
as String,issuedDate: null == issuedDate ? _self.issuedDate : issuedDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,certificateNumber: freezed == certificateNumber ? _self.certificateNumber : certificateNumber // ignore: cast_nullable_to_non_nullable
as String?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DiplomaMetadata implements DocumentMetadata {
  const DiplomaMetadata({required this.diplomaNumber, required this.graduateName, required this.institution, required this.degree, required this.major, required this.graduationDate, this.gpa, this.honors, final  String? $type}): $type = $type ?? 'diploma';
  factory DiplomaMetadata.fromJson(Map<String, dynamic> json) => _$DiplomaMetadataFromJson(json);

 final  String diplomaNumber;
 final  String graduateName;
 final  String institution;
 final  String degree;
 final  String major;
 final  DateTime graduationDate;
 final  String? gpa;
 final  String? honors;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiplomaMetadataCopyWith<DiplomaMetadata> get copyWith => _$DiplomaMetadataCopyWithImpl<DiplomaMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiplomaMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiplomaMetadata&&(identical(other.diplomaNumber, diplomaNumber) || other.diplomaNumber == diplomaNumber)&&(identical(other.graduateName, graduateName) || other.graduateName == graduateName)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.major, major) || other.major == major)&&(identical(other.graduationDate, graduationDate) || other.graduationDate == graduationDate)&&(identical(other.gpa, gpa) || other.gpa == gpa)&&(identical(other.honors, honors) || other.honors == honors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,diplomaNumber,graduateName,institution,degree,major,graduationDate,gpa,honors);

@override
String toString() {
  return 'DocumentMetadata.diploma(diplomaNumber: $diplomaNumber, graduateName: $graduateName, institution: $institution, degree: $degree, major: $major, graduationDate: $graduationDate, gpa: $gpa, honors: $honors)';
}


}

/// @nodoc
abstract mixin class $DiplomaMetadataCopyWith<$Res> implements $DocumentMetadataCopyWith<$Res> {
  factory $DiplomaMetadataCopyWith(DiplomaMetadata value, $Res Function(DiplomaMetadata) _then) = _$DiplomaMetadataCopyWithImpl;
@useResult
$Res call({
 String diplomaNumber, String graduateName, String institution, String degree, String major, DateTime graduationDate, String? gpa, String? honors
});




}
/// @nodoc
class _$DiplomaMetadataCopyWithImpl<$Res>
    implements $DiplomaMetadataCopyWith<$Res> {
  _$DiplomaMetadataCopyWithImpl(this._self, this._then);

  final DiplomaMetadata _self;
  final $Res Function(DiplomaMetadata) _then;

/// Create a copy of DocumentMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? diplomaNumber = null,Object? graduateName = null,Object? institution = null,Object? degree = null,Object? major = null,Object? graduationDate = null,Object? gpa = freezed,Object? honors = freezed,}) {
  return _then(DiplomaMetadata(
diplomaNumber: null == diplomaNumber ? _self.diplomaNumber : diplomaNumber // ignore: cast_nullable_to_non_nullable
as String,graduateName: null == graduateName ? _self.graduateName : graduateName // ignore: cast_nullable_to_non_nullable
as String,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String,degree: null == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String,major: null == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as String,graduationDate: null == graduationDate ? _self.graduationDate : graduationDate // ignore: cast_nullable_to_non_nullable
as DateTime,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as String?,honors: freezed == honors ? _self.honors : honors // ignore: cast_nullable_to_non_nullable
as String?,
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

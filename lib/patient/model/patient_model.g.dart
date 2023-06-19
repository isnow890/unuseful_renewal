// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => PatientModelList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

PatientModelList _$PatientModelListFromJson(Map<String, dynamic> json) =>
    PatientModelList(
      ptNo: json['ptNo'] as String,
      ptNm: json['ptNm'] as String,
      diagnosis: json['diagnosis'] as String?,
      hspTpCd: DataUtils.hspTpCdToNm(json['hspTpCd'] as String),
      sexTpCd: json['sexTpCd'] as String,
      wardInfo: json['wardInfo'] as String,
      blindedPtNm: json['blindedPtNm'] as String,
    );

Map<String, dynamic> _$PatientModelListToJson(PatientModelList instance) =>
    <String, dynamic>{
      'ptNo': instance.ptNo,
      'ptNm': instance.ptNm,
      'diagnosis': instance.diagnosis,
      'hspTpCd': instance.hspTpCd,
      'sexTpCd': instance.sexTpCd,
      'wardInfo': instance.wardInfo,
      'blindedPtNm': instance.blindedPtNm,
    };

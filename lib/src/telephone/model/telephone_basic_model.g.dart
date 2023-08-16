// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telephone_basic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TelephoneBasicModel _$TelephoneBasicModelFromJson(Map<String, dynamic> json) =>
    TelephoneBasicModel(
      deptNm: json['deptNm'] as String?,
      telNoNm: json['telNoNm'] as String?,
      hspTpCd: json['hspTpCd'] as String?,
      etntTelNo: json['etntTelNo'] as String?,
      telNoAbbrNm: json['telNoAbbrNm'] as String?,
      sectDeptNm: json['sectDeptNm'] as String?,
      orderSeq: json['orderSeq'] as int,
      purifiedTelNo: json['purifiedTelNo'] as String?,
    );

Map<String, dynamic> _$TelephoneBasicModelToJson(
        TelephoneBasicModel instance) =>
    <String, dynamic>{
      'deptNm': instance.deptNm,
      'telNoNm': instance.telNoNm,
      'hspTpCd': instance.hspTpCd,
      'etntTelNo': instance.etntTelNo,
      'telNoAbbrNm': instance.telNoAbbrNm,
      'sectDeptNm': instance.sectDeptNm,
      'orderSeq': instance.orderSeq,
      'purifiedTelNo': instance.purifiedTelNo,
    };

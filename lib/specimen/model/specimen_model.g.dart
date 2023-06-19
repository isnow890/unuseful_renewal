// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specimen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecimenModel _$SpecimenModelFromJson(Map<String, dynamic> json) =>
    SpecimenModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SpecimenPrimaryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpecimenModelToJson(SpecimenModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

SpecimenPrimaryModel _$SpecimenPrimaryModelFromJson(
        Map<String, dynamic> json) =>
    SpecimenPrimaryModel(
      ordDt: json['ordDt'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SpecimenExmTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpecimenPrimaryModelToJson(
        SpecimenPrimaryModel instance) =>
    <String, dynamic>{
      'ordDt': instance.ordDt,
      'data': instance.data,
    };

SpecimenExmTypeModel _$SpecimenExmTypeModelFromJson(
        Map<String, dynamic> json) =>
    SpecimenExmTypeModel(
      ordDt: json['ordDt'] as String,
      exrmExmCtgCd: json['exrmExmCtgCd'] as String,
      exmCtgAbbrNm: json['exmCtgAbbrNm'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SpecimenGeneralModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpecimenExmTypeModelToJson(
        SpecimenExmTypeModel instance) =>
    <String, dynamic>{
      'ordDt': instance.ordDt,
      'exrmExmCtgCd': instance.exrmExmCtgCd,
      'exmCtgAbbrNm': instance.exmCtgAbbrNm,
      'data': instance.data,
    };

SpecimenGeneralModel _$SpecimenGeneralModelFromJson(
        Map<String, dynamic> json) =>
    SpecimenGeneralModel(
      ordDt: DateTime.parse(json['ordDt'] as String),
      spcmNo: json['spcmNo'] as String,
      exmAcptNo: json['exmAcptNo'] as String,
      ptNo: json['ptNo'] as String,
      blclDtm: json['blclDtm'] == null
          ? null
          : DateTime.parse(json['blclDtm'] as String),
      blclStfNo: json['blclStfNo'] as String,
      rcpnStfNo: json['rcpnStfNo'] as String,
      brfgDtm: json['brfgDtm'] == null
          ? null
          : DateTime.parse(json['brfgDtm'] as String),
      acptDtm: json['acptDtm'] == null
          ? null
          : DateTime.parse(json['acptDtm'] as String),
      exmPrgrStsNm: json['exmPrgrStsNm'] as String,
      exmPrgrStsCd: json['exmPrgrStsCd'] as String,
      exrmExmCtgCd: json['exrmExmCtgCd'] as String,
      hspTpCd: json['hspTpCd'] as String,
      hspTpNm: json['hspTpNm'] as String,
      rstCnsgYn: json['rstCnsgYn'] as String,
      emrgYn: json['emrgYn'] as String,
      exmCtgAbbrNm: json['exmCtgAbbrNm'] as String,
      orderSeq: json['orderSeq'] as int,
    );

Map<String, dynamic> _$SpecimenGeneralModelToJson(
        SpecimenGeneralModel instance) =>
    <String, dynamic>{
      'ordDt': instance.ordDt.toIso8601String(),
      'spcmNo': instance.spcmNo,
      'exmAcptNo': instance.exmAcptNo,
      'ptNo': instance.ptNo,
      'blclDtm': instance.blclDtm?.toIso8601String(),
      'blclStfNo': instance.blclStfNo,
      'rcpnStfNo': instance.rcpnStfNo,
      'brfgDtm': instance.brfgDtm?.toIso8601String(),
      'acptDtm': instance.acptDtm?.toIso8601String(),
      'exmPrgrStsNm': instance.exmPrgrStsNm,
      'exmPrgrStsCd': instance.exmPrgrStsCd,
      'exrmExmCtgCd': instance.exrmExmCtgCd,
      'hspTpCd': instance.hspTpCd,
      'hspTpNm': instance.hspTpNm,
      'rstCnsgYn': instance.rstCnsgYn,
      'emrgYn': instance.emrgYn,
      'exmCtgAbbrNm': instance.exmCtgAbbrNm,
      'orderSeq': instance.orderSeq,
    };

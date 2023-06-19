// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specimen_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecimenDetailModel _$SpecimenDetailModelFromJson(Map<String, dynamic> json) =>
    SpecimenDetailModel(
      exmCtgCd: json['exmCtgCd'] as String,
      exmCtgAbbrNm: json['exmCtgAbbrNm'] as String,
      spcmNo: json['spcmNo'] as String,
      exrsCnte: json['exrsCnte'] as String,
      eitmAbbr: json['eitmAbbr'] as String,
      exmCd: json['exmCd'] as String,
      exrsUnit: json['exrsUnit'] as String,
      srefval: json['srefval'] as String,
      orderSeq: json['orderSeq'] as int,
    );

Map<String, dynamic> _$SpecimenDetailModelToJson(
        SpecimenDetailModel instance) =>
    <String, dynamic>{
      'exmCtgCd': instance.exmCtgCd,
      'exmCtgAbbrNm': instance.exmCtgAbbrNm,
      'spcmNo': instance.spcmNo,
      'exrsCnte': instance.exrsCnte,
      'eitmAbbr': instance.eitmAbbr,
      'exmCd': instance.exmCd,
      'exrsUnit': instance.exrsUnit,
      'srefval': instance.srefval,
      'orderSeq': instance.orderSeq,
    };

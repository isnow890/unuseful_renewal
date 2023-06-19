// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specimen_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecimenParams _$SpecimenParamsFromJson(Map<String, dynamic> json) =>
    SpecimenParams(
      hspTpCd: json['hspTpCd'] as String,
      searchValue: json['searchValue'] as String,
      strDt: json['strDt'] as String,
      endDt: json['endDt'] as String,
      orderBy: json['orderBy'] as String,
    );

Map<String, dynamic> _$SpecimenParamsToJson(SpecimenParams instance) =>
    <String, dynamic>{
      'hspTpCd': instance.hspTpCd,
      'searchValue': instance.searchValue,
      'strDt': instance.strDt,
      'endDt': instance.endDt,
      'orderBy': instance.orderBy,
    };

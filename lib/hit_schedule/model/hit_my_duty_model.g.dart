// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hit_my_duty_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HitMyDutyModel _$HitMyDutyModelFromJson(Map<String, dynamic> json) =>
    HitMyDutyModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => HitMyDutyListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HitMyDutyModelToJson(HitMyDutyModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

HitMyDutyListModel _$HitMyDutyListModelFromJson(Map<String, dynamic> json) =>
    HitMyDutyListModel(
      wkMonth: json['wkMonth'] as String,
      wkDate: json['wkDate'] as String,
      day: json['day'] as String,
      stfNo: json['stfNo'] as String,
      stfNm: json['stfNm'] as String,
      wkSeq: json['wkSeq'] as String,
      hdyYn: json['hdyYn'] as String,
      dutyTypeNm: json['dutyTypeNm'] as String,
      dutyTypeCode: json['dutyTypeCode'] as String,
    );

Map<String, dynamic> _$HitMyDutyListModelToJson(HitMyDutyListModel instance) =>
    <String, dynamic>{
      'wkMonth': instance.wkMonth,
      'wkDate': instance.wkDate,
      'day': instance.day,
      'stfNo': instance.stfNo,
      'stfNm': instance.stfNm,
      'wkSeq': instance.wkSeq,
      'hdyYn': instance.hdyYn,
      'dutyTypeNm': instance.dutyTypeNm,
      'dutyTypeCode': instance.dutyTypeCode,
    };

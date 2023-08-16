// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hit_schedule_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HitDutyLogModel _$HitDutyLogModelFromJson(Map<String, dynamic> json) =>
    HitDutyLogModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => HitDutyLogListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HitDutyLogModelToJson(HitDutyLogModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

HitDutyLogListModel _$HitDutyLogListModelFromJson(Map<String, dynamic> json) =>
    HitDutyLogListModel(
      changeDate: DateTime.parse(json['changeDate'] as String),
      stfInfo: json['stfInfo'] as String,
      changeInfo: json['changeInfo'] as String,
    );

Map<String, dynamic> _$HitDutyLogListModelToJson(
        HitDutyLogListModel instance) =>
    <String, dynamic>{
      'changeDate': instance.changeDate.toIso8601String(),
      'stfInfo': instance.stfInfo,
      'changeInfo': instance.changeInfo,
    };

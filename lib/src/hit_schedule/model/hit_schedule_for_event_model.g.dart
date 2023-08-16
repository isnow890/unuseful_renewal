// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hit_schedule_for_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HitScheduleForEventModel _$HitScheduleForEventModelFromJson(
        Map<String, dynamic> json) =>
    HitScheduleForEventModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              HitScheduleForEventListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HitScheduleForEventModelToJson(
        HitScheduleForEventModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

HitScheduleForEventListModel _$HitScheduleForEventListModelFromJson(
        Map<String, dynamic> json) =>
    HitScheduleForEventListModel(
      scheduleDate: json['scheduleDate'] == null
          ? null
          : DateTime.parse(json['scheduleDate'] as String),
      count: json['count'] as int,
      morningNm: json['morningNm'] as String?,
      afternoonNm: json['afternoonNm'] as String?,
    );

Map<String, dynamic> _$HitScheduleForEventListModelToJson(
        HitScheduleForEventListModel instance) =>
    <String, dynamic>{
      'scheduleDate': instance.scheduleDate?.toIso8601String(),
      'count': instance.count,
      'morningNm': instance.morningNm,
      'afternoonNm': instance.afternoonNm,
    };

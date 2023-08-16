// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmRegistrationModel _$FcmRegistrationModelFromJson(
        Map<String, dynamic> json) =>
    FcmRegistrationModel(
      lastUsedDate: json['lastUsedDate'] == null
          ? null
          : DateTime.parse(json['lastUsedDate'] as String),
      fcmToken: json['fcmToken'] as String?,
      isHitDutyAlarm: json['isHitDutyAlarm'] as bool?,
      isMealAlarm: json['isMealAlarm'] as bool?,
      sid: json['sid'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$FcmRegistrationModelToJson(
        FcmRegistrationModel instance) =>
    <String, dynamic>{
      'lastUsedDate': instance.lastUsedDate?.toIso8601String(),
      'fcmToken': instance.fcmToken,
      'isHitDutyAlarm': instance.isHitDutyAlarm,
      'isMealAlarm': instance.isMealAlarm,
      'sid': instance.sid,
      'id': instance.id,
    };

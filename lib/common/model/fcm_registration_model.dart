import 'package:json_annotation/json_annotation.dart';

part 'fcm_registration_model.g.dart';

@JsonSerializable()
class FcmRegistrationModel {
  final DateTime? lastUsedDate;
  final String? fcmToken;
  final bool? isHitDutyAlarm;
  final bool? isMealAlarm;
  final String? sid;
  final String? id;

  const FcmRegistrationModel({
    required this.lastUsedDate,
    required this.fcmToken,
    required this.isHitDutyAlarm,
    required this.isMealAlarm,
    required this.sid,
    required this.id,
  });

  factory FcmRegistrationModel.fromJson(Map<String,dynamic> json)
  =>_$FcmRegistrationModelFromJson(json);

  Map<String, dynamic> toJson() => _$FcmRegistrationModelToJson(this);


}

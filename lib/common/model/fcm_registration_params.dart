import 'package:json_annotation/json_annotation.dart';

part 'fcm_registration_params.g.dart';

@JsonSerializable()
class FcmRegistrationParams {
  final DateTime? lastUsedDate;
  final String? fcmToken;
  final bool? isHitDutyAlarm;
  final bool? isMealAlarm;
  final String? sid;
  final String? id;

  const FcmRegistrationParams({
    required this.lastUsedDate,
    required this.fcmToken,
    required this.isHitDutyAlarm,
    required this.isMealAlarm,
    required this.sid,
    required this.id,
  });

  factory FcmRegistrationParams.fromJson(Map<String,dynamic> json)
  =>_$FcmRegistrationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$FcmRegistrationParamsToJson(this);


}

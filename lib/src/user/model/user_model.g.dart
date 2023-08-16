// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      hspTpCd: json['hspTpCd'] as String?,
      stfNo: json['stfNo'] as String?,
      message: json['message'] as String?,
      stfNm: json['stfNm'] as String?,
      deptCd: json['deptCd'] as String?,
      deptNm: json['deptNm'] as String?,
      drYn: DataHelper.toBool(json['drYn'] as String?),
      hitDutyYn: json['hitDutyYn'] as String?,
      advancedType:
          DataHelper.findAdvanceTypeEnum(json['advancedType'] as String?),
      accessKey: json['accessKey'] as String?,
      sid: json['sid'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'hspTpCd': instance.hspTpCd,
      'stfNo': instance.stfNo,
      'message': instance.message,
      'stfNm': instance.stfNm,
      'deptCd': instance.deptCd,
      'deptNm': instance.deptNm,
      'drYn': instance.drYn,
      'hitDutyYn': instance.hitDutyYn,
      'advancedType': _$AdvancedTypeEnumMap[instance.advancedType],
      'accessKey': instance.accessKey,
      'sid': instance.sid,
    };

const _$AdvancedTypeEnumMap = {
  AdvancedType.basic: 'basic',
  AdvancedType.advance: 'advance',
  AdvancedType.master: 'master',
};

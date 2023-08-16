import 'package:json_annotation/json_annotation.dart';
import 'package:unuseful/src/common/model/model_base.dart';

import '../../../util/helper/data_utils.dart';

part 'user_model.g.dart';

enum AdvancedType {
  basic,
  advance,
  master,
}

@JsonSerializable()
class UserModel extends ModelBase {
  final String? hspTpCd;
  final String? stfNo;
  final String? message;
  final String? stfNm;
  final String? deptCd;
  final String? deptNm;

  @JsonKey(
    fromJson: DataHelper.toBool,
  )
  final bool? drYn;

  final String? hitDutyYn;

  @JsonKey(fromJson: DataHelper.findAdvanceTypeEnum)
  final AdvancedType? advancedType;
  final String? accessKey;
  final String? sid;

  UserModel({
    this.hspTpCd,
    this.stfNo,
    this.message,
    this.stfNm,
    this.deptCd,
    this.deptNm,
    this.drYn,
    this.hitDutyYn,
    this.advancedType,
    this.accessKey,
    this.sid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserModel copyWIth({
    String? hspTpCd,
    String? stfNo,
    String? message,
    String? stfNm,
    String? deptCd,
    String? deptNm,
    bool? drYn,
    String? hitDutyYn,
    AdvancedType? advancedType,
    String? accessKey,
    String? sid,
  }) {
    return UserModel(
      hspTpCd: hspTpCd ?? this.hspTpCd,
      stfNo: stfNo ?? this.stfNo,
      message: message ?? this.message,
      stfNm: stfNm ?? this.stfNm,
      deptCd: deptCd ?? this.deptCd,
      deptNm: deptNm ?? this.deptNm,
      drYn: drYn ?? this.drYn,
      hitDutyYn: hitDutyYn ?? this.hitDutyYn,
      advancedType: advancedType ?? this.advancedType,
      accessKey: accessKey ?? this.accessKey,
      sid: sid ?? this.sid,
    );
  }
}

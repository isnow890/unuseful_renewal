import 'package:json_annotation/json_annotation.dart';
import '../../common/utils/data_utils.dart';

part 'user_model.g.dart';


enum AdvancedType {
  basic,
  advance,
  master,
}
abstract class UserModelBase{}

//에러났을때
class UserModelError extends UserModelBase{
  final String message;
  UserModelError({required this.message});
}

//로딩중

class UserModelLoading extends UserModelBase{}

@JsonSerializable()
class UserModel extends UserModelBase{

  final String hspTpCd;
  final String stfNo;
  final String message;
  final String stfNm;
  final String deptCd;
  final String deptNm;
  @JsonKey(
  fromJson: DataUtils.toBool,
  )
  final bool drYn;
  @JsonKey(
  fromJson: DataUtils.toBool,
  )
  final bool hitDutyYn;
  @JsonKey(
  fromJson: DataUtils.findAdvanceTypeEnum
  )
  final AdvancedType advancedType;
  final String accessKey;

  UserModel({
  required this.hspTpCd,
  required this.stfNo,
  required this.message,
  required this.stfNm,
  required this.deptCd,
  required this.deptNm,
  required this.drYn,
  required this.hitDutyYn,
  required this.advancedType,
  required this.accessKey,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
  _$UserModelFromJson(json);
  }




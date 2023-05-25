import 'package:json_annotation/json_annotation.dart';
import '../../common/utils/data_utils.dart';

part 'user_model.g.dart';


enum AdvanceType {
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

  final String HSP_TP_CD;
  final String STF_NO;
  final String MESSAGE;
  final String STF_NM;
  final String DEPT_CD;
  final String DEPT_NM;
  @JsonKey(
  fromJson: DataUtils.toBool,
  )
  final bool DR_YN;
  @JsonKey(
  fromJson: DataUtils.toBool,
  )
  final bool HITDUTY_YN;
  @JsonKey(
  fromJson: DataUtils.findAdvanceTypeEnum
  )
  final AdvanceType ADVANCE_TYPE;
  final String ACCESS_KEY;

  UserModel({
  required this.HSP_TP_CD,
  required this.STF_NO,
  required this.MESSAGE,
  required this.STF_NM,
  required this.DEPT_CD,
  required this.DEPT_NM,
  required this.DR_YN,
  required this.HITDUTY_YN,
  required this.ADVANCE_TYPE,
  required this.ACCESS_KEY,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
  _$UserModelFromJson(json);
  }




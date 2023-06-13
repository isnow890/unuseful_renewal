import 'package:json_annotation/json_annotation.dart';
import '../../common/utils/data_utils.dart';

part 'user_model.g.dart';

enum AdvancedType {
  basic,
  advance,
  master,
}

abstract class UserModelBase {}

//에러났을때
class UserModelError extends UserModelBase {
  final String message;

  UserModelError({required this.message}) {
    print('생성');
  }
}

//로딩중

class UserModelLoading extends UserModelBase {}

// {"stfNo":"30430","message":null,"stfNm":"양찬우","deptCd":"HIT","deptNm":"HIT","drYn":null,"advancedType":"basic","hitDutyYn":"Y"}
@JsonSerializable()
class UserModel extends UserModelBase {
  final String? stfNo;
  final String? message;
  final String? stfNm;
  final String? deptCd;
  final String? deptNm;
  @JsonKey(
    fromJson: DataUtils.toBool,
  )
  final bool? drYn;

  final String? hitDutyYn;

  @JsonKey(fromJson: DataUtils.findAdvanceTypeEnum)
  final AdvancedType? advancedType;
  final String? accessKey;

  UserModel({
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

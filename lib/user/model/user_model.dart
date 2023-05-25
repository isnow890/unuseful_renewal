import 'package:json_annotation/json_annotation.dart';
import '../../common/utils/data_utils.dart';

part 'user_model.g.dart';


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
  final String STF_NO;
  final String KOR_NM;
  @JsonKey(
    fromJson : DataUtils.pathToUrl,
  )
  UserModel( {required this.STF_NO, required this.KOR_NM});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

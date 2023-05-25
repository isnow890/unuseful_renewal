import 'package:json_annotation/json_annotation.dart';

part 'login_reponse.g.dart';

@JsonSerializable()
class LoginResponse {
  final String HSP_TP_CD;
  final String STF_NO;
  final String MESSAGE;
  final String STF_NM;
  final String DEPT_CD;
  final String DEPT_NM;
  final bool DR_YN;
  final bool HITDUTY_YN;
  final String ADVANCE_TYPE;
  final String ACCESS_KEY;

  LoginResponse({
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

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

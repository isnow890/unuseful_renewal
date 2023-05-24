import 'package:json_annotation/json_annotation.dart';

part 'login_reponse.g.dart';

@JsonSerializable()
class LoginResponse {
  final String ACCESS_TOKEN;

  LoginResponse({required this.ACCESS_TOKEN});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

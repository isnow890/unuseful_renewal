
import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

abstract class ResponseModelBase {}


class ResponseModelInit extends ResponseModelBase {}

class ResponseModelLoading extends ResponseModelBase {}

class ResponseModelError extends ResponseModelBase {
  final String message;

  ResponseModelError({
    required this.message,
  });
}

@JsonSerializable()
class ResponseModel extends ResponseModelBase {
  final String? message;
  final bool isSuccess;

  ResponseModel({
    required this.message,
    required this.isSuccess,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
}

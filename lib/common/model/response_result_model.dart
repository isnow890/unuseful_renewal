import 'package:json_annotation/json_annotation.dart';

part 'response_result_model.g.dart';

abstract class ResponseResultModelBase {}
@JsonSerializable()
class ResponseResultModel extends ResponseResultModelBase {
  final String message;

  ResponseResultModel({required this.message});
  factory ResponseResultModel.fromJson(Map<String,dynamic> json)
  =>_$ResponseResultModelFromJson(json);
}

class ResponseResultModelLoading extends ResponseResultModelBase {}

class ResponseResultModelError extends ResponseResultModelBase {
  final String message;

  ResponseResultModelError({required this.message});
}

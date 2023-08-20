
import 'package:json_annotation/json_annotation.dart';
import 'package:unuseful/src/common/model/model_base.dart';

part 'response_model.g.dart';


@JsonSerializable()
class ResponseModel extends ModelBase {
  final String? message;
  final bool isSuccess;

  ResponseModel({
    required this.message,
    required this.isSuccess,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
}

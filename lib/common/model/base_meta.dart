
import 'package:json_annotation/json_annotation.dart';

part 'base_meta.g.dart';

@JsonSerializable()
class BaseMeta {
  final int statusCode;
  final String message;

  BaseMeta({
    required this.statusCode,
    required this.message,
  });

  BaseMeta copyWith({int? statusCode, String? message}) {
    return BaseMeta(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message);
  }

  factory BaseMeta.fromJson(Map<String, dynamic> json) =>
      _$BaseMetaFromJson(json);

}
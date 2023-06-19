import 'package:json_annotation/json_annotation.dart';

part 'specimen_params.g.dart';

@JsonSerializable()
class SpecimenParams {
  final String hspTpCd;
  final String searchValue;
  final String strDt;
  final String endDt;
  final String orderBy;

  const SpecimenParams( {
    required this.hspTpCd,
    required this.searchValue,
    required this.strDt,
    required this.endDt,
    required this.orderBy,
  });

  factory SpecimenParams.fromJson(Map<String, dynamic> json) =>
      _$SpecimenParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SpecimenParamsToJson(this);
}

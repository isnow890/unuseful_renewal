import 'package:json_annotation/json_annotation.dart';

part 'specimen_params.g.dart';

@JsonSerializable()
class SpecimenParams {
  final String? searchValue;
  final String? strDt;
  final String? endDt;
  final String? orderBy;

  const SpecimenParams({
     this.searchValue,
     this.strDt,
     this.endDt,
     this.orderBy,
}
  );
  factory SpecimenParams.fromJson(Map<String, dynamic> json) =>
      _$SpecimenParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SpecimenParamsToJson(this);
}

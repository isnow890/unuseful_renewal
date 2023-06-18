import 'package:json_annotation/json_annotation.dart';

part 'speciemen_params.g.dart';

@JsonSerializable()
class SpeciemenParams {
  final String? searchValue;
  final String? strDt;
  final String? endDt;
  final String? orderBy;

  const SpeciemenParams({
     this.searchValue,
     this.strDt,
     this.endDt,
     this.orderBy,
}
  );
  factory SpeciemenParams.fromJson(Map<String, dynamic> json) =>
      _$SpeciemenParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SpeciemenParamsToJson(this);
}

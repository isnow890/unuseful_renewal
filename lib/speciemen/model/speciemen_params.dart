import 'package:json_annotation/json_annotation.dart';

part 'speciemen_params.g.dart';

@JsonSerializable()
class SpeciemenParams {
  final String? hspTpCd;
  final String? spcmNo;

  const SpeciemenParams({this.hspTpCd, this.spcmNo});

  SpeciemenParams copyWith({String? hspTpCd, String? spcmNo}) =>
      SpeciemenParams(
          hspTpCd: hspTpCd ?? this.hspTpCd, spcmNo: spcmNo ?? this.spcmNo);

  factory SpeciemenParams.fromJson(Map<String, dynamic> json) =>
      _$SpeciemenParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SpeciemenParamsToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'specimen_detail_params.g.dart';

@JsonSerializable()
class SpecimenDetailParams {
  final String spcmNo;
  final String hspTpCd;
  final String exrmExmCtgCd;

  const SpecimenDetailParams(
      {required this.spcmNo,
      required this.hspTpCd,
      required this.exrmExmCtgCd});
  factory SpecimenDetailParams.fromJson(Map<String,dynamic> json)
  =>_$SpecimenDetailParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SpecimenDetailParamsToJson(this);

}

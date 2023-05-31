import 'package:json_annotation/json_annotation.dart';

part 'telephone_basic_model.g.dart';

@JsonSerializable()
class TelephoneBasicModel {
  String deptNm;
  String telNoNm;
  String hspTpCd;
  String etntTelNo;
  String telNoAbbrNm;
  String sectDeptNm;

  TelephoneBasicModel(
      {required this.deptNm,
      required this.telNoNm,
      required this.hspTpCd,
      required this.etntTelNo,
      required this.telNoAbbrNm,
      required this.sectDeptNm});

  factory TelephoneBasicModel.fromJson(Map<String, dynamic> json) =>
      _$TelephoneBasicModelFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';

part 'telephone_basic_model.g.dart';

@JsonSerializable()
class TelephoneBasicModel {
  final String NAME;
  final String DEPT_NM;
  final String TEL_NO_NM;
  final String HSP_TP_CD;
  final String ETNT_TEL_NO;

  TelephoneBasicModel(
      {required this.NAME,
      required this.DEPT_NM,
      required this.TEL_NO_NM,
      required this.HSP_TP_CD,
      required this.ETNT_TEL_NO});

  factory TelephoneBasicModel.fromJson(Map<String, dynamic> json) =>
      _$TelephoneBasicModelFromJson(json);
}

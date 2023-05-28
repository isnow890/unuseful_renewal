import 'package:json_annotation/json_annotation.dart';

part 'telephone_basic_model.g.dart';

@JsonSerializable()
class TelephoneBasicModel {
  final String DEPT_NM;
  final String TEL_NO_NM;
  final String HSP_TP_CD;
  final String ETNT_TEL_NO;
  final String TEL_NO_ABBR_NM;
  final String SECT_DEPT_NM;

  TelephoneBasicModel(
      {required this.TEL_NO_ABBR_NM,
      required this.SECT_DEPT_NM,
      required this.DEPT_NM,
      required this.TEL_NO_NM,
      required this.HSP_TP_CD,
      required this.ETNT_TEL_NO});

  factory TelephoneBasicModel.clone(TelephoneBasicModel clone) {
    return TelephoneBasicModel(
        TEL_NO_ABBR_NM: clone.TEL_NO_ABBR_NM,
        SECT_DEPT_NM: clone.SECT_DEPT_NM,
        DEPT_NM: clone.DEPT_NM,
        TEL_NO_NM: clone.TEL_NO_NM,
        HSP_TP_CD: clone.HSP_TP_CD,
        ETNT_TEL_NO: clone.ETNT_TEL_NO);
  }

  factory TelephoneBasicModel.fromJson(Map<String, dynamic> json) =>
      _$TelephoneBasicModelFromJson(json);
}

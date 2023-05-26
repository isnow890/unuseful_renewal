import 'package:json_annotation/json_annotation.dart';

part 'telephone_advance_model.g.dart';

@JsonSerializable()
class TelephoneAdvanceModel {
  final String SECT_DEPT_CD;
  final String STF_NO;
  final String KOR_NM;
  final String TEL_NO_NM;
  final String TEL_NO_ABBR_NM;
  final String ETNT_TEL_NO;
  final String UGT_TEL_NO;
  final String PLC;
  final String TEL_NO_TP_CD;
  final String TMLD_YN;
  final String OPN_YN;
  final String PDA_NM;
  final int? SEQ;
  final String RMK_NM;
  final String DEPT_CD;
  final String DEPT_CD_NM;
  final String HSP_TP_CD;
  final int TEL_NO_SEQ;
  final String SID;
  final String DEPT_NM;

  TelephoneAdvanceModel(
      {required this.SECT_DEPT_CD,
      required this.STF_NO,
      required this.KOR_NM,
      required this.TEL_NO_NM,
      required this.TEL_NO_ABBR_NM,
      required this.ETNT_TEL_NO,
      required this.UGT_TEL_NO,
      required this.PLC,
      required this.TEL_NO_TP_CD,
      required this.TMLD_YN,
      required this.OPN_YN,
      required this.PDA_NM,
      required this.SEQ,
      required this.RMK_NM,
      required this.DEPT_CD,
      required this.DEPT_CD_NM,
      required this.HSP_TP_CD,
      required this.TEL_NO_SEQ,
      required this.SID,
      required this.DEPT_NM});

  factory TelephoneAdvanceModel.fromJson(Map<String, dynamic> json) =>
      _$TelephoneAdvanceModelFromJson(json);
}

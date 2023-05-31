import 'package:json_annotation/json_annotation.dart';

part 'telephone_advance_model.g.dart';

@JsonSerializable()
class TelephoneAdvanceModel {
  String sectDeptCd;
  String stfNo;
  String korNm;
  String telNoNm;
  String telNoAbbrNm;
  String etntTelNo;
  String ugtTelNo;
  String plc;
  String telNoTpCd;
  String tmldYn;
  String opnYn;
  String pdaNm;
  int seq;
  String rmkNm;
  String deptCd;
  String deptCdNm;
  String hspTpCd;
  int telNoSeq;
  String sid;
  String deptNm;
  int orderSeq;

  TelephoneAdvanceModel(
      {required this.sectDeptCd,
        required this.stfNo,
        required this.korNm,
        required this.telNoNm,
        required this.telNoAbbrNm,
        required this.etntTelNo,
        required this.ugtTelNo,
        required this.plc,
        required this.telNoTpCd,
        required this.tmldYn,
        required this.opnYn,
        required this.pdaNm,
        required this.seq,
        required this.rmkNm,
        required this.deptCd,
        required this.deptCdNm,
        required this.hspTpCd,
        required this.telNoSeq,
        required this.sid,
        required this.deptNm,
        required this.orderSeq});

  factory TelephoneAdvanceModel.fromJson(Map<String, dynamic> json) =>
      _$TelephoneAdvanceModelFromJson(json);
}

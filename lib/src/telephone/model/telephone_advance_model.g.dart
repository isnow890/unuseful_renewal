// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telephone_advance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TelephoneAdvanceModel _$TelephoneAdvanceModelFromJson(
        Map<String, dynamic> json) =>
    TelephoneAdvanceModel(
      sectDeptCd: json['sectDeptCd'] as String?,
      stfNo: json['stfNo'] as String?,
      korNm: json['korNm'] as String?,
      telNoNm: json['telNoNm'] as String?,
      telNoAbbrNm: json['telNoAbbrNm'] as String?,
      etntTelNo: json['etntTelNo'] as String?,
      ugtTelNo: json['ugtTelNo'] as String?,
      plc: json['plc'] as String?,
      telNoTpCd: json['telNoTpCd'] as String?,
      tmldYn: json['tmldYn'] as String?,
      opnYn: json['opnYn'] as String?,
      pdaNm: json['pdaNm'] as String?,
      seq: json['seq'] as int?,
      rmkNm: json['rmkNm'] as String?,
      deptCd: json['deptCd'] as String?,
      deptCdNm: json['deptCdNm'] as String?,
      hspTpCd: json['hspTpCd'] as String?,
      telNoSeq: (json['telNoSeq'] as num?)?.toDouble(),
      sid: json['sid'] as String?,
      deptNm: json['deptNm'] as String?,
      orderSeq: json['orderSeq'] as int,
    );

Map<String, dynamic> _$TelephoneAdvanceModelToJson(
        TelephoneAdvanceModel instance) =>
    <String, dynamic>{
      'sectDeptCd': instance.sectDeptCd,
      'stfNo': instance.stfNo,
      'korNm': instance.korNm,
      'telNoNm': instance.telNoNm,
      'telNoAbbrNm': instance.telNoAbbrNm,
      'etntTelNo': instance.etntTelNo,
      'ugtTelNo': instance.ugtTelNo,
      'plc': instance.plc,
      'telNoTpCd': instance.telNoTpCd,
      'tmldYn': instance.tmldYn,
      'opnYn': instance.opnYn,
      'pdaNm': instance.pdaNm,
      'seq': instance.seq,
      'rmkNm': instance.rmkNm,
      'deptCd': instance.deptCd,
      'deptCdNm': instance.deptCdNm,
      'hspTpCd': instance.hspTpCd,
      'telNoSeq': instance.telNoSeq,
      'sid': instance.sid,
      'deptNm': instance.deptNm,
      'orderSeq': instance.orderSeq,
    };

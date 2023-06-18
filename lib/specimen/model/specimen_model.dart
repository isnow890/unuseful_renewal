import 'package:json_annotation/json_annotation.dart';

import '../../common/model/base_meta.dart';

part 'specimen_model.g.dart';

abstract class SpecimenModelBase {}

class SpecimenModelError extends SpecimenModelBase {
  final String message;

  SpecimenModelError({required this.message});
}

class SpecimenModelInit extends SpecimenModelBase {}

class SpecimenModelLoading extends SpecimenModelBase {}

@JsonSerializable()
class SpecimenModel extends SpecimenModelBase {
  final List<SpecimenPrimaryModel>? data;

  SpecimenModel({
    required this.data,
  });

  factory SpecimenModel.fromJson(Map<String, dynamic> json) =>
      _$SpecimenModelFromJson(json);
}

@JsonSerializable()
class SpecimenPrimaryModel {
  final String ordDt;
  final List<SpecimenExmTypeModel>? data;

  SpecimenPrimaryModel({required this.ordDt, required this.data});

  factory SpecimenPrimaryModel.fromJson(Map<String, dynamic> json) =>
      _$SpecimenPrimaryModelFromJson(json);
}

@JsonSerializable()
class SpecimenExmTypeModel {
  final String ordDt;
  final String exrmExmCtgCd;
  final String exmCtgAbbrNm;

  final List<SpecimenGeneralModel>? data;

  SpecimenExmTypeModel({
    required this.ordDt,
    required this.exrmExmCtgCd,
    required this.exmCtgAbbrNm,
    required this.data,
  });

  factory SpecimenExmTypeModel.fromJson(Map<String,dynamic> json)
  =>_$SpecimenExmTypeModelFromJson(json);
}

@JsonSerializable()
class SpecimenGeneralModel {
  final DateTime ordDt;
  final String spcmNo;
  final String exmAcptNo;
  final String ptNo;
  final DateTime? blclDtm;
  final String blclStfNo;
  final String rcpnStfNo;
  final DateTime? brfgDtm;
  final DateTime? acptDtm;
  final String exmPrgrStsNm;
  final String exmPrgrStsCd;
  final String exrmExmCtgCd;
  final String hspTpCd;
  final String hspTpNm;
  final String rstCnsgYn;
  final String emrgYn;
  final String exmCtgAbbrNm;
  final int orderSeq;

  final List<SpecimenDetailModel>? data;

  SpecimenGeneralModel({
    required this.ordDt,
    required this.spcmNo,
    required this.exmAcptNo,
    required this.ptNo,
    required this.blclDtm,
    required this.blclStfNo,
    required this.rcpnStfNo,
    required this.brfgDtm,
    required this.acptDtm,
    required this.exmPrgrStsNm,
    required this.exmPrgrStsCd,
    required this.exrmExmCtgCd,
    required this.hspTpCd,
    required this.hspTpNm,
    required this.rstCnsgYn,
    required this.emrgYn,
    required this.exmCtgAbbrNm,
    required this.orderSeq,
    required this.data,
  });

  factory SpecimenGeneralModel.fromJson(Map<String, dynamic> json) =>
      _$SpecimenGeneralModelFromJson(json);
}

@JsonSerializable()
class SpecimenDetailModel {
  final String exmCtgCd;
  final String exmCtgAbbrNm;
  final String spcmNo;
  final String exrsCnte;
  final String eitmAbbr;
  final String exmCd;
  final String exrsUnit;
  final String srefval;
  final int orderSeq;

  SpecimenDetailModel({
    required this.exmCtgCd,
    required this.exmCtgAbbrNm,
    required this.spcmNo,
    required this.exrsCnte,
    required this.eitmAbbr,
    required this.exmCd,
    required this.exrsUnit,
    required this.srefval,
    required this.orderSeq,
  });

  factory SpecimenDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SpecimenDetailModelFromJson(json);
}

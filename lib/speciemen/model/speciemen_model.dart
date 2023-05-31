import 'package:json_annotation/json_annotation.dart';

import '../../common/model/base_meta.dart';

part 'speciemen_model.g.dart';

abstract class SpeciemenModelBase {}

class SpeciemenModelError extends SpeciemenModelBase {
  final String message;

  SpeciemenModelError({required this.message});
}

class SpeciemenLoading extends SpeciemenModelBase{}


@JsonSerializable()
class SpeciemenModel extends SpeciemenModelBase{
  final BaseMeta meta;

  final List<SpecimenGeneralModel> data;

  SpeciemenModel({
    required this.meta,
    required this.data,
  });

  factory SpeciemenModel.fromJson(Map<String, dynamic> json) =>
      _$SpeciemenModelFromJson(json);
}

@JsonSerializable()
class SpecimenGeneralModel {
  DateTime ordDt;
  String spcmNo;
  String exmAcptNo;
  String ptNo;
  DateTime? blclDtm;
  String blclStfNo;
  String rcpnStfNo;
  DateTime? brfgDtm;
  List<SpecimenDetailModel> details;

  SpecimenGeneralModel({
    required this.ordDt,
    required this.spcmNo,
    required this.exmAcptNo,
    required this.ptNo,
    required this.blclDtm,
    required this.blclStfNo,
    required this.rcpnStfNo,
    required this.brfgDtm,
    required this.details,
  });

  factory SpecimenGeneralModel.fromJson(Map<String, dynamic> json) =>
      _$SpecimenGeneralModelFromJson(json);
}

@JsonSerializable()
class SpecimenDetailModel {
  DateTime acptDt;
  String exmCtgCd;
  String exmCtgAbbrNm;
  String spcmNo;
  String exrsCnte;
  String eitmAbbr;
  String exmCd;
  String exrsUnit;
  String sRefVal;

  SpecimenDetailModel({
    required this.acptDt,
    required this.exmCtgCd,
    required this.exmCtgAbbrNm,
    required this.spcmNo,
    required this.exrsCnte,
    required this.eitmAbbr,
    required this.exmCd,
    required this.exrsUnit,
    required this.sRefVal,
  });

  factory SpecimenDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SpecimenDetailModelFromJson(json);
}

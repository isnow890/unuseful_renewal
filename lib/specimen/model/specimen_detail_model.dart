
import 'package:json_annotation/json_annotation.dart';


part 'specimen_detail_model.g.dart';

abstract class SpecimenDetailModelBase {}

class SpecimenDetailModelLoading extends SpecimenDetailModelBase {}


class SpecimenDetailModelError extends SpecimenDetailModelBase {
  final String message;
  SpecimenDetailModelError({required this.message});
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

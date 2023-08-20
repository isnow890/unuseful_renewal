import 'package:json_annotation/json_annotation.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/util/helper/data_utils.dart';

part 'patient_model.g.dart';


@JsonSerializable()
class PatientModel extends ModelBase{
  final List<PatientModelList> data;
  PatientModel({required this.data});

}


@JsonSerializable()
class PatientModelList {
  final String ptNo;
   String ptNm;
  final String? diagnosis;
  @JsonKey(fromJson: DataHelper.hspTpCdToNm)
  final String? hspTpCd;
  final String sexTpCd;
  final String wardInfo;
   String blindedPtNm;

  PatientModelList(
      {required this.ptNo,
      required this.ptNm,
      required this.diagnosis,
      required this.hspTpCd,
      required this.sexTpCd,
      required this.wardInfo,
      required this.blindedPtNm});

  factory PatientModelList.fromJson(Map<String, dynamic> json) =>
      _$PatientModelListFromJson(json);
}

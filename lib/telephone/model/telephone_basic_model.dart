import 'package:json_annotation/json_annotation.dart';
import 'package:unuseful/common/model/model_with_order_seq.dart';

part 'telephone_basic_model.g.dart';

@JsonSerializable()
class TelephoneBasicModel implements IModelWithDataSeq{
  String deptNm;
  String telNoNm;
  String hspTpCd;
  String etntTelNo;
  String telNoAbbrNm;
  String sectDeptNm;
  @override
  int orderSeq;
  String purifiedTelNo;

  TelephoneBasicModel(
      {required this.deptNm,
      required this.telNoNm,
      required this.hspTpCd,
      required this.etntTelNo,
      required this.telNoAbbrNm,
      required this.sectDeptNm,
      required this.orderSeq,
      required this.purifiedTelNo});

  factory TelephoneBasicModel.fromJson(Map<String, dynamic> json) =>
      _$TelephoneBasicModelFromJson(json);
}

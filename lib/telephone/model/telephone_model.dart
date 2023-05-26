import 'package:json_annotation/json_annotation.dart';
part 'telephone_model.g.dart';

abstract class TelephoneModelBase{}

class TelephoneModelError extends TelephoneModelBase{
  final String message;
  TelephoneModelError({required this.message});

}

class TelephoneModelLoading extends TelephoneModelBase{}

@JsonSerializable(
  //제네릭 사용 1
  genericArgumentFactories: true,
)
class TelephoneModel<T> extends TelephoneModelBase{
  final List<T> data;

  TelephoneModel({required this.data});

  factory TelephoneModel.fromJson(Map<String, dynamic> json,T Function(Object? json) fromJsonT) =>
      _$TelephoneModelFromJson(json,fromJsonT);
}

// final String NAME;
//
// final String DEPT_NM;
// final String TEL_NO_NM;
// final String HSP_TP_CD;
// final String ETNT_TEL_NO;

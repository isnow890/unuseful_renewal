import 'package:json_annotation/json_annotation.dart';

part 'firestore_props_model.g.dart';

abstract class FirestorePropsModelBase {}

@JsonSerializable()
class FirestorePropsModel extends FirestorePropsModelBase {
  final String id;
  List<SearchHistoryTelephoneModel> telephoneHistory;
  List<SearchHistorySpecimenModel> specimenHistory;

  FirestorePropsModel(
      {required this.id,
      required this.telephoneHistory,
      required this.specimenHistory});
}

class FirestorePropsModelLoading extends FirestorePropsModelBase {}

class FirestorePropsModelError extends FirestorePropsModelBase {
  final String message;

  FirestorePropsModelError({required this.message});
}

@JsonSerializable()
class SearchHistoryTelephoneModel {
  final DateTime lastUpdated;
  final String searchValue;
  final String mode;

  SearchHistoryTelephoneModel({
    required this.lastUpdated,
    required this.searchValue,
    required this.mode,
  });

  factory SearchHistoryTelephoneModel.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryTelephoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHistoryTelephoneModelToJson(this);
}

@JsonSerializable()
class SearchHistorySpecimenModel {
  final DateTime lastUpdated;
  final String searchValue;
  final String mode;
  final String startDt;
  final String endDt;

  SearchHistorySpecimenModel({
    required this.lastUpdated,
    required this.searchValue,
    required this.mode,
    required this.startDt,
    required this.endDt,
  });
  factory SearchHistorySpecimenModel.fromJson(Map<String, dynamic> json) =>
      _$SearchHistorySpecimenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHistorySpecimenModelToJson(this);
}

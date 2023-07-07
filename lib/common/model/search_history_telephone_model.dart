import 'package:json_annotation/json_annotation.dart';
part 'search_history_telephone_model.g.dart';

abstract class SearchHistoryTelephoneModelBase {}

class SearchHistoryTelephoneModelError extends SearchHistoryTelephoneModelBase {
  final String message;

  SearchHistoryTelephoneModelError({required this.message});
}

class SearchHistoryTelephoneModelLoading
    extends SearchHistoryTelephoneModelBase {}

@JsonSerializable()
class SearchHistoryTelephoneMainModel extends SearchHistoryTelephoneModelBase {
  final List<SearchHistoryTelephoneModel>? telephoneHistory;

  SearchHistoryTelephoneMainModel({this.telephoneHistory});
  factory SearchHistoryTelephoneMainModel.fromJson(Map<String,dynamic> json)
  =>_$SearchHistoryTelephoneMainModelFromJson(json);
}

@JsonSerializable()
class SearchHistoryTelephoneModel extends SearchHistoryTelephoneModelBase {
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

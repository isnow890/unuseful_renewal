import 'package:json_annotation/json_annotation.dart';

part 'search_history_specimen_model.g.dart';

abstract class SearchHistorySpecimenModelBase {}

class SearchHistorySpecimenModelLoading
    extends SearchHistorySpecimenModelBase {}

class SearchHistorySpecimenModelError extends SearchHistorySpecimenModelBase {
  final String message;
  SearchHistorySpecimenModelError({required this.message});
}

class SearchHistorySpecimenMainModel extends SearchHistorySpecimenModelBase {
  final List<SearchHistorySpecimenModel> specimenHistory;
  SearchHistorySpecimenMainModel({required this.specimenHistory});
}

@JsonSerializable()
class SearchHistorySpecimenModel {
  final DateTime lastUpdated;
  final String searchValue;
  final String mode;

  SearchHistorySpecimenModel({
    required this.lastUpdated,
    required this.searchValue,
    required this.mode,
  });
  factory SearchHistorySpecimenModel.fromJson(Map<String, dynamic> json) =>
      _$SearchHistorySpecimenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHistorySpecimenModelToJson(this);
}

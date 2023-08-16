import 'package:json_annotation/json_annotation.dart';
import 'package:unuseful/src/common/model/model_base.dart';

part 'search_history_specimen_model.g.dart';


class SearchHistoryMainModel extends ModelBase {
  final List<SearchHistoryModel> history;
  SearchHistoryMainModel({required this.history});
}

@JsonSerializable()
class SearchHistoryModel {
  final DateTime lastUpdated;
  final String searchValue;
  final String mode;

  SearchHistoryModel({
    required this.lastUpdated,
    required this.searchValue,
    required this.mode,
  });
  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$SearchHistorySpecimenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHistorySpecimenModelToJson(this);
}

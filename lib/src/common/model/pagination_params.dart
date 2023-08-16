import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final int? after;
  final int? count;
  final String? searchValue;

  const PaginationParams({
    this.after,
    this.count,
    this.searchValue,
  });

  PaginationParams copyWith({
    int? after,
    int? count,
    String? searchValue,
  }) {
    return PaginationParams(
      after: after ?? this.after,
      count: count ?? this.count,
      searchValue: searchValue ?? this.searchValue,
    );
  }

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}

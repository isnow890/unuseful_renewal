// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchHistoryModel _$SearchHistoryModelFromJson(Map<String, dynamic> json) =>
    SearchHistoryModel(
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      searchValue: json['searchValue'] as String,
      mode: json['mode'] as String,
    );

Map<String, dynamic> _$SearchHistoryModelToJson(SearchHistoryModel instance) =>
    <String, dynamic>{
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'searchValue': instance.searchValue,
      'mode': instance.mode,
    };

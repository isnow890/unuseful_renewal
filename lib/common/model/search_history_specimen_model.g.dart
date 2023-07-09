// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_specimen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchHistorySpecimenModel _$SearchHistorySpecimenModelFromJson(
        Map<String, dynamic> json) =>
    SearchHistorySpecimenModel(
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      searchValue: json['searchValue'] as String,
      mode: json['mode'] as String,
    );

Map<String, dynamic> _$SearchHistorySpecimenModelToJson(
        SearchHistorySpecimenModel instance) =>
    <String, dynamic>{
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'searchValue': instance.searchValue,
      'mode': instance.mode,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_telephone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchHistoryTelephoneModel _$SearchHistoryTelephoneModelFromJson(
        Map<String, dynamic> json) =>
    SearchHistoryTelephoneModel(
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      searchValue: json['searchValue'] as String,
      mode: json['mode'] as String,
    );

Map<String, dynamic> _$SearchHistoryTelephoneModelToJson(
        SearchHistoryTelephoneModel instance) =>
    <String, dynamic>{
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'searchValue': instance.searchValue,
      'mode': instance.mode,
    };

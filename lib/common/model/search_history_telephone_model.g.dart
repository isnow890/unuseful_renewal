// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_telephone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchHistoryTelephoneMainModel _$SearchHistoryTelephoneMainModelFromJson(
        Map<String, dynamic> json) =>
    SearchHistoryTelephoneMainModel(
      telephoneHistory: (json['telephoneHistory'] as List<dynamic>)
          .map((e) =>
              SearchHistoryTelephoneModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchHistoryTelephoneMainModelToJson(
        SearchHistoryTelephoneMainModel instance) =>
    <String, dynamic>{
      'telephoneHistory': instance.telephoneHistory,
    };

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

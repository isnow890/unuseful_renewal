// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_props_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestorePropsModel _$FirestorePropsModelFromJson(Map<String, dynamic> json) =>
    FirestorePropsModel(
      id: json['id'] as String,
      telephoneHistory: (json['telephoneHistory'] as List<dynamic>)
          .map((e) =>
              SearchHistoryTelephoneModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      specimenHistory: (json['specimenHistory'] as List<dynamic>)
          .map((e) =>
              SearchHistorySpecimenModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FirestorePropsModelToJson(
        FirestorePropsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'telephoneHistory': instance.telephoneHistory,
      'specimenHistory': instance.specimenHistory,
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

SearchHistorySpecimenModel _$SearchHistorySpecimenModelFromJson(
        Map<String, dynamic> json) =>
    SearchHistorySpecimenModel(
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      searchValue: json['searchValue'] as String,
      mode: json['mode'] as String,
      startDt: json['startDt'] as String,
      endDt: json['endDt'] as String,
    );

Map<String, dynamic> _$SearchHistorySpecimenModelToJson(
        SearchHistorySpecimenModel instance) =>
    <String, dynamic>{
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'searchValue': instance.searchValue,
      'mode': instance.mode,
      'startDt': instance.startDt,
      'endDt': instance.endDt,
    };

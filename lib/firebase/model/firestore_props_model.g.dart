// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_props_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestorePropsModel _$FirestorePropsModelFromJson(Map<String, dynamic> json) =>
    FirestorePropsModel(
      id: json['id'] as String,
      telephoneHistory: (json['telephoneHistory'] as List<dynamic>)
          .map((e) => SearchHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      specimenHistory: (json['specimenHistory'] as List<dynamic>)
          .map((e) => SearchHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FirestorePropsModelToJson(
        FirestorePropsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'telephoneHistory': instance.telephoneHistory,
      'specimenHistory': instance.specimenHistory,
    };

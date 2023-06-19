// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealModel _$MealModelFromJson(Map<String, dynamic> json) => MealModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => MealModelList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealModelToJson(MealModel instance) => <String, dynamic>{
      'data': instance.data,
    };

MealModelList _$MealModelListFromJson(Map<String, dynamic> json) =>
    MealModelList(
      mealSeq: json['mealSeq'] as int,
      title: json['title'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => MealImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealModelListToJson(MealModelList instance) =>
    <String, dynamic>{
      'mealSeq': instance.mealSeq,
      'title': instance.title,
      'images': instance.images,
    };

MealImageModel _$MealImageModelFromJson(Map<String, dynamic> json) =>
    MealImageModel(
      url: json['url'] as String,
      base64Encoded: json['base64Encoded'] as String,
    );

Map<String, dynamic> _$MealImageModelToJson(MealImageModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'base64Encoded': instance.base64Encoded,
    };

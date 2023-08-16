// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealModel _$MealModelFromJson(Map<String, dynamic> json) => MealModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MealModelList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealModelToJson(MealModel instance) => <String, dynamic>{
      'data': instance.data,
    };

MealModelList _$MealModelListFromJson(Map<String, dynamic> json) =>
    MealModelList(
      mealSeq: json['mealSeq'] as int,
      title: json['title'] as String,
      imgUrls:
          (json['imgUrls'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MealModelListToJson(MealModelList instance) =>
    <String, dynamic>{
      'mealSeq': instance.mealSeq,
      'title': instance.title,
      'imgUrls': instance.imgUrls,
    };

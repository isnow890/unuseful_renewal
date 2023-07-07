import 'package:json_annotation/json_annotation.dart';

part 'meal_model.g.dart';

abstract class MealModelBase {}

class MealModelLoading extends MealModelBase {}

class MealModelError extends MealModelBase {
  final String message;

  MealModelError({required this.message});
}

@JsonSerializable()
class MealModel extends MealModelBase {
  final List<MealModelList>? data;

  MealModel({this.data});
}

@JsonSerializable()
class MealModelList {
  final int mealSeq;
  final String title;
  final List<String> imgUrls;

  MealModelList({
    required this.mealSeq,
    required this.title,
    required this.imgUrls,
  });

  factory MealModelList.fromJson(Map<String, dynamic> json) =>
      _$MealModelListFromJson(json);
}

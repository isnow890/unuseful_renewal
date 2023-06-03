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
  final List<MealModelList> data;

  MealModel({required this.data});
}

@JsonSerializable()
class MealModelList {
  final int mealSeq;
  final String title;
  final List<MealImageModel> images;

  MealModelList({
    required this.mealSeq,
    required this.title,
    required this.images,
  });

  factory MealModelList.fromJson(Map<String, dynamic> json) =>
      _$MealModelListFromJson(json);
}

@JsonSerializable()
class MealImageModel {
  final String url;
  final String base64Encoded;

  MealImageModel({
    required this.url,
    required this.base64Encoded,
  });

  factory MealImageModel.fromJson(Map<String, dynamic> json) =>
      _$MealImageModelFromJson(json);
}

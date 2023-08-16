import 'package:json_annotation/json_annotation.dart';
import 'package:unuseful/src/common/model/model_base.dart';

part 'meal_model.g.dart';

@JsonSerializable()
class MealModel extends ModelBase {
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

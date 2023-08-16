import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/dio.dart';
import 'package:unuseful/src/meal/model/meal_model.dart';

part 'meal_repository.g.dart';

final mealRepositoryProvider = Provider<MealRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository = MealRepository(dio, baseUrl: ip);
    return repository;
  },
);

@RestApi()
abstract class MealRepository {
  factory MealRepository(Dio dio, {String baseUrl}) = _MealRepository;

  @GET('/meal')
  @Headers({'accessKey': 'true'})
  Future<List<MealModelList>> getMeal(@Query("hspTpCd") String hspTpCd);
}

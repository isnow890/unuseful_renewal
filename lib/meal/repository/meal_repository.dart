import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/dio/dio.dart';
import 'package:unuseful/meal/model/meal_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';

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

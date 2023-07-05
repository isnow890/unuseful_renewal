import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/common/const/data.dart';
import 'package:unuseful/common/dio/dio.dart';

import '../model/firestore_props_model.dart';
import '../model/hit_schedule_at_home_model.dart';

part 'home_repository.g.dart';

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repository = HomeRepository(dio, baseUrl: ip);
    return repository;
  },
);

@RestApi()
abstract class HomeRepository {
  factory HomeRepository(Dio dio, {String baseUrl}) = _HomeRepository;

  @GET('home/getSearchHistory')
  @Headers({'accessKey': 'true'})
  Future<FirestorePropsModel> getSearchHistory(@Query("sid") String sid);

  @GET('home/getHitScheduleAtHome')
  @Headers({'accessKey': 'true'})
  Future<HitScheduleAtHomeModel> getHitScheduleAtHome(
      {@Query("stfNm") required String sid});
}

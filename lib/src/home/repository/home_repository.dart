import 'dart:convert';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/dio.dart';

import '../../../firebase/model/firestore_props_model.dart';
import '../../common/model/hit_schedule_at_home_model.dart';

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

  @GET('/home/getHitScheduleAtHome')
  @Headers({'accessKey': 'true'})
  Future<HitScheduleAtHomeModel> getHitScheduleAtHome(
      {@Query("stfNm") required String stfNm}
      );
}

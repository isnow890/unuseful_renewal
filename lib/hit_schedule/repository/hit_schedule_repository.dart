import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/common/const/data.dart';
import 'package:unuseful/common/dio/dio.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_model.dart';

part 'hit_schedule_repository.g.dart';

final hitScheduleRepositoryProvider = Provider<HitScheduleRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = HitScheduleRepository(dio, baseUrl: ip);
  return repository;
});

@RestApi()
abstract class HitScheduleRepository {
  factory HitScheduleRepository(Dio dio, {String baseUrl}) =
      _HitScheduleRepository;

  @GET('/hitSchedule')
  @Headers({'accessKey': 'true'})
  Future<List<HitScheduleListModel>> getHitSchedule();
}

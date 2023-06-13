import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/common/const/data.dart';
import 'package:unuseful/common/dio/dio.dart';
import 'package:unuseful/hit_schedule/model/hit_duty_schedule_update_model.dart';
import 'package:unuseful/hit_schedule/model/hit_duty_statistics_model.dart';
import 'package:unuseful/hit_schedule/model/hit_my_duty_model.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_log_model.dart';
import 'package:unuseful/hit_schedule/model/hit_schedule_model.dart';

import '../model/hit_schedule_for_event_model.dart';

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

  @GET('/hitSchedule/getHitSchedule')
  @Headers({'accessKey': 'true'})
  Future<List<HitScheduleListModel>> getHitSchedule(
      @Query("wkMonth") String wkMonth);

  @GET('/hitSchedule/getHitScheduleForEvent')
  @Headers({'accessKey': 'true'})
  Future<List<HitScheduleForEventListModel>> getHitScheduleForEvent();

  @GET('/hitSchedule/getDutyStatistics')
  @Headers({'accessKey': 'true'})
  Future<List<HitDutyStatisticsListModel>> getDutyStatistics(
      @Query("stfNum") String stfNum);

  @GET('/hitSchedule/getDutyOfMine')
  @Headers({'accessKey': 'true'})
  Future<List<HitMyDutyListModel>> getDutyOfMine(@Query("stfNum") String stfNum);

  @GET('/hitSchedule/getDutyLog')
  @Headers({'accessKey': 'true'})
  Future<List<HitDutyLogListModel>> getDutyLog();

  @PUT('/hitSchedule/updateDuty')
  @Headers({'accessKey': 'true'})
  Future<List<HitScheduleListModel>> updateDuty({
    @Body() required HitDutyScheduleUpdateModel body,
  });
}

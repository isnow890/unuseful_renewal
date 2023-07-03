import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'root_tab_hit_schedule_repository.g.dart';

@RestApi()
abstract class RootTabHitScheduleRepository {
  factory RootTabHitScheduleRepository(Dio dio, {String baseUrl}) =
      _RootTabHitScheduleRepository;
}

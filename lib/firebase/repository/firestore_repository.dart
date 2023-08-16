import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/dio.dart';
import 'package:unuseful/src/home/model/search_history_telephone_model.dart';

import '../model/fcm_registration_model.dart';
import '../../src/common/model/response_model.dart';
import '../../src/home/model/search_history_specimen_model.dart';

part 'firestore_repository.g.dart';

final firestorageRepositoryProvider = Provider<FirestoreRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = FirestoreRepository(dio, baseUrl: ip);
  return repository;
});

@RestApi()
abstract class FirestoreRepository {
  factory FirestoreRepository(Dio dio, {String baseUrl}) = _FirestoreRepository;

  @POST('/firestore/savePushAlarmList')
  @Headers({'accessKey': 'true'})
  Future<ResponseModel> saveFcmToken({
    @Body() required FcmRegistrationModel body,
  });

  @POST('/firestore/saveTelephoneHistory')
  @Headers({'accessKey': 'true'})
  Future<ResponseModel> saveTelephoneHistory(
      {@Query("sid") required String sid,
      @Body() required SearchHistoryModel body});

  @POST('/firestore/saveSpecimenHistory')
  @Headers({'accessKey': 'true'})
  Future<ResponseModel> saveSpecimenHistory(
      {@Query("sid") required String sid,
      @Body() required SearchHistoryModel body});

  @GET('/firestore/getTelephoneHistory')
  @Headers({'accessKey': 'true'})
  Future<List<SearchHistoryModel>> getTelephoneHistory(
      @Query("sid") String sid);

  @GET('/firestore/getSpecimenHistory')
  @Headers({'accessKey': 'true'})
  Future<List<SearchHistoryModel>> getSpecimenHistory(
      @Query("sid") String sid);

  @DELETE('/firestore/delTelephoneHistory')
  @Headers({'accessKey': 'true'})
  Future<ResponseModel> delTelephoneHistory(
      {@Query("sid") required String sid,
      @Body() required SearchHistoryModel body});

  @DELETE('/firestore/delSpecimenHistory')
  @Headers({'accessKey': 'true'})
  Future<ResponseModel> delSpecimenHistory(
      {@Query("sid") required String sid,
      @Body() required SearchHistoryModel body});
}

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/common/const/data.dart';
import 'package:unuseful/common/dio/dio.dart';
import 'package:unuseful/common/model/fcm_registration_params.dart';

import '../model/response_model.dart';

part 'firestorage_repository.g.dart';

final firestorageRepositoryProvider = Provider<FirestorageRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = FirestorageRepository(dio, baseUrl: ip);
  return repository;
});

@RestApi()
abstract class FirestorageRepository {
  factory FirestorageRepository(Dio dio, {String baseUrl}) =
      _FirestorageRepository;

  @POST('/firestore/save')
  @Headers({'accessKey': 'true'})
  Future<ResponseModel> saveFcmToken({
    @Queries() FcmRegistrationParams? fcmRegistrationParams =
        const FcmRegistrationParams(
      lastUsedDate: null,
      fcmToken: '',
      isHitDutyAlarm: null,
      isMealAlarm: null,
      sid: '',
      id: '',
    ),
  });
}

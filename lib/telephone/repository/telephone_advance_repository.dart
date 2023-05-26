import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/common/dio/dio.dart';
import 'package:unuseful/telephone/model/telephone_advance_model.dart';

import '../../common/const/data.dart';
import '../model/telephone_basic_model.dart';

part 'telephone_advance_repository.g.dart';

final telephoneAdvanceRepositoryProvider = Provider<TelephoneAdvanceRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = TelephoneAdvanceRepository(dio,baseUrl: 'http://$ip/telephone/advance');
  return repository;
});


@RestApi()
abstract class TelephoneAdvanceRepository{
  factory TelephoneAdvanceRepository(Dio dio, {String baseUrl})=_TelephoneAdvanceRepository;

  @GET('/')
  @Headers({'accessKey': 'true'})
  Future<TelephoneAdvanceModel> getAdvance();


}





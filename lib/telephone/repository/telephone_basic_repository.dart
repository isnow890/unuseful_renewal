import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/telephone/model/telephone_advance_model.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../model/telephone_basic_model.dart';

part 'telephone_basic_repository.g.dart';

final telephoneBasicRepositoryProvider = Provider<TelephoneBasicRepository>((ref) {
 final dio = ref.watch(dioProvider);
 final repository = TelephoneBasicRepository(dio,baseUrl: 'http://$ip/telephone/basic');
 return repository;
});


@RestApi()
 abstract class TelephoneBasicRepository{
  factory TelephoneBasicRepository(Dio dio, {String baseUrl})=_TelephoneBasicRepository;

  @GET('/')
  @Headers({'accessKey': 'true'})
 Future<List<TelephoneBasicModel>> getBasic();

}

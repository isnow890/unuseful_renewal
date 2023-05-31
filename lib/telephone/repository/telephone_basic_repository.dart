import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/telephone/model/telephone_advance_model.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';
import '../../common/repository/base_pagination_provider.dart';
import '../model/telephone_basic_model.dart';

part 'telephone_basic_repository.g.dart';

final telephoneBasicRepositoryProvider = Provider<TelephoneBasicRepository>((ref) {
 final dio = ref.watch(dioProvider);
 final repository = TelephoneBasicRepository(dio,baseUrl: 'http://$ip/telephone/basic');
 return repository;
});


@RestApi()
 abstract class TelephoneBasicRepository extends IBasePaginationRepository<TelephoneBasicModel>{
  factory TelephoneBasicRepository(Dio dio, {String baseUrl})=_TelephoneBasicRepository;

  @GET('/')
  @Headers({'accessKey': 'true'})
  Future<CursorPagination<TelephoneBasicModel>> paginate({
   @Queries() PaginationParams? paginationParams =
   const PaginationParams(after: null, count: null),
  });



}

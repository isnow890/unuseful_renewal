import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/common/dio/dio.dart';
import 'package:unuseful/telephone/model/telephone_advance_model.dart';

import '../../common/const/data.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';
import '../../common/repository/base_pagination_provider.dart';
import '../model/telephone_basic_model.dart';

part 'telephone_advance_repository.g.dart';

final telephoneAdvanceRepositoryProvider =
    Provider<TelephoneAdvanceRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository =
      TelephoneAdvanceRepository(dio, baseUrl: 'http://$ip/telephone/advance');
  return repository;
});

@RestApi()
abstract class TelephoneAdvanceRepository
    extends IBasePaginationRepository<TelephoneAdvanceModel> {
  factory TelephoneAdvanceRepository(Dio dio, {String baseUrl}) =
      _TelephoneAdvanceRepository;

  @GET('/')
  @Headers({'accessKey': 'true'})
  Future<CursorPagination<TelephoneAdvanceModel>> paginate({
    @Queries() PaginationParams? paginationParams =
    const PaginationParams(after: null, count: null,searchValue: null),
  });



}

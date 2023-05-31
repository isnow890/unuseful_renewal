import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/common/dio/dio.dart';
import 'package:unuseful/speciemen/model/speciemen_params.dart';

import '../../common/const/data.dart';
import '../model/speciemen_model.dart';

part 'speciemen_repository.g.dart';

final specimenRepositoryProvider = Provider<SpeciemenRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = SpeciemenRepository(dio, baseUrl: 'http:/$ip/specimen');
  return repository;
});

@RestApi()
abstract class SpeciemenRepository {
  factory SpeciemenRepository(Dio dio, {String baseUrl}) = _SpeciemenRepository;

  @GET('/')
  @Headers({'accessKey': 'true'})
  Future<SpeciemenModel> getSpcmInformation({
    @Queries() SpeciemenParams? speciemenParams =
        const SpeciemenParams(hspTpCd: '', spcmNo: ''),
  });
}

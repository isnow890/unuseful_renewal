import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/common/dio/dio.dart';
import 'package:unuseful/speciemen/model/speciemen_params.dart';

import '../../common/const/data.dart';
import '../model/specimen_model.dart';

part 'specimen_repository.g.dart';

final specimenRepositoryProvider = Provider<SpecimenRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = SpecimenRepository(dio, baseUrl: '$ip/specimen');
  return repository;
});

@RestApi()
abstract class SpecimenRepository {
  factory SpecimenRepository(Dio dio, {String baseUrl}) = _SpecimenRepository;


  @GET('/')
  @Headers({'accessKey': 'true'})
  Future<List<SpecimenPrimaryModel>> getSpcmInformation({
    @Queries() SpeciemenParams? speciemenParams =
    const SpeciemenParams(searchValue: '', strDt: '', endDt: '', orderBy: '')});
}

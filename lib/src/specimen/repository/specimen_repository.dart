import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/dio.dart';
import 'package:unuseful/src/specimen/model/specimen_detail_model.dart';
import 'package:unuseful/src/specimen/model/specimen_detail_params.dart';
import '../model/specimen_model.dart';
import '../model/specimen_params.dart';

part 'specimen_repository.g.dart';

final specimenRepositoryProvider = Provider<SpecimenRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = SpecimenRepository(dio, baseUrl: '$ip');
  return repository;
});

@RestApi()
abstract class SpecimenRepository {
  factory SpecimenRepository(Dio dio, {String baseUrl}) = _SpecimenRepository;

  // @GET('/specimen')
  // @Headers({'accessKey': 'true'})
  // Future<List<SpecimenPrimaryModel>> getSpcmInformation({
  //   @Query("searchValue") String searchValue,
  //   @Query("strDt") String strDt,
  //   @Query("endDt") String endDt,
  //   @Query("orderBy") String orderBy,
  //   @Query("hspTpCd") String hspTpCd,
  // });

  @GET('/specimen')
  @Headers({'accessKey': 'true'})
  Future<List<SpecimenPrimaryModel>> getSpcmInformation(
      {@Queries() SpecimenParams? specimenParams = const SpecimenParams(
        searchValue: null,
        strDt: null,
        endDt: null,
        orderBy: null,
        hspTpCd: null,
      )});

  @GET('/specimen/detail')
  @Headers({'accessKey': 'true'})
  Future<List<SpecimenDetailListModel>> getSpcmDetailInformation(
      {@Queries() SpecimenDetailParams? specimenParams =
          const SpecimenDetailParams(
              hspTpCd: '', exrmExmCtgCd: '', spcmNo: '')});
}

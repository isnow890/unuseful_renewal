import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/common/dio/dio.dart';
import 'package:unuseful/specimen/model/specimen_detail_model.dart';
import 'package:unuseful/specimen/model/specimen_detail_params.dart';
import 'package:unuseful/specimen/model/specimen_params.dart';
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
    @Queries() SpecimenParams? specimenParams =
    const SpecimenParams(searchValue: '', strDt: '', endDt: '', orderBy: '', hspTpCd: '')});


  @GET('/detail')
  @Headers({'accessKey': 'true'})
  Future<List<SpecimenDetailModel>> getSpcmDetailInformation({
    @Queries() SpecimenDetailParams? specimenParams =
    const SpecimenDetailParams(hspTpCd: '',exrmExmCtgCd: '',spcmNo: '')});

}

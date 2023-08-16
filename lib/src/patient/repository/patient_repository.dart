import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/dio.dart';
import 'package:unuseful/src/patient/model/patient_model.dart';

part 'patient_repository.g.dart';

final patientRepositoryProvider = Provider<PatientRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository = PatientRepository(dio, baseUrl: ip);
    return repository;
  },
);

@RestApi()
abstract class PatientRepository {
  factory PatientRepository(Dio dio, {String baseUrl}) = _PatientRepository;

  @GET('/patient')
  @Headers({'accessKey': 'true'})
  Future<List<PatientModelList>> getPatient();
}

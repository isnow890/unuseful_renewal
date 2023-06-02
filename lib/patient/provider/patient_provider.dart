import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/patient/model/patient_model.dart';
import 'package:unuseful/patient/repository/patient_repository.dart';

final patientNotifierProvider =
    StateNotifierProvider<PatientNotifier, PatientModelBase?>(
  (ref) {
    final repository = ref.watch(patientRepositoryProvider);
    final notifier = PatientNotifier(repository: repository);
    return notifier;
  },
);

class PatientNotifier extends StateNotifier<PatientModelBase?> {
  final PatientRepository repository;

  PatientNotifier({required this.repository}) : super(PatientModelLoading()) {
    getPatient();
  }

  Future<PatientModelBase> getPatient() async {
    try {
      final List<PatientModelList> resp = await repository.getPatient();

      state = PatientModel(data: resp);
      return PatientModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = PatientModelError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/patient/model/patient_model.dart';
import 'package:unuseful/src/patient/repository/patient_repository.dart';

final patientNotifierProvider =
    StateNotifierProvider.autoDispose<PatientNotifier, ModelBase?>(
  (ref) {
    final repository = ref.watch(patientRepositoryProvider);
    final notifier = PatientNotifier(repository: repository);
    return notifier;
  },
);

class PatientNotifier extends StateNotifier<ModelBase?> {
  final PatientRepository repository;

  PatientNotifier({required this.repository}) : super(ModelBaseLoading()) {
    getPatient();
  }

  Future<ModelBase> getPatient() async {
    try {
      state = ModelBaseLoading();

      final List<PatientModelList> resp = await repository.getPatient();

      state = PatientModel(data: resp);
      return PatientModel(data: resp);
    } catch (e) {
      print(e.toString());
      state = ModelBaseError(message: '에러가 발생하였습니다.');
      return Future.value(state);
    }
  }
}

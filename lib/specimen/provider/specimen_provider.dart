import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/specimen/model/specimen_model.dart';

import '../model/specimen_params.dart';
import '../repository/specimen_repository.dart';

final specimenFamilyProvider = StateNotifierProvider.family<
    SpecimenStateNotifier, SpecimenModelBase?, SpecimenParams>(
  (ref, paramsFrom) {
    final repository = ref.watch(specimenRepositoryProvider);

    final notifier =
        SpecimenStateNotifier(repository: repository,
            params:  paramsFrom
            );
    return notifier;
  },
);


class SpecimenStateNotifier extends StateNotifier<SpecimenModelBase?> {
  final SpecimenRepository repository;
  // final Map<String,dynamic> params;
  final SpecimenParams params;

  SpecimenStateNotifier({
    required this.params,
    required this.repository,
  }) : super(SpecimenModelLoading()) {
    getSpcmInformation();
  }

  Future<SpecimenModelBase> getSpcmInformation() async {
    try {
      state = SpecimenModelLoading();
      final List<SpecimenPrimaryModel> resp =
      await repository.getSpcmInformation(specimenParams: params);

      print('resp');
      print(resp.toString());
      state = SpecimenModel(data: resp);
      return SpecimenModel(data: resp);
    } catch (e) {
      print(e);
      state = SpecimenModelError(message: '데이터를 가져오지 못했습니다.');
      return Future.value(state);
    }
  }
}

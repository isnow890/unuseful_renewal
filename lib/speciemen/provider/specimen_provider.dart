import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unuseful/common/const/data.dart';
import 'package:unuseful/speciemen/model/specimen_model.dart';

import '../model/speciemen_params.dart';
import '../repository/specimen_repository.dart';

final specimenFamilyProvider = StateNotifierProvider.family<
    SpecimenStateNotifier,
    SpecimenModelBase?,
    SpeciemenParams>((ref, params) {
  final repository = ref.watch(specimenRepositoryProvider);

  // final getMe = ref.watch(getmeprovider)

  final notifier = SpecimenStateNotifier(
  repository: repository, params: params);
  return notifier;
},);


class SpecimenStateNotifier extends StateNotifier<SpecimenModelBase?> {
  final SpecimenRepository repository;
  final SpeciemenParams params;

  SpecimenStateNotifier({
    required this.params,
    required this.repository,
  }) : super(SpecimenModelLoading()) {
    getSpcmInformation();
  }

  Future<SpecimenModelBase> getSpcmInformation() async {
    state = SpecimenModelLoading();

    print('params.searchValue');
    print(params.searchValue);

    if (params.searchValue == null|| params.searchValue == '') {
      state = SpecimenModelInit();
      return SpecimenModelInit();
    }
    try {
      final resp = await repository.getSpcmInformation(
          speciemenParams: params
      );
      state = SpecimenModel(data: resp);
      return SpecimenModel(data: resp);
    } catch (e) {
      state = SpecimenModelError(message: '데이터를 가져오지 못했습니다.');
      return Future.value(state);
    }
  }
}

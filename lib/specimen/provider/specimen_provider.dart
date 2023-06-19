import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/specimen/model/specimen_model.dart';
import 'package:unuseful/specimen/provider/specimen_check_provider.dart';
import 'package:unuseful/specimen/provider/specimen_variable_provider.dart';

import '../model/specimen_params.dart';
import '../repository/specimen_repository.dart';

final specimenFamilyProvider = StateNotifierProvider.family<
    SpecimenStateNotifier, SpecimenModelBase?, SpecimenParams>(
  (ref, paramsFrom) {

    final repository = ref.watch(specimenRepositoryProvider);

    final notifier =
        SpecimenStateNotifier(repository: repository, params: paramsFrom);
    return notifier;
  },
);

final specimenNotifierProvider = StateNotifierProvider((ref) {
  final repository = ref.watch(specimenRepositoryProvider);
  final params = ref.watch(specimenVariableProvider);


  final notifier =
  SpecimenStateNotifier(repository: repository, params: params);
  return notifier;
});

class SpecimenStateNotifier extends StateNotifier<SpecimenModelBase?> {
  final SpecimenRepository repository;

  final updateSpecimenDebounce = Debouncer(
      Duration(seconds: 1), initialValue: null,
      checkEquality: false);


  // final Map<String,dynamic> params;
  final SpecimenParams? params;

  // SpecimenStateNotifier({required this.repository,required this.params}) : super(null){
  //   updateSpecimenDebounce.values.listen((event) {
  //     getSpcmInformation();
  //   });
  //
  // }



  SpecimenStateNotifier({
    required this.params,
    required this.repository,
  }) : super(SpecimenModelLoading()) {
    getSpcmInformation();
  }

  Future<SpecimenModelBase> getSpcmInformation() async {
    try {

      // state = SpecimenInit();
      // final tmp = params?.searchValue?? '';
      // if (tmp == null || tmp == '') {
      //   state = SpecimenInit();
      //   return SpecimenInit();
      // }

      state = SpecimenModelLoading();
      final List<SpecimenPrimaryModel> resp =
          await repository.getSpcmInformation(specimenParams: params);

      print('resp');
      print(resp.toString());
      state = SpecimenModel(data: resp);
      updateSpecimenDebounce.setValue(null);

      return SpecimenModel(data: resp);

    } catch (e) {
      print(e);
      state = SpecimenModelError(message: '데이터를 가져오지 못했습니다.');
      return Future.value(state);
    }
  }
}

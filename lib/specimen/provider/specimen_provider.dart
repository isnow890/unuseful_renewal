import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/specimen/model/specimen_detail_params.dart';
import 'package:unuseful/specimen/provider/specimen_detail_params_provider.dart';

import '../model/specimen_detail_model.dart';
import '../repository/specimen_repository.dart';

final specimenNotifierProvider = StateNotifierProvider<
    SpecimenDetailStateNotifier, SpecimenDetailModelBase?>((ref) {
  final paramsDetail = ref.watch(specimenDetailParamsProvider);
  final repository = ref.watch(specimenRepositoryProvider);

  final notifier = SpecimenDetailStateNotifier(
      repository: repository, paramsDetail: paramsDetail);
  return notifier;
});

class SpecimenDetailStateNotifier
    extends StateNotifier<SpecimenDetailModelBase?> {
  final SpecimenRepository repository;
  final SpecimenDetailParams? paramsDetail;

  SpecimenDetailStateNotifier({
    required this.paramsDetail,
    required this.repository,
  }) : super(SpecimenDetailModelLoading()) {
    getSpcmDetailInformation();
  }

  Future<SpecimenDetailModelBase> getSpcmDetailInformation() async {
    try {
      state = SpecimenDetailModelLoading();
      final List<SpecimenDetailListModel> resp = await repository
          .getSpcmDetailInformation(specimenParams: paramsDetail);
      state = SpecimenDetailModel(data: resp);

      return SpecimenDetailModel(data: resp);
    } catch (e) {
      print(e);
      state = SpecimenDetailModelError(message: '데이터를 가져오지 못했습니다.');
      return Future.value(state);
    }
  }
}

// final specimenFamilyProvider = StateNotifierProvider.family<
//     SpecimenStateNotifier, SpecimenModelBase?, SpecimenParams>(
//   (ref, paramsFrom) {
//
//     final repository = ref.watch(specimenRepositoryProvider);
//
//     final notifier =
//         SpecimenStateNotifier(repository: repository, params: paramsFrom);
//     return notifier;
//   },
// );
// //
// // final specimenNotifierProvider = StateNotifierProvider((ref) {
// //   final repository = ref.watch(specimenRepositoryProvider);
// //   final params = ref.watch(specimenVariableProvider);
// //
// //
// //   final notifier =
// //   SpecimenStateNotifier(repository: repository, params: params);
// //   return notifier;
// // });
//
// class SpecimenStateNotifier extends StateNotifier<SpecimenModelBase?> {
//   final SpecimenRepository repository;
//
//   final updateSpecimenDebounce = Debouncer(
//       Duration(seconds: 1), initialValue: null,
//       checkEquality: false);
//
//
//   // final Map<String,dynamic> params;
//   final SpecimenParams? params;
//
//   // SpecimenStateNotifier({required this.repository,required this.params}) : super(null){
//   //   updateSpecimenDebounce.values.listen((event) {
//   //     getSpcmInformation();
//   //   });
//   //
//   // }
//
//
//
//   SpecimenStateNotifier({
//     required this.params,
//     required this.repository,
//   }) : super(SpecimenModelLoading()) {
//     getSpcmInformation();
//   }
//
//   Future<SpecimenModelBase> getSpcmInformation() async {
//     try {
//
//       // state = SpecimenInit();
//       // final tmp = params?.searchValue?? '';
//       // if (tmp == null || tmp == '') {
//       //   state = SpecimenInit();
//       //   return SpecimenInit();
//       // }
//
//       state = SpecimenModelLoading();
//       final List<SpecimenPrimaryModel> resp =
//           await repository.getSpcmInformation(specimenParams: params);
//
//       print('resp');
//       print(resp.toString());
//       state = SpecimenModel(data: resp);
//       updateSpecimenDebounce.setValue(null);
//
//       return SpecimenModel(data: resp);
//
//     } catch (e) {
//       print(e);
//       state = SpecimenModelError(message: '데이터를 가져오지 못했습니다.');
//       return Future.value(state);
//     }
//   }
// }

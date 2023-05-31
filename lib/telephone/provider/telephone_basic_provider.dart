import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/model/cursor_pagination_model.dart';
import 'package:unuseful/common/provider/pagination_provider.dart';
import 'package:unuseful/telephone/model/telephone_basic_model.dart';
import 'package:unuseful/telephone/repository/telephone_basic_repository.dart';
//
// final telephoneBasicFamilyProvider =
//     Provider.family<TelephoneModelBase?, String?>((ref, searchValue) {
//   final searchResult = ref.watch(telephoneBasicNotifierProvider.notifier);
//
//   print('searchValue');
//   print(searchValue);
//
//   List<TelephoneBasicModel> testModel =
//       List<TelephoneBasicModel>.generate(1000, (index) {
//     return TelephoneBasicModel(
//         hspTpCd: '서울',
//         deptNm: '전산정보팀',
//         etntTelNo: '5509',
//         telNoNm: '양찬우' + index.toString(),
//         telNoAbbrNm: 'EMR 진단검사,  인터페이스(진단검사',
//         sectDeptNm: '',
//         orderSeq: 1);
//   });
//
//   print('estModel.length');
//
//   print(testModel.length);
//
//   var tmpList = TelephoneModel<TelephoneBasicModel>(data: testModel);
//
//   if (searchValue == null || searchValue == '') {
//     // if (searchResult is TelephoneModelError)
//     //   return searchResult as TelephoneModelError;
//
//     // if (searchResult is TelephoneModel<TelephoneBasicModel>)
//     return tmpList as TelephoneModel<TelephoneBasicModel>;
//   } else {
//     var convertedSearchResult = tmpList as TelephoneModel<TelephoneBasicModel>;
//
//     //
//     // if (searchValue == null) {
//     //   if (searchResult is TelephoneModelError)
//     //     return searchResult as TelephoneModelError;
//     //
//     //   if (searchResult is TelephoneModel<TelephoneBasicModel>)
//     //     return searchResult as TelephoneModel<TelephoneBasicModel>;
//     // } else {
//     //   var convertedSearchResult =
//     //   searchResult as TelephoneModel<TelephoneBasicModel>;
//
//     convertedSearchResult.data
//         .removeWhere((element) => element.hspTpCd == "00");
//
// // List<TelephoneBasicModel> tmpData = []..addAll(convertedSearchResult.data
// //     .where((element) => element.TEL_NO_ABBR_NM.isEmpty)
// //     .map<TelephoneBasicModel>((e) =>
// //     TelephoneBasicModel(
// //         TEL_NO_ABBR_NM: '',
// //         SECT_DEPT_NM: e.SECT_DEPT_NM,
// //         DEPT_NM: e.DEPT_NM,
// //   TEL_NO_NM: e.TEL_NO_NM,
// //   HSP_TP_CD: e.HSP_TP_CD,
// //   ETNT_TEL_NO: e.ETNT_TEL_NO))
// //       .toList());
//
//     var tmpDataCopy = convertedSearchResult.data;
//
//     var searchValueArray = searchValue
//         .toUpperCase()
//         .split(' ')
//         .where((element) => !element.isEmpty)
//         .toList();
//
//     for (var values in searchValueArray) {
//       for (var ii = 0; ii < tmpDataCopy.length; ii++) {
//         if (tmpDataCopy[ii].deptNm.toUpperCase().contains(values) ||
//             tmpDataCopy[ii].telNoNm.toUpperCase().contains(values) ||
//             tmpDataCopy[ii].etntTelNo.toUpperCase().contains(values) ||
//             tmpDataCopy[ii].hspTpCd.toUpperCase().contains(values)) {
//         } else {
//           convertedSearchResult.data.remove(tmpDataCopy[ii]);
//         }
//       }
//     }
//     return TelephoneModel(data: convertedSearchResult.data);
//   }
// });

final telephoneBasicNotifierProvider =
    StateNotifierProvider<TelephoneBasicNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(telephoneBasicRepositoryProvider);
  final notifier = TelephoneBasicNotifier(repository: repository);
  return notifier;
});

class TelephoneBasicNotifier
    extends PaginationProvider<TelephoneBasicModel, TelephoneBasicRepository> {
  TelephoneBasicNotifier({required super.repository});
}

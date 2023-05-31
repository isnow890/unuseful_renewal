import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/telephone/model/telephone_advance_model.dart';
import 'package:unuseful/telephone/provider/telephone_search_value_provider.dart';
import 'package:unuseful/telephone/repository/telephone_advance_repository.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../common/provider/pagination_provider.dart';


//
// final telephoneAdvanceFamilyProvider =
//     Provider.family<TelephoneModelBase?, String?>((ref, searchValue) {
//   final searchResult = ref.watch(telephoneAdvanceNotifierProvider.notifier);
//
//   List<TelephoneAdvanceModel> testModel = List<TelephoneAdvanceModel>.generate(
//     1000,
//     (index) {
//       return TelephoneAdvanceModel(
//           sectDeptCd: 'SECT_DEPT_CD',
//           stfNo: 'STF_NO',
//           korNm: '양찬우',
//           telNoNm: 'TEL_NO_NM',
//           telNoAbbrNm: 'TEL_NO_ABBR_NM',
//           etntTelNo: '5509',
//           ugtTelNo: '010-4575-1190',
//           plc: 'PLC',
//           telNoTpCd: 'TEL_NO_TP_CD',
//           tmldYn: 'TMLD_YN',
//           opnYn: 'OPN_YN',
//           pdaNm: 'PDA_NM',
//           seq: 1,
//           rmkNm: 'RMK_NM',
//           deptCd: 'DEPT_CD',
//           deptCdNm: '전산정보팀',
//           hspTpCd: '서울병원',
//           telNoSeq: 1,
//           sid: 'SID',
//           deptNm: '전산정보팀', orderSeq: 1);
//     },
//   );
//
//   return TelephoneModel<TelephoneAdvanceModel>(data: testModel);
  //
  // if (searchValue == null) {
  //   return searchResult as TelephoneModel<TelephoneAdvanceModel>;
  // } else {
  //   var convertedSearchResult =
  //       searchResult as TelephoneModel<TelephoneAdvanceModel>;
  //
  //   var tmpData = convertedSearchResult.data;
  //   var tmpDataCopy = tmpData;
  //
  //   var searchValueArray = searchValue
  //       .toUpperCase()
  //       .split(' ')
  //       .where((element) => !element.isEmpty)
  //       .toList();
  //
  //   for (var values in searchValueArray) {
  //     for (var ii = 0; ii < tmpDataCopy.length; ii++) {
  //       if ((tmpDataCopy[ii].KOR_NM ?? '').toUpperCase().contains(values) ||
  //           (tmpDataCopy[ii].DEPT_CD_NM ?? '').toUpperCase().contains(values) ||
  //           (tmpDataCopy[ii].ETNT_TEL_NO ?? '')
  //               .toUpperCase()
  //               .contains(values) ||
  //           (tmpDataCopy[ii].UGT_TEL_NO ?? '').toUpperCase().contains(values) ||
  //           (tmpDataCopy[ii].STF_NO ?? '').toUpperCase().contains(values) ||
  //           (tmpDataCopy[ii].HSP_TP_CD ?? '').toUpperCase().contains(values)) {
  //       } else {
  //         tmpData.remove(tmpDataCopy[ii]);
  //       }
  //     }
  //   }
  //   return TelephoneModel(data: tmpData);
  // }
//});
//
//
// final telephoneAdvanceNotifierProvider =
//     StateNotifierProvider<TelephoneAdvanceNotifier, CursorPaginationBase>((ref) {
//   final repository = ref.watch(telephoneAdvanceRepositoryProvider);
//   final notifier = TelephoneAdvanceNotifier(repository: repository);
//   return notifier;
// });
//
// class TelephoneAdvanceNotifier extends PaginationProvider<TelephoneAdvanceModel, TelephoneAdvanceRepository> {
//   TelephoneAdvanceNotifier({required super.repository});
// }


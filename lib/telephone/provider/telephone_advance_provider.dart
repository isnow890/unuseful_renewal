import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/telephone/model/telephone_advance_model.dart';
import 'package:unuseful/telephone/model/telephone_model.dart';
import 'package:unuseful/telephone/provider/telephone_search_value_provider.dart';
import 'package:unuseful/telephone/repository/telephone_advance_repository.dart';

final telephoneAdvanceFamilyProvider =
    Provider.family<TelephoneModelBase?, String?>((ref, searchValue) {
  final searchResult = ref.watch(telephoneAdvanceNotifierProvider.notifier);

  List<TelephoneAdvanceModel> testModel =
      List<TelephoneAdvanceModel>.generate(1000, (index) {
    return TelephoneAdvanceModel(
        SECT_DEPT_CD: 'SECT_DEPT_CD',
        STF_NO: 'STF_NO',
        KOR_NM: '양찬우',
        TEL_NO_NM: 'TEL_NO_NM',
        TEL_NO_ABBR_NM: 'TEL_NO_ABBR_NM',
        ETNT_TEL_NO: '5509',
        UGT_TEL_NO: '010-4575-1190',
        PLC: 'PLC',
        TEL_NO_TP_CD: 'TEL_NO_TP_CD',
        TMLD_YN: 'TMLD_YN',
        OPN_YN: 'OPN_YN',
        PDA_NM: 'PDA_NM',
        SEQ: 1,
        RMK_NM: 'RMK_NM',
        DEPT_CD: 'DEPT_CD',
        DEPT_CD_NM: '전산정보팀',
        HSP_TP_CD: '서울병원',
        TEL_NO_SEQ: 1,
        SID: 'SID',
        DEPT_NM: '전산정보팀');
  });

  return TelephoneModel<TelephoneAdvanceModel>(data: testModel);

  if (searchValue == null) {
    return searchResult as TelephoneModel<TelephoneAdvanceModel>;
  } else {
    var convertedSearchResult =
        searchResult as TelephoneModel<TelephoneAdvanceModel>;

    var tmpData = convertedSearchResult.data;
    var tmpDataCopy = tmpData;

    var searchValueArray = searchValue
        .toUpperCase()
        .split(' ')
        .where((element) => !element.isEmpty)
        .toList();

    for (var values in searchValueArray) {
      for (var ii = 0; ii < tmpDataCopy.length; ii++) {
        if ((tmpDataCopy[ii].KOR_NM ?? '').toUpperCase().contains(values) ||
            (tmpDataCopy[ii].DEPT_CD_NM ?? '').toUpperCase().contains(values) ||
            (tmpDataCopy[ii].ETNT_TEL_NO ?? '')
                .toUpperCase()
                .contains(values) ||
            (tmpDataCopy[ii].UGT_TEL_NO ?? '').toUpperCase().contains(values) ||
            (tmpDataCopy[ii].STF_NO ?? '').toUpperCase().contains(values) ||
            (tmpDataCopy[ii].HSP_TP_CD ?? '').toUpperCase().contains(values)) {
        } else {
          tmpData.remove(tmpDataCopy[ii]);
        }
      }
    }
    return TelephoneModel(data: tmpData);
  }
});

final telephoneAdvanceNotifierProvider =
    StateNotifierProvider<TelephoneAdvanceNotifier, TelephoneModelBase?>((ref) {
  final repository = ref.watch(telephoneAdvanceRepositoryProvider);
  final notifier = TelephoneAdvanceNotifier(repository: repository);
  return notifier;
});

class TelephoneAdvanceNotifier extends StateNotifier<TelephoneModelBase?> {
  final TelephoneAdvanceRepository repository;

  TelephoneAdvanceNotifier({required this.repository})
      : super(TelephoneModelLoading()) {
    getAdvance();
  }

  Future<void> getAdvance() async {
    state = TelephoneModelLoading();
    try {
      final resp = await repository.getAdvance();
      state = TelephoneModel<TelephoneAdvanceModel>(data: resp);
    } catch (e) {
      state = TelephoneModelError(message: '에러가 발생했습니다');
      return Future.value(state);
    }
  }

//   TelephoneAdvanceNotifier({
//     required this.
// })
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unuseful/common/const/data.dart';
import 'package:unuseful/speciemen/model/speciemen_model.dart';

import '../model/speciemen_params.dart';
import '../repository/speciemen_repository.dart';

class SpecimenStateNotifier extends StateNotifier<SpeciemenModelBase?> {
  final SpeciemenRepository repository;
  final String? spcmNo;
  final FlutterSecureStorage storage;

  SpecimenStateNotifier({
    required this.storage,
    required this.spcmNo,
    required this.repository,
  }) : super(SpeciemenLoading()) {
    getSpcmInformation();
  }

  Future<void> getSpcmInformation() async {
    state = SpeciemenLoading();

    if (spcmNo == null) state = null;

    try {
      final resp = await repository.getSpcmInformation(
          speciemenParams: SpeciemenParams(
              hspTpCd: await storage.read(key: CONST_HSP_TP_CD),
              spcmNo: spcmNo));
      state = resp;
    } catch (e) {
      state = SpeciemenModelError(message: '데이터를 가져오지 못했습니다.');
      return Future.value(state);
    }
  }
}

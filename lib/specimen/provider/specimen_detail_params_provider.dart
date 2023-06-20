import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/specimen/model/specimen_detail_params.dart';

final specimenDetailParamsProvider = StateProvider<SpecimenDetailParams>(
  (ref) => SpecimenDetailParams(spcmNo: '', hspTpCd: '', exrmExmCtgCd: ''),
);

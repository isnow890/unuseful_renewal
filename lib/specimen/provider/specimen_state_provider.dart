

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/specimen/provider/specimenSearchValueProvider.dart';

import '../model/specimen_model.dart';

final specimenStateProvider = StateProvider<SpecimenModelBase>((ref) {
  final search = ref.watch(specimenSearchValueProvider);


  return SpecimenInit();
});


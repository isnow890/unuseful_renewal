

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/specimen_model.dart';
import 'specimenSearchValueProvider.dart';

final specimenStateProvider = StateProvider<SpecimenModelBase>((ref) {
  final search = ref.watch(specimenSearchValueProvider);


  return SpecimenInit();
});


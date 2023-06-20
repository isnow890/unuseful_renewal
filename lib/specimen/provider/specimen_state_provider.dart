

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/specimen_model.dart';

final specimenStateProvider = StateProvider<SpecimenModelBase>((ref) {
  return SpecimenInit();
});


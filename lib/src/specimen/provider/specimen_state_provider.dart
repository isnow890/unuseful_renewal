

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/model_base.dart';

import '../model/specimen_model.dart';
import 'specimenSearchValueProvider.dart';

final specimenStateProvider = StateProvider.autoDispose<ModelBase>((ref) {
  final search = ref.watch(specimenSearchValueProvider);


  return ModelBaseInit();
});


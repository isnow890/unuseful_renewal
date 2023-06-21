import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/model/response_model.dart';

final responseModelStateProvider =
    StateProvider<ResponseModelBase>((ref) => ResponseModelInit());

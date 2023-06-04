import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/secure_storage/secure_storage.dart';

import '../../common/const/data.dart';
import '../../user/provider/login_variable_provider.dart';

// final hspTpCdProvider = StateProvider<String>((ref) {
//   final loginValue = ref.read(loginVariableStateProvider);
//
//   return loginValue.hspTpCd!;
// });
final hspTpCdProvider = StateProvider<String>((ref) =>'');

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/telephone/model/telephone_basic_model.dart';
import 'package:unuseful/telephone/repository/telephone_basic_repository.dart';


// final telephoneBasicProvider = Provider.family<TelephoneBasicModel?,String>((ref,searchValue){
//
//
// };

final telephoneBasicNotifierProvider = StateNotifierProvider<TelephoneBasicNotifier,List<TelephoneBasicModel>>((ref)
{

  final repository = ref.watch(telephoneBasicRepositoryProvider);
  final notifier = TelephoneBasicNotifier(repository : repository);

  return notifier;

});


class TelephoneBasicNotifier extends StateNotifier<TelephoneBasicModelBase?> {
  final TelephoneBasicRepository repository;

  TelephoneBasicNotifier( {required this.repository})
      : super(TelephoneBasicModelLoading()) {
    getBasic();
  }

  Future<void> getBasic() async {
    state = TelephoneBasicModelLoading();


    try {
      final resp = await repository.getBasic();
    } catch (e) {
      state = TelephoneBasicModelError(message: '에러가 발생했습니다');
      return Future.value(state);
    }
  }
}

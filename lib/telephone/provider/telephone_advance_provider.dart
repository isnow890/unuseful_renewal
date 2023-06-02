import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/telephone/model/telephone_advance_model.dart';
import 'package:unuseful/telephone/provider/telephone_search_value_provider.dart';
import 'package:unuseful/telephone/repository/telephone_advance_repository.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../common/provider/pagination_provider.dart';


final telephoneAdvanceNotifierProvider=
    StateNotifierProvider<TelephoneAdvanceNotifier, CursorPaginationBase>((ref){

      final repository = ref.watch(telephoneAdvanceRepositoryProvider);
      final searchValue = ref.watch(telephoneSearchValueProvider);
      final notifier = TelephoneAdvanceNotifier(searchValue: searchValue, repository: repository);
      return notifier;

});

class TelephoneAdvanceNotifier
extends PaginationProvider<TelephoneAdvanceModel, TelephoneAdvanceRepository>{
  TelephoneAdvanceNotifier({required super.searchValue, required super.repository});

}




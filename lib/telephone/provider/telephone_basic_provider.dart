import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/model/cursor_pagination_model.dart';
import 'package:unuseful/common/provider/pagination_provider.dart';
import 'package:unuseful/telephone/model/telephone_basic_model.dart';
import 'package:unuseful/telephone/provider/telephone_search_value_provider.dart';
import 'package:unuseful/telephone/repository/telephone_basic_repository.dart';

final telephoneBasicNotifierProvider =
    StateNotifierProvider<TelephoneBasicNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(telephoneBasicRepositoryProvider);
  final searchValue = ref.watch(telephoneSearchValueProvider);
  final notifier =
      TelephoneBasicNotifier(repository: repository, searchValue: searchValue);
  return notifier;
});

class TelephoneBasicNotifier
    extends PaginationProvider<TelephoneBasicModel, TelephoneBasicRepository> {
  TelephoneBasicNotifier(
      {required super.repository, required super.searchValue});
}

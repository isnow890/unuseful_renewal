
import 'package:unuseful/common/model/model_with_order_seq.dart';

import '../model/cursor_pagination_model.dart';
import '../model/pagination_params.dart';

//Repository 일반화 클래스임
abstract class IBasePaginationRepository<T extends IModelWithDataSeq> {
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}

import 'package:json_annotation/json_annotation.dart';
import 'package:unuseful/src/common/model/model_base.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  //제네릭 사용 1
  genericArgumentFactories: true,
)
//제네릭 사용 2 T 선언
class CursorPagination<T> extends ModelBase {
  final CursorPaginationMeta meta;

  //제네릭 사용 3 T 필요한 부분 선언
  final List<T> data;

  CursorPagination({required this.meta, required this.data});

  CursorPagination copywith({
    CursorPaginationMeta? meta,
    List<T>? data,
  }) {
    return CursorPagination<T>(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  //제네릭 사용 3 T 필요한 부분 선언
  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final bool hasMore;
  final int totalCount;
  final String? message;

  CursorPaginationMeta({
    required this.hasMore,
    required this.totalCount,
    required this.message,
  });

  CursorPaginationMeta copyWith({int? statusCode, bool? hasMore, int? totalCount, String? message}) {
    return CursorPaginationMeta(
        hasMore: hasMore ?? this.hasMore,
        totalCount: totalCount ?? this.totalCount,
        message: message ?? this.message);
  }

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

//다시 처음부터 불러오기 새로고침 할때.
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({required super.meta, required super.data});
}

//리스트의 맨 아래로 내려서
//추가 데이터를 요청하는 중
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({required super.meta, required super.data});
}

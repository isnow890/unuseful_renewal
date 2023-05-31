import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/model/cursor_pagination_model.dart';
import 'package:unuseful/telephone/model/telephone_advance_model.dart';
import 'package:unuseful/telephone/repository/telephone_advance_repository.dart';

import '../../common/component/custom_circular_progress_indicator.dart';
import '../../common/const/colors.dart';
import '../../common/utils/pagination_utils.dart';
import '../provider/telephone_advance_provider.dart';
import '../provider/telephone_search_value_provider.dart';

class TelephoneAdvanceScreen extends ConsumerStatefulWidget {
  const TelephoneAdvanceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TelephoneAdvanceScreen> createState() =>
      _TelephoneAdvanceScreenState();
}

class _TelephoneAdvanceScreenState
    extends ConsumerState<TelephoneAdvanceScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
        controller: controller,
        provider: ref.read(telephoneAdvanceNotifierProvider.notifier));
  }

  @override
  Widget build(BuildContext context) {
    final searchValue = ref.watch(telephoneSearchValueProvider);
    print('빌드함?');
    final state = ref.watch(telephoneAdvanceNotifierProvider);

    if (state is CursorPaginationLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCircularProgressIndicator(),
        ],
      );
    }

    if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () {
                ref
                    .read(telephoneAdvanceNotifierProvider.notifier)
                    .paginate(forceRefetch: true);
              },
              child: Text('다시 시도')),
        ],
      );
    }

    final cp = state as CursorPagination<TelephoneAdvanceModel>;

    if (state is CursorPagination<TelephoneAdvanceModel>) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            ref
                .read(telephoneAdvanceNotifierProvider.notifier)
                .paginate(forceRefetch: true);
          },
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                height: 20.0,
              );
            },
            itemCount: state.data.length + 1,
            itemBuilder: (context, index) {
              if (index == cp.data.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Center(
                      child: cp is CursorPaginationFetchingMore
                          ? CircularProgressIndicator()
                          : Text('마지막 데이터입니다.')),
                );
              }

              return ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.data[index].korNm,
                      style: TextStyle(
                          fontSize: 22,
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.phone_android_outlined,
                      color: Colors.blue,
                    ),
                  ],
                ),
                title: Text('${state.data[index].deptCdNm}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${state.data[index].hspTpCd}'),
                    Row(
                      children: [
                        Text(
                          state.data[index].etntTelNo,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: PRIMARY_COLOR),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          state.data[index].ugtTelNo,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
                isThreeLine: true,
              );
            },
          ),
        ),
      );
    }

    if (state is CursorPaginationLoading) {
      return CircularProgressIndicator();
    } else
      return Center(
        child: Text('에러'),
      );
  }
}

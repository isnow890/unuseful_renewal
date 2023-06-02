import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/component/custom_circular_progress_indicator.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/common/model/cursor_pagination_model.dart';
import 'package:unuseful/common/utils/url_launcher_utils.dart';
import 'package:unuseful/telephone/model/telephone_basic_model.dart';
import 'package:unuseful/telephone/provider/telephone_basic_provider.dart';
import 'package:unuseful/telephone/provider/telephone_search_value_provider.dart';

import '../../common/utils/pagination_utils.dart';

class TelephoneBasicScreen extends ConsumerStatefulWidget {
  const TelephoneBasicScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TelephoneBasicScreen> createState() =>
      _TelephoneBasicScreenState();
}

class _TelephoneBasicScreenState extends ConsumerState<TelephoneBasicScreen> {
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
        provider: ref.read(telephoneBasicNotifierProvider.notifier));
  }

  @override
  Widget build(BuildContext context) {
    //값이 바뀔때마다 재 빌드 하기 위하여.
    final searchValue = ref.watch(telephoneSearchValueProvider);
    final state = ref.watch(telephoneBasicNotifierProvider);

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
                    .read(telephoneBasicNotifierProvider.notifier)
                    .paginate(forceRefetch: true);
              },
              child: Text('다시 시도')),
        ],
      );
    }

    //CursorPagination
    //CursorPaginationFetchingMore
    //CursorPaginationRefetching

    final cp = state as CursorPagination<TelephoneBasicModel>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RefreshIndicator(
        onRefresh: () async {
          ref
              .read(telephoneBasicNotifierProvider.notifier)
              .paginate(forceRefetch: true);
        },
        child: ListView.separated(
          controller: controller,
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
              contentPadding: EdgeInsets.only(left: 0.0),

              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.data[index].hspTpCd ?? '',
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
                  if (state.data[index].purifiedTelNo != null)
                    IconButton(
                      onPressed: () { UrlLauncherUtils.makePhoneCall(state.data[index].purifiedTelNo!);},
                      icon: Icon(Icons.phone_android_outlined),
                      color: Colors.red,
                    ),
                ],
              ),
              title: Text(state.data[index].deptNm ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.data[index].telNoNm ?? ''),
                  Row(
                    children: [
                      Text(
                        state.data[index].etntTelNo ?? '',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: PRIMARY_COLOR),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        state.data[index].telNoAbbrNm ?? '',
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



}



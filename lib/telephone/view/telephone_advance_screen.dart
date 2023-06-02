import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/model/cursor_pagination_model.dart';
import 'package:unuseful/telephone/model/telephone_advance_model.dart';

import '../../common/component/custom_circular_progress_indicator.dart';
import '../../common/const/colors.dart';
import '../../common/utils/pagination_utils.dart';
import '../../common/utils/url_launcher_utils.dart';
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(

                        state.data[index].korNm ?? '',
                        overflow: TextOverflow.visible,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 22,
                            color: PRIMARY_COLOR,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.data[index].ugtTelNo != null)
                      IconButton(
                        onPressed: () { UrlLauncherUtils.makePhoneCall(state.data[index].ugtTelNo!);},
                        icon: Icon(Icons.phone_android_outlined),
                        color: Colors.blue,
                      ),
                  ],
                ),
                title: Text('${state.data[index].deptCdNm ?? ''}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${state.data[index].hspTpCd ?? ''}'),
                    Text(
                      state.data[index].ugtTelNo ?? '',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (state.data[index].etntTelNo != null)
                      Text(
                        state.data[index].etntTelNo ?? '',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: PRIMARY_COLOR),
                      ),
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

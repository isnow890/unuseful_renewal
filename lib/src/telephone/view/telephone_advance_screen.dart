import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share/share.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/src/common/model/cursor_pagination_model.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/telephone/model/telephone_advance_model.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/component/custom_readonly_search_text_field.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import 'package:unuseful/util/helper/pagination_utils.dart';
import 'package:unuseful/util/helper/url_launcher_utils.dart';
import '../provider/telephone_advance_provider.dart';
import '../provider/telephone_search_value_provider.dart';
import 'telephone_search_screen.dart';

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
    final state = ref.watch(telephoneAdvanceNotifierProvider);

    final theme = ref.watch(themeServiceProvider);

    if (state is ModelBaseLoading) {
      return const CircularIndicator();
    }

    // if (state is CursorPaginationError) {
    //   return Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       Text(
    //         state.message,
    //         textAlign: TextAlign.center,
    //       ),
    //       ElevatedButton(
    //           onPressed: () {
    //             ref
    //                 .read(telephoneAdvanceNotifierProvider.notifier)
    //                 .paginate(forceRefetch: true);
    //           },
    //           child: Text('다시 시도')),
    //     ],
    //   );
    // }

    final cp = state as CursorPagination<TelephoneAdvanceModel>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DefaultLayout(
        canRefresh: true,
        onRefreshAndError: () async {
          await ref
              .read(telephoneAdvanceNotifierProvider.notifier)
              .paginate(forceRefetch: true);
        },
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomReadOnlySearchTextField(
              push: TelephoneSearchScreen.routeName,
              provider: telephoneSearchValueProvider,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                controller: controller,
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
                                ? const CircularIndicator()
                                : Text(
                                    '마지막 데이터입니다.',
                                    style: theme.typo.subtitle2,
                                  )),
                      );
                    }

                    return ListTile(
                      horizontalTitleGap: 10,
                      contentPadding: EdgeInsets.only(left: 0.0),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                              children: [
                                Text(
                                  state.data[index].korNm ?? '',
                                  overflow: TextOverflow.visible,
                                  softWrap: false,
                                  maxLines: 1,
                                  style: theme.typo.headline5,
                                ),
                                const SizedBox(height: 10),
                                Text(state.data[index].stfNo ?? '',
                                    overflow: TextOverflow.visible,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: theme.typo.body2),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.data[index].ugtTelNo != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Button(
                                    iconData: Icons.share_outlined,
                                    type: ButtonType.flat,
                                    color: theme.color.secondary,
                                    onPressed: () {
                                      Share.share(_shareInfo(
                                          hspTpCd: state.data[index].hspTpCd,
                                          korNm: state.data[index].korNm,
                                          stfNo: state.data[index].stfNo,
                                          deptCdNm: state.data[index].deptCdNm,
                                          etntTelNo:
                                              state.data[index].etntTelNo,
                                          ugtTelNo:
                                              state.data[index].ugtTelNo));
                                    },
                                  ),


                                  Button(
                                    iconData: Icons.phone,
                                    type: ButtonType.flat,
                                    color: theme.color.secondary,
                                    onPressed: () {
                                      UrlLauncherHelper.makePhoneCall(
                                          state.data[index].ugtTelNo!);

                                    },
                                  ),


                                ],
                              ),
                            ),
                        ],
                      ),
                      title: Text(state.data[index].deptCdNm ?? '', style :theme.typo.subtitle1),

                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height:5
                          ),
                          Text(state.data[index].hspTpCd ?? '', style:theme.typo.subtitle2),
                          const SizedBox(height:5
                          ),
                          Text(
                            state.data[index].ugtTelNo ?? '',
                            style: theme.typo.subtitle2,
                          ),
                          const SizedBox(height:5
                          ),

                          // if (state.data[index].etntTelNo != null)
                          //   Text(
                          //     state.data[index].etntTelNo ?? '',
                          //     style: TextStyle(
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w500,
                          //         color: PRIMARY_COLOR),
                          //   ),
                        ],
                      ),
                      // isThreeLine: true,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _shareInfo(
      {required String? hspTpCd,
      required String? korNm,
      required String? stfNo,
      required String? deptCdNm,
      required String? etntTelNo,
      required String? ugtTelNo}) {
    String tmpEtntTelNo = '';
    if (etntTelNo != null) tmpEtntTelNo = "내선번호:${etntTelNo}\n";

    final String returnedText =
        '직원:${korNm}(${stfNo})\n병원:$hspTpCd\n부서:${deptCdNm}\n${tmpEtntTelNo}전화번호:${ugtTelNo}';
    return returnedText;
  }
}

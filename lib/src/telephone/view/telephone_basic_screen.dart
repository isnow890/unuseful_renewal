import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share/share.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/src/common/model/cursor_pagination_model.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/telephone/model/telephone_basic_model.dart';
import 'package:unuseful/src/telephone/provider/telephone_basic_provider.dart';
import 'package:unuseful/src/telephone/provider/telephone_search_value_provider.dart';
import 'package:unuseful/theme/component/button/button.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/component/custom_readonly_search_text_field.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import 'package:unuseful/util/helper/pagination_utils.dart';
import 'package:unuseful/util/helper/url_launcher_utils.dart';
import '../component/custom_readonly_search_text_field.dart';
import 'telephone_search_screen.dart';

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

    final theme = ref.watch(themeServiceProvider);
    final state = ref.watch(telephoneBasicNotifierProvider);
    if (state is ModelBaseLoading) {
      return const CircularIndicator();
    }

    final cp = state as CursorPagination<TelephoneBasicModel>;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DefaultLayout(
          canRefresh: true,
          onRefreshAndError: () async {
            await ref
                .read(telephoneBasicNotifierProvider.notifier)
                .paginate(forceRefetch: true);
          },
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomReadOnlySearchTextField(
                  push: TelephoneSearchScreen.routeName,
                  provider: telephoneSearchValueProvider),
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
                        contentPadding: EdgeInsets.only(left: 10.0),
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.data[index].hspTpCd ?? '',
                              style: theme.typo.headline5,
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                          deptNm: state.data[index].deptNm,
                                          telNoNm: state.data[index].telNoNm,
                                          etntTelNo:
                                              state.data[index].etntTelNo,
                                          telNoAbbrNm:
                                              state.data[index].telNoAbbrNm,
                                          purifiedTelNo:
                                              state.data[index].purifiedTelNo));
                                    },
                                  ),
                                  if (state.data[index].purifiedTelNo != null)
                                    Button(
                                      iconData: Icons.phone,
                                      type: ButtonType.flat,
                                      color: theme.color.secondary,
                                      onPressed: () {
                                        UrlLauncherHelper.makePhoneCall(
                                            state.data[index].purifiedTelNo!);
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            state.data[index].deptNm ?? '',
                            style: theme.typo.subtitle1,
                          ),
                        ),

                        subtitle: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                state.data[index].telNoNm ?? '',
                                style: theme.typo.subtitle2,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    state.data[index].etntTelNo ?? '',
                                    style: theme.typo.subtitle2,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    state.data[index].telNoAbbrNm ?? '',
                                    style: theme.typo.subtitle2,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        // isThreeLine: true,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _shareInfo(
      {required String? hspTpCd,
      required String? deptNm,
      required String? telNoNm,
      required String? etntTelNo,
      required String? telNoAbbrNm,
      required String? purifiedTelNo}) {
    String tmpTelNoAbbrNm = '';
    if (telNoNm != null) tmpTelNoAbbrNm = "이름:${telNoAbbrNm}\n";

    final String returnedText =
        '병원:$hspTpCd\n부서:$deptNm\n실방:$telNoNm\n${tmpTelNoAbbrNm}TEL:${etntTelNo}${purifiedTelNo != null ? "\n$purifiedTelNo" : ''}';
    return returnedText;
  }
}

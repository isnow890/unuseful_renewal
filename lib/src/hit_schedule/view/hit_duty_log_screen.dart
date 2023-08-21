import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import '../../../colors.dart';
import '../../../theme/component/base_search_screen_widget.dart';
import '../model/hit_schedule_log_model.dart';
import '../provider/hit_duty_log_provider.dart';

class HitDutyLogScreen extends ConsumerStatefulWidget {
  const HitDutyLogScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HitDutyLogScreen> createState() => _HitDutyLogScreenState();
}

class _HitDutyLogScreenState extends ConsumerState<HitDutyLogScreen> {
  final ScrollController controller = ScrollController();

  // Map<String,dynamic> fi2 = {'hspTpCd' : '01', 'searchValue': '10884537','strDt': '20220522',
  //   'endDt': '20230619' ,'orderBy': 'desc'};

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);
    final state = ref.watch(hitDutyLogNotifierProvider);

    if (state is ModelBaseLoading) {
      return const CircularIndicator();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: DefaultLayout(
        canRefresh: true,
          onRefreshAndError: () async {
            ref.invalidate(hitDutyLogNotifierProvider);
          },
          child: BaseSearchScreenWidget(
        itemCount: (state as HitDutyLogModel).data.length,
        header: Row(children: [
          Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    '구분',
                    style: theme.typo.subtitle2,
                  )),
            ],
          ),
          Expanded(
            flex: 8,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '변경일시  /  내용  /  변경자',
                style: theme.typo.subtitle2,
              ),
            ),
          )
        ]),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Container(
                            color: state.data[index].changeInfo.contains('<->')
                                ? Colors.red
                                : theme.color.tertiary,
                            width: 5,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            state.data[index].changeInfo.contains('<->')
                                ? '변경'
                                : '신규',
                            style: theme.typo.subtitle1),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            DateFormat('yyyy-MM-dd HH:mm')
                                .format(state.data[index].changeDate),
                            style: theme.typo.body1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              state.data[index].changeInfo ?? '',
                              style: theme.typo.body1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              state.data[index].stfInfo ?? '',
                              style: theme.typo.body1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },

      )),
    );
  }
}

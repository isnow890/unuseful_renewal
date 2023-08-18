import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/home/component/history_chip.dart';
import 'package:unuseful/theme/component/section_card.dart';
import 'package:unuseful/src/home/model/search_history_main_model.dart';
import 'package:unuseful/src/home/provider/telehphone_history_provider.dart';
import 'package:unuseful/src/telephone/view/telephone_main_screen.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

import '../../telephone/provider/telephone_search_value_provider.dart';

class TelephoneSection extends ConsumerWidget {
  const TelephoneSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telephone = ref.watch(telephoneHistoryNotfierProvider);
    final theme = ref.watch(themeServiceProvider);

    if (telephone is ModelBaseLoading) {
      return const CircularIndicator();
    }

    return DefaultLayout(
        canRefresh: true,
        onRefreshAndError: () async =>
            ref.refresh(telephoneHistoryNotfierProvider),
        state: [telephone],
        child: ListView(
          children: [
            SectionCard(
              contentWidget: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '최근 조회 내역',
                            style: theme.typo.subtitle1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      (telephone as SearchHistoryMainModel).history!.isEmpty
                          ? Row(
                              children: [
                                Text(
                                  '최근 조회 내역이 없습니다.',
                                  style: theme.typo.body1,
                                ),
                              ],
                            )
                          : Wrap(
                              alignment: WrapAlignment.center,
                              children: (telephone)
                                  .history!
                                  .take(20)
                                  .map((e) => HistoryChip(
                                        onDeleted: () async {
                                          await ref
                                              .read(
                                                  telephoneHistoryNotfierProvider
                                                      .notifier)
                                              .delTelephoneHistory(body: e);

                                          await ref
                                              .read(
                                                  telephoneHistoryNotfierProvider
                                                      .notifier)
                                              .getTelephoneHistory();
                                        },
                                        onTap: () {
                                          ref
                                              .read(telephoneSearchValueProvider
                                                  .notifier)
                                              .update((state) => e.searchValue);

                                          context.pushNamed(
                                            TelePhoneMainScreen.routeName,
                                          );
                                        },
                                        title: e.searchValue,
                                      ))
                                  .toList(),
                            )
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }

  _renderBody(telephone, WidgetRef ref, BuildContext context) {}
}

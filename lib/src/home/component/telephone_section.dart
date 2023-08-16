import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/home/component/history_chip.dart';
import 'package:unuseful/src/home/component/home_screen_card.dart';
import 'package:unuseful/src/home/model/search_history_specimen_model.dart';
import 'package:unuseful/src/home/provider/telehphone_history_provider.dart';
import 'package:unuseful/src/telephone/view/telephone_main_screen.dart';
import 'package:unuseful/theme/component/custom_circular_progress_indicator.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';

import '../../telephone/provider/telephone_search_value_provider.dart';

class TelephoneSection extends ConsumerWidget {
  const TelephoneSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telephone = ref.watch(telephoneHistoryNotfierProvider);

    return HomeScreenCard(
      contentWidget: Column(
        children: [
          _renderBody(telephone, ref, context),
        ],
      ),
    );
  }

  _renderBody(telephone, WidgetRef ref, BuildContext context) {
    if (telephone is ModelBaseLoading) {
      return const CustomCircularProgressIndicator();
    } else if (telephone is ModelBaseError) {
      return CustomErrorWidget(
          message: telephone.message,
          onPressed: () {
            ref
                .read(telephoneHistoryNotfierProvider.notifier)
                .getTelephoneHistory();
          });
    } else if (telephone is SearchHistoryMainModel) {
      return telephone.history.isEmpty
          ? const Row(
              children: [
                Text(
                  '최근 조회 내역이 없습니다.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      '최근 조회 내역',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(
                      height: 15,
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: telephone.history!
                      .take(5)
                      .map((e) => HistoryChip(
                            onDeleted: () async {
                              await ref
                                  .read(
                                      telephoneHistoryNotfierProvider.notifier)
                                  .delTelephoneHistory(body: e);

                              await ref
                                  .read(
                                      telephoneHistoryNotfierProvider.notifier)
                                  .getTelephoneHistory();
                            },
                            onTap: () {
                              ref
                                  .read(telephoneSearchValueProvider.notifier)
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
            );
    }
  }
}

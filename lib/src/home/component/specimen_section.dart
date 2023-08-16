import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/home/component/history_chip.dart';
import 'package:unuseful/src/home/component/home_screen_card.dart';
import 'package:unuseful/src/home/model/search_history_specimen_model.dart';
import 'package:unuseful/src/home/provider/specimen_history_provider.dart';
import 'package:unuseful/theme/component/custom_error_widget.dart';

import '../../../theme/component/custom_circular_progress_indicator.dart';
import '../../specimen/provider/specimenSearchValueProvider.dart';

class SpecimenSection extends ConsumerWidget {
  const SpecimenSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specimen = ref.watch(specimenHistoryNotfierProvider);

    return HomeScreenCard(
      contentWidget: Column(
        children: [
          _renderBody(specimen, ref, context),
        ],
      ),
    );
  }

  _renderBody(ModelBase? specimen, WidgetRef ref, BuildContext context) {
    if (specimen is ModelBaseLoading) {
      return const CustomCircularProgressIndicator();
    } else if (specimen is ModelBaseError) {
      return CustomErrorWidget(
          message: specimen.message,
          onPressed: () {
            ref
                .read(specimenHistoryNotfierProvider.notifier)
                .getSpecimenHistory();
          });
    } else if (specimen is SearchHistoryMainModel) {
      return specimen.history!.length == 0
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
                  children: specimen.history!
                      .take(5)
                      .map((e) => HistoryChip(
                            onDeleted: () async {
                              ref
                                  .read(specimenHistoryNotfierProvider.notifier)
                                  .delSpecimenHistory(body: e);
                            },
                            onTap: () async {
                              await ref
                                  .read(specimenSearchValueProvider.notifier)
                                  .update((state) => e.searchValue);
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

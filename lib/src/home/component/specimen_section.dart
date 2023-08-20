import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/home/component/history_chip.dart';
import 'package:unuseful/theme/component/section_card.dart';
import 'package:unuseful/src/home/model/search_history_main_model.dart';
import 'package:unuseful/src/home/provider/specimen_history_provider.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

import '../../specimen/provider/specimenSearchValueProvider.dart';

class SpecimenSection extends ConsumerWidget {
  const SpecimenSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specimen = ref.watch(specimenHistoryNotfierProvider);
    final theme = ref.watch(themeServiceProvider);

    if (specimen is ModelBaseLoading) {
      return const CircularIndicator();
    }

    return DefaultLayout(
        canRefresh: true,
        onRefreshAndError: () async {
          ref.refresh(specimenHistoryNotfierProvider);
        },
        child: ListView(children: [
          SectionCard(
            contentWidget: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '진검 검사결과 최근 조회 내역',
                      style: theme.typo.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                ),
                (specimen as SearchHistoryMainModel).history!.isEmpty
                    ? Row(
                        children: [
                          Text(
                            '최근 조회 내역이 없습니다.',
                            style: theme.typo.body1,
                          ),
                        ],
                      )
                    : Wrap(
                        alignment: WrapAlignment.start,
                        children: specimen.history!
                            .take(20)
                            .map((e) => HistoryChip(
                                  onDeleted: () async {
                                    ref
                                        .read(specimenHistoryNotfierProvider
                                            .notifier)
                                        .delSpecimenHistory(body: e);
                                  },
                                  onTap: () async {
                                    ref
                                        .read(specimenSearchValueProvider
                                            .notifier)
                                        .update((state) => e.searchValue);
                                  },
                                  title: e.searchValue,
                                ))
                            .toList(),
                      )
              ],
            ),
          )
        ]));
  }
}

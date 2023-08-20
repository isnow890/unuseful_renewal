import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/patient/model/patient_model.dart';
import 'package:unuseful/src/patient/provider/patient_provider.dart';
import 'package:unuseful/theme/component/base_search_screen_widget.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/model/menu_model.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import '../../../colors.dart';
import '../../../theme/layout/default_layout.dart';
import '../../common/provider/drawer_selector_provider.dart';
import '../provider/patient_total_count_provider.dart';

class PatientScreen extends ConsumerStatefulWidget {
  const PatientScreen({Key? key}) : super(key: key);

  static String get routeName => 'patient';

  @override
  ConsumerState<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends ConsumerState<PatientScreen> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);
    final state = ref.watch(patientNotifierProvider);

    return DefaultLayout(
        title: MenuModel.getMenuInfo(PatientScreen.routeName).menuName,
        canRefresh: true,
        onRefreshAndError: () async {
          ref.invalidate(patientNotifierProvider);
        },
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            if (state is ModelBaseLoading) {
              return const CircularIndicator();
            }
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: BaseSearchScreenWidget(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(state.data[index].hspTpCd!,
                                    style: theme.typo.headline6),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  state.data[index].blindedPtNm =
                                      state.data[index].ptNm;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(state.data[index].blindedPtNm,
                                          style: theme.typo.subtitle1),
                                      const SizedBox(width: 10,),
                                      Text(state.data[index].ptNo,
                                          style: theme.typo.body1),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0,),
                                  Text(state.data[index].diagnosis ?? '',
                                      style: theme.typo.body1),
                                  const SizedBox(height: 8.0,),
                                  Text(state.data[index].wardInfo ?? '',
                                      style: theme.typo.body1),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: (state as PatientModel).data.length,
                header: Row(children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                '병원',
                                style: theme.typo.subtitle2,
                              )),
                        ],
                      )),
                  Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '환자정보  /  진단명  /  병동-병실-병상',
                        style: theme.typo.subtitle2,
                      ),
                    ),
                  )
                ]),
              ),
            );
          },
        ));
  }
}

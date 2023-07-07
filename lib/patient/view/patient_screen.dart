import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/patient/model/patient_model.dart';
import 'package:unuseful/patient/provider/patient_provider.dart';
import '../../common/component/custom_circular_progress_indicator.dart';
import '../../common/component/main_drawer.dart';
import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
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
    final state = ref.watch(patientNotifierProvider);

    if (state is PatientModelLoading) {
      return renderDefaultLayOut(
        totalCount: null,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CustomCircularProgressIndicator()),
          ],
        ),
      );
    }

    if (state is PatientModelError) {
      return renderDefaultLayOut(
        totalCount: null,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              state.message,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(patientNotifierProvider.notifier).getPatient();
                },
                child: Text('다시 시도')),
          ],
        ),
      );
    }

    final cp = state as PatientModel;
    ref.read(patientTotalProvider.notifier).update((state) => cp.data.length);

    return renderDefaultLayOut(
      totalCount: ref.read(patientTotalProvider),
      widget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          color: PRIMARY_COLOR,
          onRefresh: () async {
            ref.read(patientNotifierProvider.notifier).getPatient();
          },
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
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return ListTile(
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
                  contentPadding: EdgeInsets.only(left: 0.0),
                  title: GestureDetector(
                    onTap: () {
                      state.data[index].blindedPtNm = state.data[index].ptNm;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Text(
                          '${state.data[index].sexTpCd == 'M' ? '🧑🏻' : '👩🏻'}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '${state.data[index].blindedPtNm}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '(${state.data[index].ptNo})',
                          style: TextStyle(color: BODY_TEXT_COLOR),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(state.data[index].diagnosis ?? ''),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            '🏥',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            state.data[index].wardInfo ?? '',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: PRIMARY_COLOR),
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
        ),
      ),
    );
  }

  renderDefaultLayOut({
    required int? totalCount,
    required Widget widget,
  }) {
    return DefaultLayout(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Patient List'),
            SizedBox(
              width: 10,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8),
                child: totalCount != null
                    ? Text(
                        'Total : $totalCount',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )
                    : null)
          ],
        ),
        child: widget);
  }
}

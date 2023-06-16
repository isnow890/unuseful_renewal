import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import '../../common/component/custom_circular_progress_indicator.dart';
import '../model/hit_duty_statistics_model.dart';
import '../provider/hit_duty_statistics_provider.dart';

class HitDutyStatisticsScreen extends ConsumerStatefulWidget {
  const HitDutyStatisticsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HitDutyStatisticsScreen> createState() =>
      _HitDutyStatisticsScreenState();
}

class _HitDutyStatisticsScreenState
    extends ConsumerState<HitDutyStatisticsScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(hitDutyStatisticsFamilyProvider(''));
    if (state is HitDutyStatisticsModelLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(child: CustomCircularProgressIndicator()),
        ],
      );
    }



    if (state is HitDutyStatisticsModelError) {
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
                ref.read(hitDutyStatisticsFamilyProvider('').notifier).getDutyLog();
              },
              child: Text('다시 시도')),
        ],
      );
    }
    final cp = state as HitDutyStatisticsModel;





    return HorizontalDataTable(
      leftHandSideColumnWidth: 100,
      rightHandSideColumnWidth: 1000,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(),
      // isFixedFooter: true,
      footerWidgets: _getTitleWidget(),
      itemCount: cp.data.length,
      rowSeparatorWidget: const Divider(
        color: Colors.black38,
        height: 1.0,
        thickness: 0.0,
      ),
      leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      itemExtent: 55,

      leftSideItemBuilder: (BuildContext context, int index) {
        return Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(cp.data[index].stfNm),
        );
      },
      rightSideItemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[
            Container(
                width: 100,
                height: 52,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(cp.data[index].rank.toString())),
            Container(
              width: 100,
              height: 52,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(cp.data[index].totalCount.toString()),
            ),
            Container(
              width: 100,
              height: 52,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(cp.data[index].totalHour.toString()),
            ),
            Container(
              width: 100,
              height: 52,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(cp.data[index].afternoonCount.toString()),
            ),
            Container(
              width: 100,
              height: 52,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(cp.data[index].afternoonHour.toString()),
            ),
            Container(
              width: 100,
              height: 52,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(cp.data[index].morningHolidayCount.toString()),
            ),
            Container(
              width: 100,
              height: 52,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(cp.data[index].morningHolidayHour.toString()),
            ),
            Container(
              width: 100,
              height: 52,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(cp.data[index].afternoonHolidayCount.toString()),
            ),
            Container(
              width: 100,
              height: 52,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(cp.data[index].afternoonHolidayHour.toString()),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('직원명', 100),
      _getTitleItemWidget('순위', 100),
      _getTitleItemWidget('총 근무 횟수', 100),
      _getTitleItemWidget('총 근무 시간', 100),
      _getTitleItemWidget('주중오후\n근무횟수', 100),
      _getTitleItemWidget('주중오후\n근무시간', 100),
      _getTitleItemWidget('morningHolidayCount', 100),
      _getTitleItemWidget('morningHolidayHour', 100),
      _getTitleItemWidget('afternoonHolidayCount', 100),
      _getTitleItemWidget('afternoonHolidayHour', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

//
// class _HitDutyStatisticsScreenState extends ConsumerState<HitDutyStatisticsScreen> {
//   @override
//   Widget build(BuildContext context, ) {
//     final state = ref.watch(hitDutyStatisticsFamilyProvider(''));
//
//     // final String stfNm;
//     // final String stfNo;
//     // final String stfNum;
//     // final int afternoonCount;
//     // final int afternoonHour;
//     // final int morningHolidayCount;
//     // final int morningHolidayHour;
//     // final int afternoonHolidayCount;
//     // final int afternoonHolidayHour;
//     // final int totalCount;
//     // final int totalHour;
//     // final int rank;
//
//     final cp = state as HitDutyStatisticsModel;
//
//     return SingleChildScrollView(
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//
//         child: DataTable(
//           columns: [
//             DataColumn(label: Text('rank')),
//             DataColumn(label: Text('stfNm')),
//             DataColumn(label: Text('totalCount')),
//             DataColumn(label: Text('totalHour')),
//             // DataColumn(label: Text('stfNo')),
//             // DataColumn(label: Text('stfNum')),
//             DataColumn(label: Text('afternoonCount')),
//             DataColumn(label: Text('afternoonHour')),
//             DataColumn(label: Text('morningHolidayCount')),
//             DataColumn(label: Text('morningHolidayHour')),
//             DataColumn(label: Text('afternoonHolidayCount')),
//             DataColumn(label: Text('afternoonHolidayHour')),
//
//           ],
//           rows: cp.data.map<DataRow>((e) {
//             return DataRow(
//               cells: <DataCell>[
//                 DataCell(Text(e.rank.toString())),
//                 DataCell(Text(e.stfNm)),
//                 DataCell(Text(e.totalCount.toString())),
//                 DataCell(Text(e.totalHour.toString())),
//
//                 // DataCell(Text(e.stfNo)),
//                 // DataCell(Text(e.stfNum)),
//                 DataCell(Text(e.afternoonCount.toString())),
//                 DataCell(Text(e.afternoonHour.toString())),
//                 DataCell(Text(e.morningHolidayCount.toString())),
//                 DataCell(Text(e.morningHolidayHour.toString())),
//                 DataCell(Text(e.afternoonHolidayCount.toString())),
//                 DataCell(Text(e.afternoonHolidayHour.toString())),
//               ],
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
}

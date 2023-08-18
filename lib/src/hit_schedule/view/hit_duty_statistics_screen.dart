import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
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
  final double height = 40;
  HDTRefreshController _hdtRefreshController = HDTRefreshController();




  @override
  Widget build(
    BuildContext context,
  ) {

    final theme = ref.watch(themeServiceProvider);

    final user = ref.watch(userMeProvider.notifier).state as UserModel;

    final state = ref.watch(hitDutyStatisticsFamilyProvider(''));
    if (state is HitDutyStatisticsModelLoading) {
      return const CircularIndicator();
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
                ref
                    .read(hitDutyStatisticsFamilyProvider('').notifier)
                    .getDutyLog();
              },
              child: Text('다시 시도')),
        ],
      );
    }
    final cp = state as HitDutyStatisticsModel;

    return HorizontalDataTable(
      refreshIndicator: ClassicHeader(),
      loadIndicator: ClassicFooter(),
      refreshIndicatorHeight: 60,
      htdRefreshController: _hdtRefreshController,
      enablePullToRefresh: true,
      leftHandSideColumnWidth: 80,
      rightHandSideColumnWidth: 670,
      isFixedHeader: true,

      headerWidgets: _getTitleWidget(),
      onRefresh: _onRefresh,
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
      itemExtent: 45,

      leftSideItemBuilder: (BuildContext context, int index) {
        return Container(
          width: 80,
          height: height,
          alignment: Alignment.center,
          child: Text(
            cp.data[index].stfNm,
            style: TextStyle(
              color: cp.data[index].stfNm == user.stfNm
                  ? Colors.orange
                  : Colors.black,
            ),
          ),
        );
      },
      rightSideItemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[
            Container(
                width: 30,
                height: height,
                alignment: Alignment.center,
                child: Text(
                  cp.data[index].rank.toString(),
                  style: TextStyle(
                    color: cp.data[index].stfNm == user.stfNm
                        ? Colors.orange
                        : Colors.black,
                  ),
                )),
            Container(
              width: 80,
              height: height,
              alignment: Alignment.center,
              child: Text(
                cp.data[index].totalCount.toString(),
                style: TextStyle(
                  color: cp.data[index].stfNm == user.stfNm
                      ? Colors.orange
                      : Colors.black,
                ),
              ),
            ),
            Container(
              width: 80,
              height: height,
              alignment: Alignment.center,
              child: Text(
                cp.data[index].totalHour.toString(),
                style: TextStyle(
                  color: cp.data[index].stfNm == user.stfNm
                      ? Colors.orange
                      : Colors.black,
                ),
              ),
            ),
            Container(
              width: 80,
              height: height,
              alignment: Alignment.center,
              child: Text(
                cp.data[index].afternoonCount.toString(),
                style: TextStyle(
                  color: cp.data[index].stfNm == user.stfNm
                      ? Colors.orange
                      : Colors.black,
                ),
              ),
            ),
            Container(
              width: 80,
              height: height,
              alignment: Alignment.center,
              child: Text(
                cp.data[index].afternoonHour.toString(),
                style: TextStyle(
                  color: cp.data[index].stfNm == user.stfNm
                      ? Colors.orange
                      : Colors.black,
                ),
              ),
            ),
            Container(
              width: 80,
              height: height,
              alignment: Alignment.center,
              child: Text(
                cp.data[index].morningHolidayCount.toString(),
                style: TextStyle(
                  color: cp.data[index].stfNm == user.stfNm
                      ? Colors.orange
                      : Colors.black,
                ),
              ),
            ),
            Container(
              width: 80,
              height: height,
              alignment: Alignment.center,
              child: Text(
                cp.data[index].morningHolidayHour.toString(),
                style: TextStyle(
                  color: cp.data[index].stfNm == user.stfNm
                      ? Colors.orange
                      : Colors.black,
                ),
              ),
            ),
            Container(
              width: 80,
              height: height,
              alignment: Alignment.center,
              child: Text(
                cp.data[index].afternoonHolidayCount.toString(),
                style: TextStyle(
                  color: cp.data[index].stfNm == user.stfNm
                      ? Colors.orange
                      : Colors.black,
                ),
              ),
            ),
            Container(
              width: 80,
              height: height,
              alignment: Alignment.center,
              child: Text(
                cp.data[index].afternoonHolidayHour.toString(),
                style: TextStyle(
                  color: cp.data[index].stfNm == user.stfNm
                      ? Colors.orange
                      : Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('직원명', 80),
      _getTitleItemWidget('순위', 30),
      _getTitleItemWidget('총 횟수', 80),
      _getTitleItemWidget('총 근무 시간', 80),
      _getTitleItemWidget('주중오후\n근무횟수', 80),
      _getTitleItemWidget('주중오후\n근무시간', 80),
      _getTitleItemWidget('휴일오전\n근무횟수', 80),
      _getTitleItemWidget('휴일오전\n근무시간', 80),
      _getTitleItemWidget('휴일오후\n근무횟수', 80),
      _getTitleItemWidget('휴일오후\n근무시간', 80),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    final theme = ref.watch(themeServiceProvider);
    return Container(
      width: width,
      color: theme.color
      .hint,
      height: height,
      alignment: Alignment.center,
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

  void _onRefresh() async {
    //do some network call and get the response

    ref.read(hitDutyStatisticsFamilyProvider('').notifier).getDutyLog();
    _hdtRefreshController.refreshCompleted();
  }
}

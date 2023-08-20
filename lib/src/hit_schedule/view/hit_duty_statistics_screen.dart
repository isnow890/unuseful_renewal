import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:unuseful/colors.dart';
import 'package:unuseful/src/user/provider/gloabl_variable_provider.dart';
import 'package:unuseful/theme/component/circular_indicator.dart';
import 'package:unuseful/theme/foundation/app_theme.dart';
import 'package:unuseful/theme/layout/default_layout.dart';
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
  final double height = 45;
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = ref.watch(themeServiceProvider);

    final global = ref.watch(globalVariableStateProvider);

    final state = ref.watch(hitDutyStatisticsFamilyProvider(''));
    if (state is HitDutyStatisticsModelLoading) {
      return const CircularIndicator();
    }

    final cp = state as HitDutyStatisticsModel;

    return DefaultLayout(
      canRefresh: true
        ,
        onRefreshAndError: ()async{
          ref.read(hitDutyStatisticsFamilyProvider('').notifier).getDutyLog();
        },
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: HorizontalDataTable(
        refreshIndicator: const ClassicHeader(),
        loadIndicator: const ClassicFooter(),
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
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Colors.transparent,
        rightHandSideColBackgroundColor: Colors.transparent,
        itemExtent: 45,
        elevation: 0,
        elevationColor: Colors.black,

        leftSideItemBuilder: (BuildContext context, int index) {
          return

              // _getColumnWidget(width: ,content:,stfNm: ,userNm: );

              _getColumnWidget(
                  content: cp.data[index].stfNm,
                  same: cp.data[index].stfNm == global.stfNm,
                  theme: theme);
        },
        rightSideItemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              _getColumnWidget(
                  width: 30,
                  content: cp.data[index].rank.toString(),
                  same: cp.data[index].stfNm == global.stfNm,
                  theme: theme),
              _getColumnWidget(
                  width: 80,
                  content: cp.data[index].totalCount.toString(),
                  same: cp.data[index].stfNm == global.stfNm,
                  theme: theme),
              _getColumnWidget(
                  width: 80,
                  content: cp.data[index].totalHour.toString(),
                  same: cp.data[index].stfNm == global.stfNm,
                  theme: theme),
              _getColumnWidget(
                  width: 80,
                  content: cp.data[index].afternoonCount.toString(),
                  same: cp.data[index].stfNm == global.stfNm,
                  theme: theme),
              _getColumnWidget(
                  width: 80,
                  content: cp.data[index].afternoonHour.toString(),
                  same: cp.data[index].stfNm == global.stfNm,
                  theme: theme),
              _getColumnWidget(
                  width: 80,
                  content: cp.data[index].morningHolidayCount.toString(),
                  same: cp.data[index].stfNm == global.stfNm,
                  theme: theme),
              _getColumnWidget(
                  width: 80,
                  content: cp.data[index].morningHolidayHour.toString(),
                  same: cp.data[index].stfNm == global.stfNm,
                  theme: theme),
              _getColumnWidget(
                  width: 80,
                  content: cp.data[index].afternoonHolidayCount.toString(),
                  same: cp.data[index].stfNm == global.stfNm,
                  theme: theme),
              _getColumnWidget(
                  width: 80,
                  content: cp.data[index].afternoonHolidayHour.toString(),
                  same: cp.data[index].stfNm == global.stfNm,
                  theme: theme),
            ],
          );
        },
      ),
    ));
  }

  _getColumnWidget(
      {double? width = 80,
      required String content,
      required bool same,
      required AppTheme theme}) {
    return Container(
      width: width,
      color: theme.color.surface,
      height: 40,
      alignment: Alignment.center,
      child: Text(content,
          style: theme.typo.body1
              .copyWith(color: same ? Colors.orange : theme.color.text)
          // TextStyle(
          //   color: same ? ,
          // ),
          ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(
          label: '직원명',
          width: 80,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
          )),
      _getTitleItemWidget(label: '순위', width: 30),
      _getTitleItemWidget(label: '총 횟수', width: 80),
      _getTitleItemWidget(label: '총 근무 시간', width: 80),
      _getTitleItemWidget(label: '주중오후\n근무횟수', width: 80),
      _getTitleItemWidget(label: '주중오후\n근무시간', width: 80),
      _getTitleItemWidget(label: '휴일오전\n근무횟수', width: 80),
      _getTitleItemWidget(label: '휴일오전\n근무시간', width: 80),
      _getTitleItemWidget(label: '휴일오후\n근무횟수', width: 80),
      _getTitleItemWidget(
          label: '휴일오후\n근무시간',
          width: 80,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
          )),
    ];
  }

  // BorderRadius.only(topLeft: Radius.circular(40.0),)

  Widget _getTitleItemWidget(
      {required String label,
      required double width,
      BorderRadius? borderRadius = null}) {
    final theme = ref.watch(themeServiceProvider);
    return Container(
      decoration:
          BoxDecoration(borderRadius: borderRadius, color: theme.color.hintContainer),
      width: width,
      height: height,
      alignment: Alignment.center,
      child: Text(label, style: theme.typo.body1),
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

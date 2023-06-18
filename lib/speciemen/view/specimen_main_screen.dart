import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/common/component/custom_calendar.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/common/layout/default_layout.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../hit_schedule/provider/hit_schedule_selected_day_provider.dart';

class SpecimenMainScreen extends ConsumerStatefulWidget {
  static String get routeName => 'speciemen';

  const SpecimenMainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SpecimenMainScreen> createState() => _SpecimenMainScreenState();
}

class _SpecimenMainScreenState extends ConsumerState<SpecimenMainScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final selectedDay = ref.watch(hitScheduleSelectedDayProvider);

    final TextStyle segmentTextStyle = TextStyle(
      fontSize: 12.0,
    );

    final defaultBoxDeco = BoxDecoration(
      color: Colors.grey[200],
      //테두리 깍기
      borderRadius: BorderRadius.circular(6.0),
    );

    final TextStyle chipTextStyle = TextStyle(fontSize: 12.0);
    return DefaultLayout(
      title: Text('specimen'),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
              //모서리를 둥글게 하기 위해 사용
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 6.0, //그림자 깊이
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  _renderTitleTextHelper('hospital'),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialSegmentedControl(
                          children: {
                            0: Text('전체', style: segmentTextStyle),
                            1: Text(
                              '서울',
                              style: segmentTextStyle,
                            ),
                            2: Text(
                              '목동',
                              style: segmentTextStyle,
                            )
                          },
                          horizontalPadding: const EdgeInsets.all(0),
                          selectionIndex: 0,
                          borderColor: Colors.grey,
                          selectedColor: PRIMARY_COLOR,
                          unselectedColor: Colors.white,
                          selectedTextStyle: TextStyle(color: Colors.white),
                          unselectedTextStyle: TextStyle(color: PRIMARY_COLOR),
                          borderWidth: 0.7,
                          borderRadius: 6.0,
                          verticalOffset: 8.0,
                          onSegmentTapped: (index) {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _renderTitleTextHelper('speciemnt no / patient no'),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialSegmentedControl(
                          children: {
                            0: Text('검체번호', style: segmentTextStyle),
                            1: Text(
                              '등록번호',
                              style: segmentTextStyle,
                            )
                          },
                          horizontalPadding: const EdgeInsets.all(0),
                          selectionIndex: 0,
                          borderColor: Colors.grey,
                          selectedColor: PRIMARY_COLOR,
                          unselectedColor: Colors.white,
                          selectedTextStyle: TextStyle(color: Colors.white),
                          unselectedTextStyle: TextStyle(color: PRIMARY_COLOR),
                          borderWidth: 0.7,
                          borderRadius: 6.0,
                          verticalOffset: 8.0,
                          onSegmentTapped: (index) {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _renderTitleTextHelper('speciemnt no / patient no input'),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          child: CustomTextFormField(
                            contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 0),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _renderTitleTextHelper('choose date'),
                  ExpansionPanelList(
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '2023년 6월 1일',
                                  style: TextStyle(),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '2023년 6월 1일',
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          );
                        },
                        body: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Chip(
                                    label: Text(
                                      '당일',
                                      style: chipTextStyle,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Chip(
                                    label: Text(
                                      '1년',
                                      style: chipTextStyle,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Chip(
                                    label: Text(
                                      '6개월',
                                      style: chipTextStyle,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Chip(
                                    label: Text(
                                      '3개월',
                                      style: chipTextStyle,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Chip(
                                    label: Text(
                                      '1개월',
                                      style: chipTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 260,
                              child: CustomCalendar(
                                shouldFillViewport: true,
                                calendarStyle: CalendarStyle(
                                  outsideDaysVisible: false,
                                  isTodayHighlighted: false,
                                ),
                                onPageChanged: null,
                                events: null,
                                selectedDay: selectedDay,
                                focusedDay: selectedDay,
                                onDaySelected: null,
                                calendarBuilders: null,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        isExpanded: _isExpanded,
                      ),
                    ],
                    expansionCallback: (int index, bool isExpanded) {
                      print('열려라');
                      _isExpanded = !isExpanded;

                      setState(() {
                        print(isExpanded);
                        print(!isExpanded);
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          // onPressed: state is UserModelLoading
                          //     ? null
                          //     : () async {
                          //         validateRequiredItem(
                          //             radioTile, stfNo, password);
                          //
                          //         // ref.read(userMeProvider.notifier).login(username: username, password: password);
                          //       },
                          child: Text('조회'),
                          style: ElevatedButton.styleFrom(
                            primary: PRIMARY_COLOR,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _renderTitleTextHelper(title) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _CalendarBuilders extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final Decoration decoration;
  final Color? textColor;

  const _CalendarBuilders(
      {Key? key,
      required this.day,
      required this.focusedDay,
      required this.decoration,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Container(
        padding: EdgeInsets.only(top: 1, bottom: 1),
        width: MediaQuery.of(context).size.width,
        decoration: decoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              day.day.toString(),
              style: TextStyle(fontSize: 13, color: textColor ?? Colors.black),
            ),
            Expanded(child: Text("")),
            // Text(moneyString,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 12, color: nowIndexColor[900]),),
          ],
        ),
      ),
    );
  }
}

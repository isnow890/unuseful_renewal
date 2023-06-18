import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/common/component/custom_calendar.dart';
import 'package:unuseful/common/const/colors.dart';
import 'package:unuseful/common/layout/default_layout.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../hit_schedule/provider/hit_schedule_selected_day_provider.dart';

class SpecimenMainScreen extends ConsumerStatefulWidget {
  static String get routeName => 'specimen';

  const SpecimenMainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SpecimenMainScreen> createState() => _SpecimenMainScreenState();
}

class _SpecimenMainScreenState extends ConsumerState<SpecimenMainScreen> {
  bool _isExpanded = false;
  DateTime? rangeStart = new DateTime(
      DateTime.now().year, DateTime.now().month - 6, DateTime.now().day);
  DateTime? rangeEnd = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // DateTime? selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  int hspType = 0;
  int searchType = 0;
  int textFormFieldMaxLength = 11;

  String? textFormFieldText;

  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;

  final textFormFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textFormFieldController.addListener(_getTextFormFieldText);
  }

  void _getTextFormFieldText() {
    textFormFieldText = textFormFieldController.text;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textFormFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle segmentTextStyle = TextStyle(
      fontSize: 12.0,
    );

    final defaultBoxDeco = BoxDecoration(
      color: Colors.grey[200],
      //테두리 깍기

      borderRadius: BorderRadius.circular(6.0),
    );

    return DefaultLayout(
      title: Text('specimen'),
      child: SingleChildScrollView(
        //드래그 하면 키보드 집어넣기.
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

        child: Padding(
          padding: const EdgeInsets.all(6.0),
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
                  _renderHosiptalSegmentHelper(segmentTextStyle),
                  const Divider(
                    height: 30,
                  ),
                  _renderTitleTextHelper('speciemnt no / patient no'),
                  _renderSpecimenNoOrPatientNoSegmentHelper(segmentTextStyle),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          child: CustomTextFormField(
                            isSuffixDeleteButtonEnabled :true,
                            controller: textFormFieldController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(
                                  textFormFieldMaxLength),
                            ],
                            contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 0),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                  ),
                  _renderTitleTextHelper('choose date'),
                  returnExpansionPanelList(),
                  const SizedBox(
                    height: 10,
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

  returnExpansionPanelList() {
    final TextStyle chipTextStyle = TextStyle(fontSize: 12.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.all(0),
        children: [
          ExpansionPanel(
            backgroundColor: searchType == 0 ? Colors.grey[400] : Colors.white,
            canTapOnHeader: true,
            headerBuilder: (context, isExpanded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      rangeStart == null
                          ? ''
                          : DateFormat('yyyy년 MM월 dd일').format(rangeStart!),
                      style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500,),
                    ),
                  ),
                  Text(
                    '-',
                    style: TextStyle(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      DateFormat('yyyy년 MM월 dd일')
                          .format(rangeEnd ?? rangeStart!),
                      style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500,),
                    ),
                  ),
                ],
              );
            },
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _setDateRange(0),
                        child: Chip(
                          label: Text(
                            '당일',
                            style: chipTextStyle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => _setDateRange(12),
                        child: Chip(
                          label: Text(
                            '1년',
                            style: chipTextStyle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => _setDateRange(6),
                        child: Chip(
                          label: Text(
                            '6개월',
                            style: chipTextStyle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => _setDateRange(3),
                        child: Chip(
                          label: Text(
                            '3개월',
                            style: chipTextStyle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => _setDateRange(1),
                        child: Chip(
                          label: Text(
                            '1개월',
                            style: chipTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _rendercustomCalendarHelper(),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            isExpanded: searchType == 0 ? false : _isExpanded,
          ),
        ],
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _isExpanded = searchType == 0 ? true : !isExpanded;
          });
        },
      ),
    );
  }

  _setDateRange(int minusMonth) {
    setState(() {
      rangeStart = DateTime(DateTime.now().year,
          DateTime.now().month - minusMonth, DateTime.now().day);
      rangeEnd = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      focusedDay = DateTime(DateTime.now().year,
          DateTime.now().month - minusMonth, DateTime.now().day);

      rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  _rendercustomCalendarHelper() {
    // final defaultBoxDeco = BoxDecoration(
    //   color: Colors.grey[200],
    //   //테두리 깍기
    //   borderRadius: BorderRadius.circular(6.0),
    // );
    return Container(
      height: 280,
      child: CustomCalendar(
        rangeStart: rangeStart,
        rangeEnd: rangeEnd,
        rangeSelected: rangeSelectionMode,
        shouldFillViewport: true,
        calendarStyle: CalendarStyle(
          outsideDaysVisible: true,
          isTodayHighlighted: false,

          rangeHighlightColor: Colors.orange[100]!,
          weekendTextStyle: TextStyle(color: Colors.red),
          withinRangeTextStyle: TextStyle(color: PRIMARY_COLOR),
          rangeStartDecoration: BoxDecoration(
            color: PRIMARY_COLOR,
            shape: BoxShape.circle,
          ),
          rangeEndDecoration: BoxDecoration(
            color: PRIMARY_COLOR,
            shape: BoxShape.circle,
          ),
          // final defaultBoxDeco = BoxDecoration(
          //   color: Colors.grey[200],
          //   //테두리 깍기
          //   borderRadius: BorderRadius.circular(6.0),
          // );

          // defaultDecoration: defaultBoxDeco,
        ),
        onPageChanged: null,
        events: null,
        // selectedDay: selectedDay,
        focusedDay: focusedDay,
        onDaySelected: (_selectedDay, _focusedDay) {
          print('clicked');

          // if (!isSameDay(_selectedDay, selectedDay)) {
          //   setState(() {
          //     selectedDay = _selectedDay;
          //     focusedDay = _focusedDay;
          //     rangeStart = null; // Important to clean those
          //     rangeEnd = null;
          //     rangeSelectionMode = RangeSelectionMode.toggledOff;
          //   });
          // }
        },
        onRangeSelected: (_start, _end, _focusedDay) {
          setState(() {
            // selectedDay = null;
            focusedDay = _focusedDay;
            rangeStart = _start;
            rangeEnd = _end;
            rangeSelectionMode = RangeSelectionMode.toggledOn;
          });
        },
      ),
    );
  }

  _renderSpecimenNoOrPatientNoSegmentHelper(segmentTextStyle) {
    return Row(
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
            selectionIndex: searchType,
            borderColor: Colors.grey,
            selectedColor: PRIMARY_COLOR,
            unselectedColor: Colors.white,
            selectedTextStyle: TextStyle(color: Colors.white),
            unselectedTextStyle: TextStyle(color: PRIMARY_COLOR),
            borderWidth: 0.7,
            borderRadius: 6.0,
            verticalOffset: 8.0,
            onSegmentTapped: (index) {
              setState(() {
                textFormFieldController.text = '';
                print('실행됨');
                textFormFieldMaxLength = index == 0 ? 11 : 8;
                searchType = index;
              });
            },
          ),
        ),
      ],
    );
  }

  _renderHosiptalSegmentHelper(segmentTextStyle) {
    return Row(
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
            selectionIndex: hspType,
            borderColor: Colors.grey,
            selectedColor: PRIMARY_COLOR,
            unselectedColor: Colors.white,
            selectedTextStyle: TextStyle(color: Colors.white),
            unselectedTextStyle: TextStyle(color: PRIMARY_COLOR),
            borderWidth: 0.7,
            borderRadius: 6.0,
            verticalOffset: 8.0,
            onSegmentTapped: (index) {
              setState(() {
                hspType = index;
              });
            },
          ),
        ),
      ],
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

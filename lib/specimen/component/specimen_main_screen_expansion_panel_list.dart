import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/component/custom_calendar.dart';
import '../../common/const/colors.dart';

class SpecimenMainScreenExpansionPanelList extends StatefulWidget {
  DateTime? rangeStart;
  DateTime? rangeEnd;

  SpecimenMainScreenExpansionPanelList(
      {Key? key,
      required this.rangeEnd,
      required this.rangeStart,
      required this.searchType})
      : super(key: key);

  final int searchType;

  @override
  State<SpecimenMainScreenExpansionPanelList> createState() =>
      _SpecimenMainScreenExpansionPanelListState();
}

class _SpecimenMainScreenExpansionPanelListState
    extends State<SpecimenMainScreenExpansionPanelList> {
  bool _isExpanded = true;
  DateTime focusedDay = DateTime.now();

  TextStyle ts = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
  );

  _SpecimenMainScreenExpansionPanelListState();

  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;

  @override
  Widget build(BuildContext context) {
    final TextStyle chipTextStyle = TextStyle(fontSize: 12.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.all(0),
        children: [
          ExpansionPanel(
            backgroundColor:
                widget.searchType == 1 ? Colors.grey[400] : Colors.white,
            canTapOnHeader: true,
            headerBuilder: (context, isExpanded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.rangeStart == null
                          ? ''
                          : DateFormat('yyyy년 MM월 dd일')
                              .format(widget.rangeStart!),
                      style: ts,
                    ),
                  ),
                  Text(
                    '~',
                    style: ts,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      DateFormat('yyyy년 MM월 dd일')
                          .format(widget.rangeEnd ?? widget.rangeStart!),
                      style: ts,
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
            isExpanded: widget.searchType == 1 ? false : _isExpanded,
          ),
        ],
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _isExpanded = widget.searchType == 1 ? true : !isExpanded;
          });
        },
      ),
    );
  }

  _setDateRange(int minusMonth) {
    setState(() {
      widget.rangeStart = DateTime(DateTime.now().year,
          DateTime.now().month - minusMonth, DateTime.now().day);
      widget.rangeEnd = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      focusedDay = DateTime(DateTime.now().year,
          DateTime.now().month - minusMonth, DateTime.now().day);

      rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  _rendercustomCalendarHelper() {
    return Container(
      height: 280,
      child: CustomCalendar(
        rangeStart: widget.rangeStart,
        rangeEnd: widget.rangeEnd,
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
            widget.rangeStart = _start;
            widget.rangeEnd = _end;
            rangeSelectionMode = RangeSelectionMode.toggledOn;
          });
        },
      ),
    );
  }
}

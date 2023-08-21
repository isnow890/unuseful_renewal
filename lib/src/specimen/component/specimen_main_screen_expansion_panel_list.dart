import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/theme/component/custom_calendar.dart';
import 'package:unuseful/theme/component/custom_choice_chip.dart';
import 'package:unuseful/theme/component/custom_expansion_tile.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';

import '../../../colors.dart';
import '../../../theme/component/custom_chip.dart';

class SpecimenMainScreenExpansionPanelList extends ConsumerStatefulWidget {
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
  ConsumerState<SpecimenMainScreenExpansionPanelList> createState() =>
      _SpecimenMainScreenExpansionPanelListState();
}

class _SpecimenMainScreenExpansionPanelListState
    extends ConsumerState<SpecimenMainScreenExpansionPanelList> {
  bool _isExpanded = true;
  DateTime focusedDay = DateTime.now();

  _SpecimenMainScreenExpansionPanelListState();

  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;

  _termSelectionHelper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomChip(
          onTap: () => _setDateRange(0),
          title: '당일',
          paddingHorizontal: 0,
        ),
        CustomChip(
          onTap: () => _setDateRange(12),
          title: '1년',
          paddingHorizontal: 0,
        ),
        CustomChip(
          onTap: () => _setDateRange(6),
          title: '6개월',
          paddingHorizontal: 0,
        ),
        CustomChip(
          onTap: () => _setDateRange(3),
          title: '3개월',
          paddingHorizontal: 0,
        ),
        CustomChip(
          onTap: () => _setDateRange(1),
          title: '1개월',
          paddingHorizontal: 0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);

    return Column(
      children: [
        _termSelectionHelper(),
        const SizedBox(
          height: 5,
        ),
        CustomExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.rangeStart == null
                      ? ''
                      : DateFormat('yyyy년 MM월 dd일').format(widget.rangeStart!),
                  style: theme.typo.body1,
                ),
              ),
              Text(
                '~',
                style: theme.typo.body1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  DateFormat('yyyy년 MM월 dd일')
                      .format(widget.rangeEnd ?? widget.rangeStart!),
                  style: theme.typo.body1,
                ),
              ),
            ],
          ),
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: [
            _rendercustomCalendarHelper(),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ],
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

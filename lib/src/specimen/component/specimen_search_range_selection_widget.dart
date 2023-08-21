import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unuseful/theme/component/calendar/custom_calendar.dart';
import 'package:unuseful/theme/component/custom_expansion_tile.dart';
import 'package:unuseful/theme/foundation/app_theme.dart';
import 'package:unuseful/theme/provider/theme_provider.dart';
import 'package:unuseful/theme/res/layout.dart';

import '../../../theme/component/chip/custom_chip.dart';

class SpecimenSearchRangeSelectionWidget extends ConsumerStatefulWidget {
  DateTime? rangeStart;
  DateTime? rangeEnd;

  final void Function(DateTime? start, DateTime? end, DateTime focusedDay)
      onRangeSelected;

  SpecimenSearchRangeSelectionWidget(
      {Key? key,
      required this.onRangeSelected,
      required this.rangeEnd,
      required this.rangeStart,
      required this.searchType})
      : super(key: key);

  final int searchType;

  @override
  ConsumerState<SpecimenSearchRangeSelectionWidget> createState() =>
      _SpecimenMainScreenExpansionPanelListState();
}

class _SpecimenMainScreenExpansionPanelListState
    extends ConsumerState<SpecimenSearchRangeSelectionWidget> {
  bool _isExpanded = true;
  DateTime focusedDay = DateTime.now();

  _SpecimenMainScreenExpansionPanelListState();

  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;

  _termSelectionHelper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            _renderCustomCalendarHelper(theme),
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
      print('taped');
      widget.rangeStart = DateTime(DateTime.now().year,
          DateTime.now().month - minusMonth, DateTime.now().day);
      widget.rangeEnd = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      focusedDay = DateTime(DateTime.now().year,
          DateTime.now().month - minusMonth, DateTime.now().day);

      rangeSelectionMode = RangeSelectionMode.toggledOn;

      widget.onRangeSelected(widget.rangeStart, widget.rangeEnd, DateTime.now());
    });
  }

  _renderCustomCalendarHelper(AppTheme theme) {
    return SizedBox(
      height: 280,
      child: CustomCalendar(
        daySelect: true,
        rangeStart: widget.rangeStart,
        rangeEnd: widget.rangeEnd,
        rangeSelected: rangeSelectionMode,
        shouldFillViewport: true,

        calendarStyle: CalendarStyle(
          rangeHighlightColor: theme.color.hint,
          outsideDaysVisible: true,
          isTodayHighlighted: false,
          withinRangeTextStyle: TextStyle(
            fontSize: context.layout(15.0, tablet: 18, desktop: 18),
            color: theme.color.text,
          ),
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

        onRangeSelected: widget.onRangeSelected,

        // onRangeSelected: (_start, _end, _focusedDay) {
        //   setState(() {
        //     // selectedDay = null;
        //     focusedDay = _focusedDay;
        //     widget.rangeStart = _start;
        //     widget.rangeEnd = _end;
        //     rangeSelectionMode = RangeSelectionMode.toggledOn;
        //   });
        // },
      ),
    );
  }
}

part of table_calendar;

/// Callback exposing currently selected day.
typedef void OnDaySelected(DateTime day, List events);

/// Callback exposing currently visible days (first and last of them), as well as current `CalendarFormat`.
typedef void OnVisibleDaysChanged(DateTime first, DateTime last);

/// Callback exposing initially visible days (first and last of them), as well as initial `CalendarFormat`.
typedef void OnCalendarCreated(DateTime first, DateTime last);

/// Signature for reacting to header gestures. Exposes current month and year as a `DateTime` object.
typedef void HeaderGestureCallback(DateTime focusedDay);

/// Builder signature for any text that can be localized and formatted with `DateFormat`.
typedef String TextBuilder(DateTime date, dynamic locale);

/// Signature for enabling days.
typedef bool EnabledDayPredicate(DateTime day);

/// Highly customizable, feature-packed Flutter Calendar with gestures, animations and multiple formats.
class TableCalendar extends StatefulWidget {
  /// Controller required for `TableCalendar`.
  /// Use it to update `events`, `holidays`, etc.
  final CalendarController calendarController;

  final dynamic locale;

  final Map<DateTime, List> events;

  /// `Map` of holidays.
  /// This property allows you to provide custom holiday rules.
  final Map<DateTime, List> holidays;

  /// Called whenever any day gets tapped.
  final OnDaySelected onDaySelected;

  /// Called whenever any day gets long pressed.
  final OnDaySelected onDayLongPressed;

  /// Called whenever any unavailable day gets tapped.
  /// Replaces `onDaySelected` for those days.
  final VoidCallback onUnavailableDaySelected;

  /// Called whenever any unavailable day gets long pressed.
  /// Replaces `onDaySelected` for those days.
  final VoidCallback onUnavailableDayLongPressed;

  /// Called whenever header gets tapped.
  final HeaderGestureCallback onHeaderTapped;

  /// Called whenever header gets long pressed.
  final HeaderGestureCallback onHeaderLongPressed;

  /// Called whenever the range of visible days changes.
  final OnVisibleDaysChanged onVisibleDaysChanged;

  /// Called once when the CalendarController gets initialized.
  final OnCalendarCreated onCalendarCreated;

  /// Initially selected DateTime. Usually it will be `DateTime.now()`.
  final DateTime initialSelectedDay;

  /// The first day of `TableCalendar`.
  /// Days before it will use `unavailableStyle` and run `onUnavailableDaySelected` callback.
  final DateTime startDay;

  /// The last day of `TableCalendar`.
  /// Days after it will use `unavailableStyle` and run `onUnavailableDaySelected` callback.
  final DateTime endDay;

  /// List of days treated as weekend days.
  /// Use built-in `DateTime` weekday constants (e.g. `DateTime.monday`) instead of `int` literals (e.q. `1`).
  final List<int> weekendDays;

  /// Used to show/hide Header.
  final bool headerVisible;

  /// Function deciding whether given day should be enabled or not.
  /// If `false` is returned, this day will be unavailable.
  final EnabledDayPredicate enabledDayPredicate;

  /// Used for setting the height of `TableCalendar`'s rows.
  final double rowHeight;

  /// `HitTestBehavior` for every day cell inside `TableCalendar`.
  final HitTestBehavior dayHitTestBehavior;

  /// Configuration for vertical Swipe detector.
  final SimpleSwipeConfig simpleSwipeConfig;

  /// Style for `TableCalendar`'s content.
  final CalendarStyle calendarStyle;

  /// Style for DaysOfWeek displayed between `TableCalendar`'s Header and content.
  final DaysOfWeekStyle daysOfWeekStyle;

  /// Style for `TableCalendar`'s Header.
  final HeaderStyle headerStyle;

  /// Set of Builders for `TableCalendar` to work with.
  final CalendarBuilders builders;

  final Client client;

  TableCalendar({
    Key key,
    @required this.calendarController,
    @required this.client,
    this.locale,
    this.events = const {},
    this.holidays = const {},
    this.onDaySelected,
    this.onDayLongPressed,
    this.onUnavailableDaySelected,
    this.onUnavailableDayLongPressed,
    this.onHeaderTapped,
    this.onHeaderLongPressed,
    this.onVisibleDaysChanged,
    this.onCalendarCreated,
    this.initialSelectedDay,
    this.startDay,
    this.endDay,
    this.weekendDays = const [DateTime.saturday, DateTime.sunday],
    this.headerVisible = true,
    this.enabledDayPredicate,
    this.rowHeight,
    this.dayHitTestBehavior = HitTestBehavior.deferToChild,
    this.simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
    this.calendarStyle = const CalendarStyle(),
    this.daysOfWeekStyle = const DaysOfWeekStyle(),
    this.headerStyle = const HeaderStyle(),
    this.builders = const CalendarBuilders(),
  })  : assert(calendarController != null),
        assert(weekendDays != null),
        assert(weekendDays.isNotEmpty
            ? weekendDays.every(
                (day) => day >= DateTime.monday && day <= DateTime.sunday)
            : true),
        super(key: key);

  @override
  _TableCalendarState createState() => _TableCalendarState();
}

class _TableCalendarState extends State<TableCalendar>
    with TickerProviderStateMixin {
  bool collapsed = false;
  double opacity = 1.0;
  AnimationController animationController;
  Animation<double> calendarHeightAnimation;
  Animation<double> calendarOpacityAnimation;
  GlobalKey calendarKey;

  @override
  void initState() {
    super.initState();

    calendarKey = GlobalKey();

    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    widget.calendarController._init(
      events: widget.events,
      holidays: widget.holidays,
      initialDay: widget.initialSelectedDay,
      selectedDayCallback: _selectedDayCallback,
      onVisibleDaysChanged: widget.onVisibleDaysChanged,
      onCalendarCreated: widget.onCalendarCreated,
      includeInvisibleDays: widget.calendarStyle.outsideDaysVisible,
    );

    calendarOpacityAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1, curve: Curves.ease),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    if (calendarHeightAnimation == null) {
      setState(() {
        final RenderBox renderBox = calendarKey.currentContext.findRenderObject();
        calendarHeightAnimation = calendarHeightAnimation = Tween<double>(
          begin: renderBox.size.height,
          end: 18.0,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Interval(0, 1, curve: Curves.ease),
        ));
      });
    }
  }

  @override
  void didUpdateWidget(TableCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.events != widget.events) {
      widget.calendarController._events = widget.events;
    }

    if (oldWidget.holidays != widget.holidays) {
      widget.calendarController._holidays = widget.holidays;
    }
  }

  void _selectedDayCallback(DateTime day) {
    if (widget.onDaySelected != null) {
      widget.onDaySelected(day,
          widget.calendarController.visibleEvents[_getEventKey(day)] ?? []);
    }
  }

  void _selectPrevious() {
    setState(() {
      widget.calendarController._selectPrevious();
    });
//    widget.doctorEvents
//        .setActiveMonth(widget.calendarController.visibleDays[15]);
  }

  void _selectNext() {
    setState(() {
      widget.calendarController._selectNext();
    });
//    widget.doctorEvents
//        .setActiveMonth(widget.calendarController.visibleDays[15]);
  }

  void _selectDay(DateTime day) {
    setState(() {
      widget.calendarController.setSelectedDay(day, isProgrammatic: false);
      _selectedDayCallback(day);
    });
  }

  void _onDayLongPressed(DateTime day) {
    if (widget.onDayLongPressed != null) {
      widget.onDayLongPressed(
        day,
        widget.calendarController.visibleEvents[_getEventKey(day)] ?? [],
      );
    }
  }

  void _onHorizontalSwipe(DismissDirection direction) {
    if (direction == DismissDirection.startToEnd) {
      _selectPrevious();
    } else {
      _selectNext();
    }
  }

  void _onUnavailableDaySelected() {
    if (widget.onUnavailableDaySelected != null) {
      widget.onUnavailableDaySelected();
    }
  }

  void _onUnavailableDayLongPressed() {
    if (widget.onUnavailableDayLongPressed != null) {
      widget.onUnavailableDayLongPressed();
    }
  }

  void _onHeaderTapped() {
    if (widget.onHeaderTapped != null) {
      widget.onHeaderTapped(widget.calendarController.focusedDay);
    }
  }

  void _onHeaderLongPressed() {
    if (widget.onHeaderLongPressed != null) {
      widget.onHeaderLongPressed(widget.calendarController.focusedDay);
    }
  }

  bool _isDayUnavailable(DateTime day) {
    return (widget.startDay != null &&
            day.isBefore(
                widget.calendarController._normalizeDate(widget.startDay))) ||
        (widget.endDay != null &&
            day.isAfter(
                widget.calendarController._normalizeDate(widget.endDay))) ||
        (!_isDayEnabled(day));
  }

  bool _isDayEnabled(DateTime day) {
    return widget.enabledDayPredicate == null
        ? true
        : widget.enabledDayPredicate(day);
  }

  DateTime _getEventKey(DateTime day) {
    return widget.calendarController._getEventKey(day);
  }

  DateTime _getHolidayKey(DateTime day) {
    return widget.calendarController._getHolidayKey(day);
  }

  Future<void> _toggleCalendar() async {
    setState(() {
      collapsed = !collapsed;
    });
    try {
      if (!collapsed) {
        print('Opening calendar');
        await animationController.forward();
      } else {
        print('Collapsing calendar');
        await animationController.reverse();
      }
    } on TickerCanceled {}
  }

//  void _toggleCalendar() {
//    setState(() {
//      collapsed = !collapsed;
//    });
//    if (collapsed) {
//      animationController.forward();
//    } else {
//      animationController.reverse();
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return child;
      },
      child: Container(
        height: calendarHeightAnimation == null
            ? null
            : calendarHeightAnimation.value,
        margin: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 2.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (_, constraints) => Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Opacity(
                opacity: calendarHeightAnimation == null
                    ? 1.0
                    : calendarOpacityAnimation.value,
                child: Column(
                  key: calendarKey,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (widget.headerVisible) _buildHeader(),
//                Padding(
//                  padding: widget.calendarStyle.contentPadding,
//                  child:
                    _buildCalendarContent(),
//                ),
                  ],
                ),
              ),
              Positioned(
                bottom: -9,
                left: constraints.maxWidth / 2 - 25,
                child: GestureDetector(
                  onTap: () {
                    print('Calendar pin tapped');
                    _toggleCalendar();
                  },
                  child: const Pin(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final children = [
      _CustomIconButton(
        icon: widget.headerStyle.leftChevronIcon,
        onTap: _selectPrevious,
        margin: widget.headerStyle.leftChevronMargin,
        padding: widget.headerStyle.leftChevronPadding,
      ),
      Expanded(
        child: GestureDetector(
          onTap: _onHeaderTapped,
          onLongPress: _onHeaderLongPressed,
          child: Text(
            widget.headerStyle.titleTextBuilder != null
                ? widget.headerStyle.titleTextBuilder(
                    widget.calendarController.focusedDay, widget.locale)
                : DateFormat.yMMMM(widget.locale)
                    .format(widget.calendarController.focusedDay),
            style: widget.headerStyle.titleTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      _CustomIconButton(
        icon: widget.headerStyle.rightChevronIcon,
        onTap: _selectNext,
        margin: widget.headerStyle.rightChevronMargin,
        padding: widget.headerStyle.rightChevronPadding,
      ),
    ];

    return Container(
      decoration: widget.headerStyle.decoration,
      margin: widget.headerStyle.headerMargin,
      padding: widget.headerStyle.headerPadding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    );
  }

  Widget _buildCalendarContent() {
    return AnimatedSize(
      duration: Duration(milliseconds: 220),
      curve: Curves.fastOutSlowIn,
      alignment: Alignment(0, -1),
      vsync: this,
      child: _buildWrapper(),
    );
  }

  Widget _buildWrapper({Key key}) {
    Widget wrappedChild = _buildTable();

    wrappedChild = _buildHorizontalSwipeWrapper(
      child: wrappedChild,
    );

    return Container(
      key: key,
      child: wrappedChild,
    );
  }

  Widget _buildHorizontalSwipeWrapper({Widget child}) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.decelerate,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(widget.calendarController._dx, 0),
            end: Offset(0, 0),
          ).animate(animation),
          child: child,
        );
      },
      layoutBuilder: (currentChild, _) => currentChild,
      child: Dismissible(
        key: ValueKey(widget.calendarController._pageId),
        resizeDuration: null,
        onDismissed: _onHorizontalSwipe,
        direction: DismissDirection.horizontal,
        child: child,
      ),
    );
  }

  Widget _buildTable() {
    final daysInWeek = 7;
    final children = <TableRow>[
      if (widget.calendarStyle.renderDaysOfWeek) _buildDaysOfWeek(),
    ];

    int x = 0;
    while (x < widget.calendarController._visibleDays.value.length) {
      children.add(_buildTableRow(widget.calendarController._visibleDays.value
          .skip(x)
          .take(daysInWeek)
          .toList()));
      x += daysInWeek;
    }

    return Table(
      defaultColumnWidth: FractionColumnWidth(1.0 / daysInWeek),
      children: children,
    );
  }

  TableRow _buildDaysOfWeek() {
    return TableRow(
      children:
          widget.calendarController._visibleDays.value.take(7).map((date) {
        final weekdayString = widget.daysOfWeekStyle.dowTextBuilder != null
            ? widget.daysOfWeekStyle.dowTextBuilder(date, widget.locale)
            : DateFormat.E(widget.locale).format(date);
        final isWeekend =
            widget.calendarController._isWeekend(date, widget.weekendDays);

        if (isWeekend && widget.builders.dowWeekendBuilder != null) {
          return widget.builders.dowWeekendBuilder(context, weekdayString);
        }
        if (widget.builders.dowWeekdayBuilder != null) {
          return widget.builders.dowWeekdayBuilder(context, weekdayString);
        }
        return LayoutBuilder(
          builder: (context, constraints) => ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: widget.rowHeight ?? constraints.maxWidth,
              minHeight: widget.rowHeight ?? constraints.maxWidth,
            ),
            child: Center(
              child: Text(
                weekdayString,
                style: isWeekend
                    ? widget.daysOfWeekStyle.weekendStyle
                    : widget.daysOfWeekStyle.weekdayStyle,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  TableRow _buildTableRow(List<DateTime> days) {
    return TableRow(
        children: days.map((date) => _buildTableCell(date)).toList());
  }

  Widget _buildTableCell(DateTime date) {
    return LayoutBuilder(
      builder: (_, constraints) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.rowHeight ?? constraints.maxWidth,
          minHeight: widget.rowHeight ?? constraints.maxWidth,
        ),
        child: _buildCell(date),
      ),
    );
  }

  Widget _buildCell(DateTime date) {
    if (!widget.calendarStyle.outsideDaysVisible &&
        widget.calendarController._isExtraDay(date)) {
      return Container();
    }

    Widget content = _buildCellContent(date);

    final eventKey = _getEventKey(date);
    final holidayKey = _getHolidayKey(date);
    final key = eventKey ?? holidayKey;

    if (key != null) {
      final events = eventKey != null
          ? widget.calendarController.visibleEvents[eventKey]
          : [];
      final holidays = holidayKey != null
          ? widget.calendarController.visibleHolidays[holidayKey]
          : [];
    }

    return GestureDetector(
      behavior: widget.dayHitTestBehavior,
      onTap: () => _isDayUnavailable(date)
          ? _onUnavailableDaySelected()
          : _selectDay(date),
      onLongPress: () => _isDayUnavailable(date)
          ? _onUnavailableDayLongPressed()
          : _onDayLongPressed(date),
      child: content,
    );
  }

  Widget _buildCellContent(DateTime date) {
    final eventKey = _getEventKey(date);

    final tIsUnavailable = _isDayUnavailable(date);
    final tIsSelected = widget.calendarController.isSelected(date);
    final tIsToday = widget.calendarController.isToday(date);
    final tIsOutside = widget.calendarController._isExtraDay(date);

    final hasEventOnPreviousDay =
        widget.calendarController._hasEventOnPreviousDay(date) &&
            widget.calendarStyle.outsideDaysVisible;
    final hasEventOnNextDay =
        widget.calendarController._hasEventOnNextDay(date) &&
            widget.calendarStyle.outsideDaysVisible;

    final tIsHoliday = widget.calendarController.visibleHolidays
        .containsKey(_getHolidayKey(date));
    final tIsWeekend =
        widget.calendarController._isWeekend(date, widget.weekendDays);

    final isUnavailable =
        widget.builders.unavailableDayBuilder != null && tIsUnavailable;
    final isSelected =
        widget.builders.selectedDayBuilder != null && tIsSelected;
    final isToday = widget.builders.todayDayBuilder != null && tIsToday;
    final isOutsideHoliday = widget.builders.outsideHolidayDayBuilder != null &&
        tIsOutside &&
        tIsHoliday;
    final isHoliday =
        widget.builders.holidayDayBuilder != null && !tIsOutside && tIsHoliday;
    final isOutsideWeekend = widget.builders.outsideWeekendDayBuilder != null &&
        tIsOutside &&
        tIsWeekend &&
        !tIsHoliday;
    final isOutside = widget.builders.outsideDayBuilder != null &&
        tIsOutside &&
        !tIsWeekend &&
        !tIsHoliday;
    final isWeekend = widget.builders.weekendDayBuilder != null &&
        !tIsOutside &&
        tIsWeekend &&
        !tIsHoliday;

    if (isUnavailable) {
      return widget.builders.unavailableDayBuilder(
          context, date, widget.calendarController.visibleEvents[eventKey]);
    } else if (isSelected && widget.calendarStyle.renderSelectedFirst) {
      return widget.builders.selectedDayBuilder(
          context, date, widget.calendarController.visibleEvents[eventKey]);
    } else if (isToday) {
      return widget.builders.todayDayBuilder(
          context, date, widget.calendarController.visibleEvents[eventKey]);
    } else if (isSelected) {
      return widget.builders.selectedDayBuilder(
          context, date, widget.calendarController.visibleEvents[eventKey]);
    } else if (isOutsideHoliday) {
      return widget.builders.outsideHolidayDayBuilder(
          context, date, widget.calendarController.visibleEvents[eventKey]);
    } else if (isHoliday) {
      return widget.builders.holidayDayBuilder(
          context, date, widget.calendarController.visibleEvents[eventKey]);
    } else if (isOutsideWeekend) {
      return widget.builders.outsideWeekendDayBuilder(
          context, date, widget.calendarController.visibleEvents[eventKey]);
    } else if (isOutside) {
      return widget.builders.outsideDayBuilder(
          context, date, widget.calendarController.visibleEvents[eventKey]);
    } else if (isWeekend) {
      return widget.builders.weekendDayBuilder(
          context, date, widget.calendarController.visibleEvents[eventKey]);
    } else if (widget.builders.dayBuilder != null) {
      return widget.builders.dayBuilder(
          context, date, widget.calendarController.visibleEvents[eventKey]);
    } else {
      return ChangeNotifierProvider.value(
        value: getFirstEventOfDay(date),
        child: _CellWidget(
          text: '${date.day}',
          isUnavailable: tIsUnavailable,
          isSelected: tIsSelected,
          isToday: tIsToday,
          isWeekend: tIsWeekend,
          isOutsideMonth: tIsOutside,
          isHoliday: tIsHoliday,
          hasEventOnPreviousDay: hasEventOnPreviousDay,
          hasEventOnNextDay: hasEventOnNextDay,
          calendarStyle: widget.calendarStyle,
        ),
      );
    }
  }

  VisitExt getFirstEventOfDay(DateTime date) {
    Map<DateTime, List<VisitExt>> visits =
        widget.events as Map<DateTime, List<VisitExt>>;
    VisitExt firstEvent;
    List<VisitExt> dayVisits = visits[date.roundToDay()];
    if (dayVisits != null && dayVisits.isNotEmpty) {
      firstEvent = dayVisits[0];
    }
    return firstEvent;
  }
}

part of table_calendar;

const double _dxMax = 1.2;
const double _dxMin = -1.2;

typedef void _SelectedDayCallback(DateTime day);

class CalendarController {
  /// Currently focused day (used to determine which year/month should be visible).
  DateTime get focusedDay => _focusedDay;

  /// Currently selected day.
  DateTime get selectedDay => _selectedDay;

  /// List of currently visible days.
  List<DateTime> get visibleDays => !_includeInvisibleDays
      ? _visibleDays.value.where((day) => !_isExtraDay(day)).toList()
      : _visibleDays.value;

  /// `Map` of currently visible events.
  Map<DateTime, List> get visibleEvents {

    Map<DateTime, List<VisitExt>> visits = _visitsInfo.getDateTimeToVisitsList();

    return Map.fromEntries(
      visits.entries.where((entry) {
        for (final day in visibleDays) {
          if (_isSameDay(day, entry.key)) {
            return true;
          }
        }

        return false;
      }),
    );
  }

  /// `Map` of currently visible holidays.
  Map<DateTime, List> get visibleHolidays {
    if (_holidays == null) {
      return {};
    }

    return Map.fromEntries(
      _holidays.entries.where((entry) {
        for (final day in visibleDays) {
          if (_isSameDay(day, entry.key)) {
            return true;
          }
        }

        return false;
      }),
    );
  }

  VisitsInfoProvider _visitsInfo;
  Map<DateTime, List> _holidays;
  DateTime _focusedDay;
  DateTime _selectedDay;
  ValueNotifier<List<DateTime>> _visibleDays;
  DateTime _previousFirstDay;
  DateTime _previousLastDay;
  int _pageId;
  double _dx;
  bool _includeInvisibleDays;
  _SelectedDayCallback _selectedDayCallback;

  void _init({
    @required VisitsInfoProvider visitsInfo,
    @required Map<DateTime, List> holidays,
    @required DateTime initialDay,
    @required _SelectedDayCallback selectedDayCallback,
    @required OnVisibleDaysChanged onVisibleDaysChanged,
    @required OnCalendarCreated onCalendarCreated,
    @required bool includeInvisibleDays,
  }) {
    _visitsInfo = visitsInfo;
    _holidays = holidays;
    _selectedDayCallback = selectedDayCallback;
    _includeInvisibleDays = includeInvisibleDays;

    _pageId = 0;
    _dx = 0;

    final now = DateTime.now();
    _focusedDay = initialDay ?? _normalizeDate(now);
    _selectedDay = _focusedDay;
    _visibleDays = ValueNotifier(_getVisibleDays());
    _previousFirstDay = _visibleDays.value.first;
    _previousLastDay = _visibleDays.value.last;

    if (onVisibleDaysChanged != null) {
      _visibleDays.addListener(() {
        if (!_isSameDay(_visibleDays.value.first, _previousFirstDay) ||
            !_isSameDay(_visibleDays.value.last, _previousLastDay)) {
          _previousFirstDay = _visibleDays.value.first;
          _previousLastDay = _visibleDays.value.last;
          onVisibleDaysChanged(
              _getFirstDay(includeInvisible: _includeInvisibleDays),
              _getLastDay(includeInvisible: _includeInvisibleDays));
        }
      });
    }

    if (onCalendarCreated != null) {
      onCalendarCreated(_getFirstDay(includeInvisible: _includeInvisibleDays),
          _getLastDay(includeInvisible: _includeInvisibleDays));
    }
  }

  void dispose() {
    _visibleDays?.dispose();
  }

  /// Sets selected day to a given `value`.
  /// Use `runCallback: true` if this should trigger `OnDaySelected` callback.
  void setSelectedDay(
    DateTime value, {
    bool isProgrammatic = true,
    bool animate = true,
    bool runCallback = false,
  }) {
    final normalizedDate = _normalizeDate(value);

    if (animate) {
      if (normalizedDate.isBefore(_getFirstDay(includeInvisible: false))) {
        _decrementPage();
      } else if (normalizedDate.isAfter(_getLastDay(includeInvisible: false))) {
        _incrementPage();
      }
    }

    _selectedDay = normalizedDate;
    _focusedDay = normalizedDate;
    _updateVisibleDays(isProgrammatic);

    if (isProgrammatic && runCallback && _selectedDayCallback != null) {
      _selectedDayCallback(normalizedDate);
    }
  }

  /// Sets displayed month/year without changing the currently selected day.
  void setFocusedDay(DateTime value) {
    _focusedDay = _normalizeDate(value);
    _updateVisibleDays(true);
  }

  void _updateVisibleDays(bool isProgrammatic) {
    if (isProgrammatic) {
      _visibleDays.value = _getVisibleDays();
    }
  }

  void _selectPrevious() {
    _selectPreviousMonth();
    _visibleDays.value = _getVisibleDays();
    _decrementPage();
  }

  void _selectNext() {
    _selectNextMonth();
    _visibleDays.value = _getVisibleDays();
    _incrementPage();
  }

  void _selectPreviousMonth() {
    _focusedDay = _previousMonth(_focusedDay);
  }

  void _selectNextMonth() {
    _focusedDay = _nextMonth(_focusedDay);
  }

  DateTime _getFirstDay({@required bool includeInvisible}) {
    if (!includeInvisible) {
      return _firstDayOfMonth(_focusedDay);
    } else {
      return _visibleDays.value.first;
    }
  }

  DateTime _getLastDay({@required bool includeInvisible}) {
    if (!includeInvisible) {
      return _lastDayOfMonth(_focusedDay);
    } else {
      return _visibleDays.value.last;
    }
  }

  List<DateTime> _getVisibleDays() {
    return _daysInMonth(_focusedDay);
  }

  void _decrementPage() {
    _pageId--;
    _dx = _dxMin;
  }

  void _incrementPage() {
    _pageId++;
    _dx = _dxMax;
  }

  List<DateTime> _daysInMonth(DateTime month) {
    final first = _firstDayOfMonth(month);
    final daysBefore = _getDaysBefore(first);
    final firstToDisplay = first.subtract(Duration(days: daysBefore));

    final last = _lastDayOfMonth(month);
    final daysAfter = _getDaysAfter(last);

    final lastToDisplay = last.add(Duration(days: daysAfter));
    return _daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  int _getDaysBefore(DateTime firstDay) {
    return (firstDay.weekday + 7 - DateTime.monday) % 7;
  }

  int _getDaysAfter(DateTime lastDay) {
    int invertedStartingWeekday = 8 - DateTime.monday;

    int daysAfter = 7 - ((lastDay.weekday + invertedStartingWeekday) % 7) + 1;
    if (daysAfter == 8) {
      daysAfter = 1;
    }

    return daysAfter;
  }

  DateTime _firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1, 12);
  }

  DateTime _lastDayOfMonth(DateTime month) {
    final date = month.month < 12
        ? DateTime.utc(month.year, month.month + 1, 1, 12)
        : DateTime.utc(month.year + 1, 1, 1, 12);
    return date.subtract(const Duration(days: 1));
  }

  DateTime _previousMonth(DateTime month) {
    if (month.month == 1) {
      return DateTime(month.year - 1, 12);
    } else {
      return DateTime(month.year, month.month - 1);
    }
  }

  DateTime _nextMonth(DateTime month) {
    if (month.month == 12) {
      return DateTime(month.year + 1, 1);
    } else {
      return DateTime(month.year, month.month + 1);
    }
  }

  Iterable<DateTime> _daysInRange(DateTime firstDay, DateTime lastDay) sync* {
    var temp = firstDay;

    while (temp.isBefore(lastDay)) {
      yield _normalizeDate(temp);
      temp = temp.add(const Duration(days: 1));
    }
  }

  DateTime _normalizeDate(DateTime value) {
    return DateTime.utc(value.year, value.month, value.day, 12);
  }

  DateTime _getEventKey(DateTime day) {
    return visibleEvents.keys
        .firstWhere((it) => _isSameDay(it, day), orElse: () => null);
  }

  DateTime _getHolidayKey(DateTime day) {
    return visibleHolidays.keys
        .firstWhere((it) => _isSameDay(it, day), orElse: () => null);
  }

  bool isSelected(DateTime day) {
    return _isSameDay(day, selectedDay);
  }

  bool isToday(DateTime day) {
    return _isSameDay(day, DateTime.now());
  }

  bool _isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }

  bool _isWeekend(DateTime day, List<int> weekendDays) {
    return weekendDays.contains(day.weekday);
  }

  Color _getEventColor(DateTime day) {
    List<VisitExt> visits = _visitsInfo.getDateTimeToVisitsList()[day.roundToDay()];
    return visits == null
        ? null
        : visits[0].status.toVisitStatus().colors().item2;
  }

  bool _isEventDay(DateTime day) =>
      _visitsInfo.getDateTimeToVisitsList().containsKey(day.roundToDay());

  bool _hasEventOnPreviousDay(DateTime day) => _visitsInfo
      .getDateTimeToVisitsList()
      .containsKey(day.subtract(Duration(days: 1)).roundToDay());

  bool _hasEventOnNextDay(DateTime day) => _visitsInfo
      .getDateTimeToVisitsList()
      .containsKey(day.add(Duration(days: 1)).roundToDay());

  VisitStatus _getVisitStatus(DateTime day) {
    List<VisitExt> doctorEvents =
        _visitsInfo.getDateTimeToVisitsList()[day.roundToDay()];
    return doctorEvents == null ? null : doctorEvents[0].status.toVisitStatus();
  }

  bool _isExtraDay(DateTime day) {
    return _isExtraDayBefore(day) || _isExtraDayAfter(day);
  }

  bool _isExtraDayBefore(DateTime day) {
    return day.month < _focusedDay.month;
  }

  bool _isExtraDayAfter(DateTime day) {
    return day.month > _focusedDay.month;
  }
}

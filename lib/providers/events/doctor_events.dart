import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/event_state.dart';
import 'package:mvp_platform/models/event/doctor_event.dart';
import 'package:mvp_platform/providers/doctor_provider.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';

class DoctorEvents with ChangeNotifier {

  final Map<DateTime, List<DoctorEvent>> _events = {};
  final List<DoctorEvent> _eventsOfMonth = [];

  DateTime activeMonth = DateTime(2020, 5);

  DoctorEvents() {
    List<DoctorEvent> events = [];
    events.add(DoctorEvent(
      doctor: Doctors.doctors[0],
      startsAt: DateTime(2020, 05, 02, 14, 15),
      endsAt: DateTime(2020, 05, 02, 14, 45),
      eventState: EventState.complete,
      description: 'Посещение кардиолога первое - Постановка на Д учет - Является первой явкой по Д-учету',
    ));
    events.add(DoctorEvent(
      doctor: Doctors.doctors[1],
      startsAt: DateTime(2020, 05, 10, 10, 15),
      endsAt: DateTime(2020, 05, 10, 11),
      eventState: EventState.approved,
      description: 'Ультразвуковое исследование',
    ));
    events.add(DoctorEvent(
      doctor: Doctors.doctors[1],
      startsAt: DateTime(2020, 05, 11),
      endsAt: DateTime(2020, 05, 11),
      eventState: EventState.planned,
      description: 'Посещение кардиолога в рамках Д-учета',
    ));
    events.forEach((event) {
      DateTime key = event.startsAt.roundToDay();
      if (_events.containsKey(key)) {
        _events[key].add(event);
        _events[key].sort((e1, e2) => e1.startsAt.compareTo(e2.startsAt));
      } else {
        _events.putIfAbsent(key, () => [event]);
      }
    });
    _events.forEach((k, v) {
      if (k.year == activeMonth.year && k.month == activeMonth.month) {
        _eventsOfMonth.addAll(v);
      }
    });
    _eventsOfMonth.sort((e1, e2) => e1.startsAt.compareTo(e2.startsAt));
    notifyListeners();
  }

  Map<DateTime, List<DoctorEvent>> get items => _events;

  List<DoctorEvent> get allEvents {
    List<DoctorEvent> events = [];
    _events.forEach((k, v) => events.addAll(v));
    events.sort((e1, e2) => e1.startsAt.compareTo(e2.startsAt));
    return events;
  }

  List<DoctorEvent> get eventsOfMonth => _eventsOfMonth;

  void setActiveMonth(DateTime date) {
    if (date.roundToMonth() != activeMonth) {
      activeMonth = date.roundToMonth();
      _eventsOfMonth.clear();
      _events.forEach((k, v) {
        if (k.year == activeMonth.year && k.month == activeMonth.month) {
          _eventsOfMonth.addAll(v);
        }
      });
      _eventsOfMonth.sort((e1, e2) => e1.startsAt.compareTo(e2.startsAt));
      notifyListeners();
    }
  }

  void addEvent(DoctorEvent event) {
    DateTime key = event.startsAt.roundToDay();
    if (_events.containsKey(key)) {
      _events[key].add(event);
      _events[key].sort((e1, e2) => e1.startsAt.compareTo(e2.startsAt));
    } else {
      _events.putIfAbsent(key, () => [event]);
    }
    notifyListeners();
  }

  bool removeEvent(DoctorEvent event) {
    bool removed = false;
    DateTime key = event.startsAt.roundToDay();
    if (_events.containsValue(key)) {
      if (_events[key].contains(event)) {
        removed = _events[key].remove(event);
      }
    }
    notifyListeners();
    return removed;
  }
}

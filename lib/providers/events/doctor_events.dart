import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/event_state.dart';
import 'package:mvp_platform/models/event/doctor_event.dart';
import 'package:mvp_platform/providers/doctor_provider.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';

class DoctorEvents with ChangeNotifier {

  final Map<DateTime, List<DoctorEvent>> _events = {};
  final List<DoctorEvent> _eventsOfMonth = [];

  DateTime activeMonth = DateTime.now().roundToMonth();

  DoctorEvents() {
    int days = 2;
    List<DoctorEvent> events = Doctors.doctors.map((doctor) {
      days++;
      return DoctorEvent(
        doctor: doctor,
        startsAt: DateTime.now().add(Duration(days: days)),
        endsAt: DateTime.now().add(Duration(days: days, hours: 1)),
        description: 'Диспансерный прием (осмотр, консультация)',
      );
    }).toList();
    events.add(DoctorEvent(
      doctor: Doctors.doctors[1],
      startsAt: DateTime.now().subtract(Duration(days: 6, hours: 1)),
      endsAt: DateTime.now().subtract(Duration(days: 6)),
      description: 'Консультация у трансгуманиста',
    ));
    events.add(DoctorEvent(
      doctor: Doctors.doctors[1],
      startsAt: DateTime.now().add(Duration(days: 9)),
      endsAt: DateTime.now().add(Duration(days: 9, hours: 1, minutes: 30)),
      eventState: EventState.approved,
      description: 'Посещение хирурга',
    ));
    events.add(DoctorEvent(
      doctor: Doctors.doctors[1],
      startsAt: DateTime(2020, 6, 30, 18),
      endsAt: DateTime(2020, 6, 30, 18, 30),
      eventState: EventState.approved,
      description: 'Посещение хирурга',
    ));
    events.add(DoctorEvent(
      doctor: Doctors.doctors[1],
      startsAt: DateTime(2020, 7, 1, 18),
      endsAt: DateTime(2020, 7, 1, 18, 30),
      description: 'Посещение хирурга',
    ));
    events.add(DoctorEvent(
      doctor: Doctors.doctors[1],
      startsAt: DateTime(2020, 6, 1, 18),
      endsAt: DateTime(2020, 6, 1, 18, 30),
      description: 'Посещение хирурга',
    ));
    events.add(DoctorEvent(
      doctor: Doctors.doctors[1],
      startsAt: DateTime(2020, 5, 31, 18),
      endsAt: DateTime(2020, 5, 31, 18, 30),
      eventState: EventState.approved,
      description: 'Посещение хирурга',
    ));
    events.add(DoctorEvent(
      doctor: Doctors.doctors[1],
      startsAt: DateTime(2020, 6, 21, 18),
      endsAt: DateTime(2020, 6, 21, 18, 30),
      eventState: EventState.approved,
      description: 'Посещение хирурга',
    ));
    events.add(DoctorEvent(
      doctor: Doctors.doctors[1],
      startsAt: DateTime(2020, 6, 22, 18),
      endsAt: DateTime(2020, 6, 22, 18, 30),
      eventState: EventState.approved,
      description: 'Посещение хирурга',
    ));
    events.add(DoctorEvent(
      doctor: Doctors.doctors[1],
      startsAt: DateTime(2020, 6, 23, 18),
      endsAt: DateTime(2020, 6, 23, 18, 30),
      eventState: EventState.approved,
      description: 'Посещение хирурга',
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

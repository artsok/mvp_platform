import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/event/doctor_event.dart';
import 'package:mvp_platform/providers/doctor_provider.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';

class DoctorEvents with ChangeNotifier {
  final Map<DateTime, List<DoctorEvent>> _events = Map.fromIterable(
    Doctors.doctors,
    key: (d) => DateTime.now().add(Duration(days: 3)).roundToDay(),
    value: (d) => [
      DoctorEvent(
        doctor: d,
        startsAt: DateTime.now().add(Duration(days: 3)),
        endsAt: DateTime.now().add(Duration(days: 3, hours: 1)),
        description: 'Диспансерный прием (осмотр, консультация)',
      )
    ],
  );

  Map<DateTime, List<DoctorEvent>> get items => _events;

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

  List<DoctorEvent> get allEvents {
    List<DoctorEvent> events = [];
    _events.forEach((k, v) => events.addAll(v));
    return events;
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

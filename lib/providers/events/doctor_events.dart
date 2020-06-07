import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/event/doctor_event.dart';
import 'package:mvp_platform/providers/doctor_provider.dart';

class DoctorEvents with ChangeNotifier {
  final List<DoctorEvent> _events = Doctors.doctors.map((d) => DoctorEvent(
        doctor: d,
        startsAt: DateTime.now().add(Duration(days: 3)),
        endsAt: DateTime.now().add(Duration(days: 3, hours: 1)),
        description: 'Диспансерный прием (осмотр, консультация)',
      )).toList();

  List<DoctorEvent> get items => _events;

  void addEvent(DoctorEvent event) {
    _events.add(event);
    _events.sort((e1, e2) => e1.startsAt.compareTo(e2.startsAt));
    notifyListeners();
  }

  void cancelEvent(DoctorEvent event) {
    _events.firstWhere((e) => e == event).cancel();
    notifyListeners();
  }

  void removeEvent(DoctorEvent event) {
    _events.removeWhere((e) => e == event);
    notifyListeners();
  }
}

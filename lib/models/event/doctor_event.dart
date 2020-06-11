import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/doctor.dart';
import 'package:mvp_platform/models/enums/event_state.dart';

class DoctorEvent with ChangeNotifier {
  DateTime startsAt;
  DateTime endsAt;
  String description;
  EventState _eventState;
  Doctor doctor;
  String imagePath;

  DoctorEvent._({
    this.startsAt,
    this.endsAt,
    this.description,
    EventState eventState,
    this.doctor,
    this.imagePath,
  }) {
    _eventState = eventState;
  }

  factory DoctorEvent({
    @required DateTime startsAt,
    @required DateTime endsAt,
    @required Doctor doctor,
    String description,
    EventState eventState,
    String imagePath,
  }) {
    assert(doctor != null);
    assert(startsAt != null);
    assert(endsAt != null);
    assert(startsAt.compareTo(endsAt) <= 0);
    eventState = eventState ?? calculateState(startsAt, endsAt, DateTime.now());
    description = description ?? 'Нет описания';
    imagePath = imagePath ?? '';
    return DoctorEvent._(
      startsAt: startsAt,
      endsAt: endsAt,
      description: description,
      eventState: eventState,
      doctor: doctor,
      imagePath: imagePath,
    );
  }

  bool operator ==(other) =>
      identical(this, other) ||
      other is DoctorEvent &&
          startsAt == other.startsAt &&
          endsAt == other.endsAt &&
          _eventState == other._eventState &&
          doctor == other.doctor &&
          imagePath == other.imagePath &&
          description == other.description;

  @override
  int get hashCode {
    return startsAt.hashCode +
        endsAt.hashCode +
        _eventState.hashCode +
        doctor.hashCode +
        imagePath.hashCode +
        description.hashCode;
  }

  EventState get eventState => _eventState;

  set eventState(eventState) {
    _eventState = eventState;
    print('Rate set');
    notifyListeners();
  }

  void cancel() => eventState = EventState.canceled;

  static EventState calculateState(
      DateTime eventStart, DateTime eventEnd, DateTime date) {
    if (eventStart.compareTo(date) >= 0) {
      return EventState.planned;
    }
    if (eventStart.compareTo(date) < 0 && eventEnd.compareTo(date) >= 0) {
      // return active
      return EventState.planned;
    }
    return EventState.complete;
  }
}

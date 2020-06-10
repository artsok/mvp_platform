import 'control_card_visit.dart';

class ChangeControlCardVisitParams extends ControlCardVisit {
  DateTime newPlanDate;
  String status;
  String doctorId;
  String service;

  DateTime getNewPlanDate() {
    return newPlanDate;
  }

  void setNewPlanDate(DateTime newPlanDate) {
    this.newPlanDate = newPlanDate;
  }

  String getStatus() {
    return status;
  }

  void setStatus(String status) {
    this.status = status;
  }

  String getDoctorId() {
    return doctorId;
  }

  void setDoctorId(String doctorId) {
    this.doctorId = doctorId;
  }

  String getService() {
    return service;
  }

  void setService(String service) {
    this.service = service;
  }
}

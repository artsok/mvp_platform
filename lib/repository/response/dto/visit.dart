import 'package:mvp_platform/repository/response/dto/visit_base.dart';

class Visit extends VisitBase {
  String doctorId;
  String serviceId;

  Visit.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    doctorId = json['doctorId'] != null ? json['doctorId'] : null;
    serviceId = json['serviceId'] != null ? json['serviceId'] : null;
  }

  Visit();

  Visit.withPlanDate(DateTime planDate) : super.withPlanDate(planDate);

  String getDoctorId() {
    return doctorId;
  }

  void setDoctorId(String doctorId) {
    this.doctorId = doctorId;
  }

  String getServiceId() {
    return serviceId;
  }

  void setServiceId(String serviceId) {
    this.serviceId = serviceId;
  }
}

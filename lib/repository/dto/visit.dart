class Visit {
  DateTime planDate;
  DateTime factDate;
  String doctorId;
  String service;

  Visit({DateTime planDate, DateTime factDate, String doctorId,
      String service}) {
    this.planDate = planDate;
    this.factDate = factDate;
    this.doctorId = doctorId;
    this.service = service;
  }

  DateTime getPlanDate() {
    return planDate;
  }

  void setPlanDate(DateTime planDate) {
    this.planDate = planDate;
  }

  DateTime getFactDate() {
    return factDate;
  }

  void setFactDate(DateTime factDate) {
    this.factDate = factDate;
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

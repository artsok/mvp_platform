
class TreatmentActivity {
  String activity;
  DateTime beginDate;
  DateTime endDate;
  bool completed;
  String doctorId;

  TreatmentActivity(
      {String activity, DateTime beginDate, String doctorId}) {
    this.activity = activity;
    this.beginDate = beginDate;
    this.doctorId = doctorId;
  }

  String getActivity() {
    return activity;
  }

  void setActivity(String activity) {
    this.activity = activity;
  }

  DateTime getBeginDate() {
    return beginDate;
  }

  void setBeginDate(DateTime beginDate) {
    this.beginDate = beginDate;
  }

  DateTime getEndDate() {
    return endDate;
  }

  void setEndDate(DateTime endDate) {
    this.endDate = endDate;
  }

  bool isCompleted() {
    return completed;
  }

  void setCompleted(bool completed) {
    this.completed = completed;
  }

  String getDoctorId() {
    return doctorId;
  }

  void setDoctorId(String doctorId) {
    this.doctorId = doctorId;
  }
}

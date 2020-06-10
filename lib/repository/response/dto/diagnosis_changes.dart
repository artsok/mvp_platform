class DiagnosisChanges {
  DateTime diagnosisDate;
  String diagnosisName;
  String diagnosisCode;
  String doctorId;

  DiagnosisChanges(DateTime diagnosisDate, String diagnosisName,
      String diagnosisCode, String doctorId) {
    this.diagnosisDate = diagnosisDate;
    this.diagnosisName = diagnosisName;
    this.diagnosisCode = diagnosisCode;
    this.doctorId = doctorId;
  }

  DateTime getDiagnosisDate() {
    return diagnosisDate;
  }

  void setDiagnosisDate(DateTime diagnosisDate) {
    this.diagnosisDate = diagnosisDate;
  }

  String getDiagnosisName() {
    return diagnosisName;
  }

  void setDiagnosisName(String diagnosisName) {
    this.diagnosisName = diagnosisName;
  }

  String getDiagnosisCode() {
    return diagnosisCode;
  }

  void setDiagnosisCode(String diagnosisCode) {
    this.diagnosisCode = diagnosisCode;
  }

  String getDoctorId() {
    return doctorId;
  }

  void setDoctorId(String doctorId) {
    this.doctorId = doctorId;
  }
}

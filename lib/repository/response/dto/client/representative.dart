class Representative {
  String empId;
  String fullName;
  bool hasConsent;

  Representative.fromJson(Map<String, dynamic> json) {
    empId = json['empId'] != null ? json['empId'] : null;
    fullName = json['fullName'] != null ? json['fullName'] : null;
    hasConsent = json['hasConsent'] != null ? json['hasConsent'] : null;
  }

  String getEmpId() {
    return empId;
  }

  void setEmpId(String empId) {
    this.empId = empId;
  }

  String getFullName() {
    return fullName;
  }

  void setFullName(String fullName) {
    this.fullName = fullName;
  }

  bool getHasConsent() {
    return hasConsent;
  }

  void setHasConsent(bool hasConsent) {
    this.hasConsent = hasConsent;
  }
}

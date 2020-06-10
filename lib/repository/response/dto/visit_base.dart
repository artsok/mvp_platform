abstract class VisitBase {
  String id;
  DateTime planDate;
  DateTime factDate;
  String service;

  VisitBase() {}

  VisitBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planDate = DateTime.parse(json['planDate']);
    factDate = json['factDate'] != null ? DateTime.parse(json['factDate']) : null;
    service = json['service'];
  }

  VisitBase.withPlanDate(DateTime planDate) {
    this.planDate = planDate;
  }

  VisitBase.withPlanDateAndFactDate(DateTime planDate, DateTime factDate) {
    this.planDate = planDate;
    this.factDate = factDate;
  }

  VisitBase.all(
      String id, DateTime planDate, DateTime factDate, String service) {
    this.id = id;
    this.planDate = planDate;
    this.factDate = factDate;
    this.service = service;
  }

  String getId() {
    return id;
  }

  void setId(String id) {
    this.id = id;
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

  String getService() {
    return service;
  }

  void setService(String service) {
    this.service = service;
  }

  @override
  String toString() {
    return 'VisitBase{id: $id, planDate: $planDate, factDate: $factDate, service: $service}';
  }
}

abstract class VisitBase {
  String id;
  DateTime planDate;
  DateTime factDate;

  VisitBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planDate =
        json['planDate'] != null ? DateTime.parse(json['planDate']) : null;
    factDate =
        json['factDate'] != null ? DateTime.parse(json['factDate']) : null;
  }

  VisitBase();

  VisitBase.withPlanDate(DateTime planDate) {
    this.planDate = planDate;
  }

  VisitBase.withPlanDateAndFactDate(DateTime planDate, DateTime factDate) {
    this.planDate = planDate;
    this.factDate = factDate;
  }

  VisitBase.all(String id, DateTime planDate, DateTime factDate) {
    this.id = id;
    this.planDate = planDate;
    this.factDate = factDate;
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
}

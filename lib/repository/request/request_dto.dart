class RequestDto {
  String jsonrpc;
  String method;
  int id;
  Params params;

  RequestDto({this.jsonrpc = "2.0", this.method, this.id, this.params});

  Map<String, dynamic> toJsonGetVisitsByClient() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['method'] = this.method;
    data['id'] = this.id;
    if (this.params != null) {
      data['params'] = this.params.toJsonGetVisitsByClient();
    }
    return data;
  }

  Map<String, dynamic> toJsonSetRating() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['method'] = this.method;
    data['id'] = this.id;
    if (this.params != null) {
      data['params'] = this.params.toJsonSetRating();
    }
    return data;
  }

  Map<String, dynamic> toJsonInsuredInfant() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['method'] = this.method;
    data['id'] = this.id;
    if (this.params != null) {
      data['params'] = this.params.toJsonBirthActId();
    }
    return data;
  }

  Map<String, dynamic> toJsonGetMedicalOrganizations() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['method'] = this.method;
    data['id'] = this.id;
    data['params'] = null;
    return data;
  }

  Map<String, dynamic> toJsonChangeVisit() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['method'] = this.method;
    data['id'] = this.id;
    data['params'] = this.params.toJsonChangeVisit();
    return data;
  }

  Map<String, dynamic> toJsonCancelVisit() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['method'] = this.method;
    data['id'] = this.id;
    data['params'] = this.params.toJsonCancelVisit();
    return data;
  }

  Map<String, dynamic> toJsonApplyForInsurance() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['method'] = this.method;
    data['id'] = this.id;
    data['params'] = this.params.toJsonApplyForInsurance();
    return data;
  }

  Map<String, dynamic> toJsonChangeMedicalOrganization() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['method'] = this.method;
    data['id'] = this.id;
    data['params'] = this.params.toJsonChangeMedicalOrganization();
    return data;
  }
}

class Params {
  String id;
  String visitId;
  String clientId;
  DateTime planDate;
  String rating;
  String birthActId;
  ChangeControlCardVisitParams changeControlCardVisitParams;
  GetVisitParams getVisitParams;
  InsuranceApplicationDetails insuranceApplicationDetails;
  Assignment assignment;

  Params();

  Params.withClientIdAndPlanDate({this.clientId, this.planDate});

  Params.withBirthActId({this.birthActId});

  Params.setRating({this.id, this.rating});

  Params.changeVisit({this.changeControlCardVisitParams});

  Params.getVisitParams({this.getVisitParams});

  Params.cancelVisit({this.visitId});

  Params.applyForInsurance({this.insuranceApplicationDetails});

  Params.changeMedicalOrganization({this.assignment});

  Map<String, dynamic> toJsonBirthActId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthActId'] = this.birthActId;
    return data;
  }

  Map<String, dynamic> toJsonGetVisitsByClient() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getVisitParams'] = this.getVisitParams;
    return data;
  }

  Map<String, dynamic> toJsonSetRating() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    return data;
  }

  Map<String, dynamic> toJsonChangeVisit() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['changeControlCardVisitParams'] = this.changeControlCardVisitParams;
    return data;
  }

  Map<String, dynamic> toJsonCancelVisit() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.visitId;
    return data;
  }

  Map<String, dynamic> toJsonApplyForInsurance() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['insuranceApplicationDetails'] = this.insuranceApplicationDetails;
    return data;
  }

  Map<String, dynamic> toJsonChangeMedicalOrganization() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignment'] = this.assignment;
    return data;
  }
}

class ChangeControlCardVisitParams {
  String id;
  String planDate;
  int doctorId;
  int serviceId;
  String status;

  ChangeControlCardVisitParams(
      {this.id, this.planDate, this.doctorId, this.serviceId, this.status});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['planDate'] = this.planDate;
    data['doctorId'] = this.doctorId;
    data['serviceId'] = this.serviceId;
    data['status'] = this.status;
    return data;
  }
}

class GetVisitParams {
  String clientId;
  String startDate;
  String endDate;

  GetVisitParams({this.clientId, this.startDate, this.endDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientId'] = this.clientId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}

class InsuranceApplicationDetails {
  String birthActId;
  String smoId;

  InsuranceApplicationDetails({this.birthActId, this.smoId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthActId'] = this.birthActId;
    data['smoId'] = this.smoId;
    return data;
  }
}

class Assignment {
  String policyNumber;
  String medicalOrganizationCode;

  Assignment({this.policyNumber, this.medicalOrganizationCode});

  Assignment.fromJson(Map<String, dynamic> json) {
    policyNumber = json['policyNumber'];
    medicalOrganizationCode = json['medicalOrganizationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['policyNumber'] = this.policyNumber;
    data['medicalOrganizationCode'] = this.medicalOrganizationCode;
    return data;
  }
}

//class VisitRatingParams {
//  String controlCardId;
//
//  //String planDate;
//  String rating;
//
//  VisitRatingParams.all(this.controlCardId, this.rating);
//
//  VisitRatingParams.fromJson(Map<String, dynamic> json) {
//    controlCardId = json['controlCardId'];
//    //planDate = json['planDate'];
//    rating = json['rating'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['controlCardId'] = this.controlCardId;
//    //data['planDate'] = this.planDate;
//    data['rating'] = this.rating;
//    return data;
//  }
//}

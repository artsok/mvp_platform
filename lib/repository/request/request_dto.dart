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

  Map<String, dynamic> toJsonGetVisitExtParams() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['method'] = this.method;
    data['id'] = this.id;
    data['params'] = this.params.toJsonGetVisitExtById();
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

  Map<String, dynamic> toJsonWithFilter() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['method'] = this.method;
    data['id'] = this.id;
    data['params'] = this.params.toJsonWithFilter();
    return data;
  }
}

class Params {
  String id;
  String visitId;
  String clientId;
  DateTime planDate;
  RatingParams ratingParams;
  String birthActId;
  ChangeControlCardVisitParams changeControlCardVisitParams;
  GetVisitsParams getVisitsParams;
  InsuranceApplicationDetails insuranceApplicationDetails;
  Assignment assignment;
  Filter filter;

  Params();

  Params.withClientIdAndPlanDate({this.clientId, this.planDate});

  Params.withBirthActId({this.birthActId});

  Params.setRating(this.ratingParams);

  Params.changeVisit({this.changeControlCardVisitParams});

  Params.getVisitsParams({this.getVisitsParams});

  Params.getVisitExtParams(this.id);

  Params.cancelVisit({this.visitId});

  Params.applyForInsurance({this.insuranceApplicationDetails});

  Params.changeMedicalOrganization({this.assignment});

  Params.withFilter({this.filter});

  Map<String, dynamic> toJsonBirthActId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthActId'] = this.birthActId;
    return data;
  }

  Map<String, dynamic> toJsonGetVisitsByClient() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getVisitParams'] = this.getVisitsParams;
    return data;
  }

  Map<String, dynamic> toJsonGetVisitExtById() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }

  Map<String, dynamic> toJsonSetRating() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final ratingParamsMap = Map<String, dynamic>();
    ratingParamsMap['id'] = ratingParams.id;
    ratingParamsMap['rating'] = ratingParams.rating;
    if (ratingParams.ratingComment != null) {
      ratingParamsMap['ratingComment'] = ratingParams.ratingComment;
    }
    data['ratingParams'] = ratingParamsMap;
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

  Map<String, dynamic> toJsonWithFilter() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter'] = this.assignment;
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

class RatingParams {
  String id;
  String rating;
  String ratingComment;

  RatingParams(this.id, this.rating, {this.ratingComment});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['ratingComment'] = this.ratingComment;
    return data;
  }
}

class GetVisitsParams {
  String clientId;
  String startDate;
  String endDate;

  GetVisitsParams({this.clientId, this.startDate, this.endDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientId'] = this.clientId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}

class GetVisitExtParams {
  String id;

  GetVisitExtParams(this.id);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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

class Filter {
  String id;
  String code;
  String name;

  Filter.all(this.id, this.code, this.name);

  Filter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
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

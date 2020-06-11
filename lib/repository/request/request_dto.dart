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
}

class Params {
  String id;
  String clientId;
  DateTime planDate;
  String rating;
  String birthActId;

  Params.withClientIdAndPlanDate({this.clientId, this.planDate});

  Params.withBirthActId({this.birthActId});

  Params.setRating({this.id, this.rating});

  Map<String, dynamic> toJsonBirthActId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthActId'] = this.birthActId;
    return data;
  }

  Map<String, dynamic> toJsonGetVisitsByClient() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientId'] = this.clientId;
    data['planDate'] = this.planDate;
    return data;
  }

  Map<String, dynamic> toJsonSetRating() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
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

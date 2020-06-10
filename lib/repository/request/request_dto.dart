class RequestDto {
  String jsonrpc;
  String method;
  int id;
  Params params;

  RequestDto({this.jsonrpc = "2.0", this.method, this.id, this.params});

  RequestDto.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    method = json['method'];
    id = json['id'];
    params =
        json['params'] != null ? new Params.fromJson(json['params']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['method'] = this.method;
    data['id'] = this.id;
    if (this.params != null) {
      data['params'] = this.params.toJson();
    }
    return data;
  }
}

class Params {
  String clientId;

  Params({this.clientId});

  Params.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientId'] = this.clientId;
    return data;
  }
}

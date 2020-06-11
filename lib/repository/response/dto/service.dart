class Service {
  String id;
  String code;
  String name;
  String serviceType;

  String getId() {
    return id;
  }

  void setId(String id) {
    this.id = id;
  }

  String getCode() {
    return code;
  }

  void setCode(String code) {
    this.code = code;
  }

  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getServiceType() {
    return serviceType;
  }

  void setServiceType(String serviceType) {
    this.serviceType = serviceType;
  }

  Service.all(String id, String code, String name, String serviceType) {
    this.id = id;
    this.code = code;
    this.name = name;
    this.serviceType = serviceType;
  }

  Service() {}

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : null;
    code = json['code'] != null ? json['code'] : null;
    name = json['name'] != null ? json['name'] : null;
    serviceType = json['serviceType'] != null ? json['serviceType'] : null;
  }
}

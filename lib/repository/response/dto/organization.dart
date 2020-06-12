class Organization {
  String id;
  String name;
  String address;
  String phone;

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : null;
    name = json['name'] != null ? json['name'] : null;
    address = json['address'] != null ? json['address'] : null;
    phone = json['phone'] != null ? json['phone'] : null;
  }

  Organization.all(String id, String name, String address, String phone) {
    this.id = id;
    this.name = name;
    this.address = address;
    this.phone = phone;
  }

  Organization.withId(String id) {
    this.id = id;
  }

  String getId() {
    return id;
  }

  void setId(String id) {
    this.id = id;
  }

  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getAddress() {
    return address;
  }

  void setAddress(String address) {
    this.address = address;
  }

  String getPhone() {
    return phone;
  }

  void setPhone(String phone) {
    this.phone = phone;
  }
}

class MedicalOrganization {
  String id;
  String name;
  String address;
  String phone;

  MedicalOrganization({String id, String name, String address, String phone}) {
    this.id = id;
    this.name = name;
    this.address = address;
    this.phone = phone;
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

  String getId() {
    return id;
  }

  void setId(String id) {
    this.id = id;
  }
}

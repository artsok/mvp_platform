class LegalRepresentative {
  String name;
  String contacts;

  LegalRepresentative.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? json['name'] : null;
    contacts = json['contacts'] != null ? json['contacts'] : null;
  }

  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getContacts() {
    return contacts;
  }

  void setContacts(String contacts) {
    this.contacts = contacts;
  }
}

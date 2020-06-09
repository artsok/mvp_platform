class Child {
  String fullname;
  String birthCertificateId;
  String surname;
  String name;
  String patronym;
  String birthDate;
  String birthPlace;
  String address;
  String snils;
  String recordBirthCertificate;
  String parents;
  String oms;
  String gosRegistration;
  String mother;
  String father;

  Child({
    this.birthCertificateId,
    this.surname,
    this.name,
    this.patronym,
    this.birthDate,
    this.snils,
    this.birthPlace,
    this.address,
    this.recordBirthCertificate,
    this.parents,
    this.oms,
    this.gosRegistration,
    this.mother,
    this.father
  }) : fullname = '$surname $name $patronym';
}

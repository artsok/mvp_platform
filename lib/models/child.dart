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

  Child({
    this.birthCertificateId,
    this.surname,
    this.name,
    this.patronym,
    this.birthDate,
    this.snils,
    this.birthPlace,
    this.address
  }) : fullname = '$surname $name $patronym';
}

class Child {
  String fullname;
  String birthCertificateId;
  String surname;
  String name;
  String patronym;
  String birthDate;
  String birthPlace;
  String snils;

  Child({
    this.birthCertificateId,
    this.surname,
    this.name,
    this.patronym,
    this.birthDate,
    this.snils,
    this.birthPlace,
  }) : fullname = '$surname $name $patronym';
}

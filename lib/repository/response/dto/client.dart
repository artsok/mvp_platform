import 'package:mvp_platform/models/enums/gender.dart';
import 'package:mvp_platform/repository/response/dto/person.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';

import 'client/birth_act.dart';
import 'client/birth_certificate.dart';
import 'client/birth_place.dart';
import 'client/identity.dart';
import 'client/legal_representative.dart';
import 'client/parent.dart';
import 'client/policy.dart';
import 'client/registration.dart';

class Client extends Person {
  Gender _gender;
  String registrationAddress;
  DateTime registrationSince;
  String residentialAddress;
  LegalRepresentative legalRepresentative;
  String benefitCategoryCode;
  String snils;
  String nationality;
  Identity identity;
  BirthPlace birthPlace;
  BirthAct birthAct;
  List<Parent> parents;
  Registration registration;
  BirthCertificate birthCertificate;

  Client.fromJson(Map<String, dynamic> json) : super.fromJson(json['person'] ?? json) {
    _gender = (json['gender'] as String)?.toGender();
    registrationAddress = json['registrationAddress'] != null
        ? json['registrationAddress']
        : null;
    registrationSince = json['registrationSince'] != null
        ? DateTime.parse(json['registrationSince'])
        : null;
    residentialAddress =
        json['residentialAddress'] != null ? json['residentialAddress'] : null;
    legalRepresentative = json['legalRepresentative'] != null
        ? LegalRepresentative.fromJson(json['legalRepresentative'])
        : null;
    benefitCategoryCode = json['benefitCategoryCode'] != null
        ? json['benefitCategoryCode']
        : null;
    nationality = json['nationality'] != null ? json['nationality'] : null;
    identity =
        json['identity'] != null ? Identity.fromJson(json['identity']) : null;
    birthPlace = json['birthPlace'] != null
        ? BirthPlace.fromJson(json['birthPlace'])
        : null;
    birthAct =
        json['birthAct'] != null ? BirthAct.fromJson(json['birthAct']) : null;
    parents = json['parents'] != null
        ? (json['parents'] as List).map((i) => Parent.fromJson(i)).toList()
        : null;
    registration = json['registration'] != null
        ? Registration.fromJson(json['registration'])
        : null;
    birthCertificate = json['birthCertificate'] != null
        ? BirthCertificate.fromJson(json['birthCertificate'])
        : null;
  }

  Gender get getGender => _gender;

  set gender(Gender gender) => _gender = gender;

  DateTime getBirthDate() {
    return birthDate;
  }

  void setBirthDate(DateTime birthDate) {
    this.birthDate = birthDate;
  }

  String getPhone() {
    return phone;
  }

  void setPhone(String phone) {
    this.phone = phone;
  }

  String getEmail() {
    return email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getRegistrationAddress() {
    return registrationAddress;
  }

  void setRegistrationAddress(String registrationAddress) {
    this.registrationAddress = registrationAddress;
  }

  DateTime getRegistrationSince() {
    return registrationSince;
  }

  void setRegistrationSince(DateTime registrationSince) {
    this.registrationSince = registrationSince;
  }

  String getResidentialAddress() {
    return residentialAddress;
  }

  void setResidentialAddress(String residentialAddress) {
    this.residentialAddress = residentialAddress;
  }

  LegalRepresentative getLegalRepresentative() {
    return legalRepresentative;
  }

  void setLegalRepresentative(LegalRepresentative legalRepresentative) {
    this.legalRepresentative = legalRepresentative;
  }

  String getBenefitCategoryCode() {
    return benefitCategoryCode;
  }

  void setBenefitCategoryCode(String benefitCategoryCode) {
    this.benefitCategoryCode = benefitCategoryCode;
  }

  String getSnils() {
    return snils;
  }

  void setSnils(String snils) {
    this.snils = snils;
  }

  String getNationality() {
    return nationality;
  }

  void setNationality(String nationality) {
    this.nationality = nationality;
  }

  Identity getIdentity() {
    return identity;
  }

  void setIdentity(Identity identity) {
    this.identity = identity;
  }

  Policy getPolicy() {
    return policy;
  }

  void setPolicy(Policy policy) {
    this.policy = policy;
  }

  BirthPlace getBirthPlace() {
    return birthPlace;
  }

  void setBirthPlace(BirthPlace birthPlace) {
    this.birthPlace = birthPlace;
  }

  BirthAct getBirthAct() {
    return birthAct;
  }

  void setBirthAct(BirthAct birthAct) {
    this.birthAct = birthAct;
  }

  List<Parent> getParents() {
    return parents;
  }

  void setParents(List<Parent> parents) {
    this.parents = parents;
  }

  Registration getRegistration() {
    return registration;
  }

  void setRegistration(Registration registration) {
    this.registration = registration;
  }

  BirthCertificate getBirthCertificate() {
    return birthCertificate;
  }

  void setBirthCertificate(BirthCertificate birthCertificate) {
    this.birthCertificate = birthCertificate;
  }

  Client.all(
      String id,
      String firstName,
      String midName,
      String lastName,
      Gender gender,
      DateTime birthDate,
      String registrationAddress,
      String phone,
      String benefitCategoryCode)
      : super.all(id, firstName, midName, lastName) {
    this.gender = gender;
    this.birthDate = birthDate;
    this.registrationAddress = registrationAddress;
    this.phone = phone;
    this.benefitCategoryCode = benefitCategoryCode;
  }

  Client.withoutArgs() : super();

  Client.withId(String id) : super.withId(id);

  @override
  String toString() {
    return 'Client{gender: $_gender, birthDate: $birthDate, phone: $phone, email: $email, registrationAddress: $registrationAddress, registrationSince: $registrationSince, residentialAddress: $residentialAddress, legalRepresentative: $legalRepresentative, benefitCategoryCode: $benefitCategoryCode, snils: $snils, nationality: $nationality, identity: $identity, policy: $policy, birthPlace: $birthPlace, birthAct: $birthAct, parents: $parents, registration: $registration, birthCertificate: $birthCertificate}';
  }
}

import 'dart:typed_data';

import 'package:mvp_platform/repository/response/dto/visit_base.dart';

import 'doctor.dart';
import 'medical_organization.dart';

class VisitInfo {
  String controlCardId;
  MedicalOrganization medicalOrganization;
  List<VisitExt> visits;

  VisitInfo.fromJson(Map<String, dynamic> json) {
    controlCardId = json['controlCardId'];
    medicalOrganization =
        MedicalOrganization.fromJson(json['medicalOrganization']);
    visits = (json['visits'] as List).map((i) => VisitExt.fromJson(i)).toList();
  }

  VisitInfo.withOutArgs() {}

  MedicalOrganization getMedicalOrganization() {
    return medicalOrganization;
  }

  void setMedicalOrganization(MedicalOrganization medicalOrganization) {
    this.medicalOrganization = medicalOrganization;
  }

  String getControlCardId() {
    return controlCardId;
  }

  void setControlCardId(String controlCardId) {
    this.controlCardId = controlCardId;
  }

  List<VisitExt> getVisits() {
    return visits;
  }

  void setVisits(List<VisitExt> visits) {
    this.visits = visits;
  }

  VisitInfo(String controlCardId, MedicalOrganization medicalOrganization,
      List<VisitExt> visits) {
    this.controlCardId = controlCardId;
    this.medicalOrganization = medicalOrganization;
    this.visits = visits;
  }

  @override
  String toString() {
    return 'VisitInfo{controlCardId: $controlCardId, medicalOrganization: $medicalOrganization, visits: $visits}';
  }
}

class VisitExt extends VisitBase {
  ByteData rating;
  String status;
  Doctor doctor;

  VisitExt.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    rating = json['rating'];
    status = json['status'];
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
  }

  ByteData getRating() {
    return rating;
  }

  void setRating(ByteData rating) {
    this.rating = rating;
  }

  String getStatus() {
    return status;
  }

  void setStatus(String status) {
    this.status = status;
  }

  Doctor getDoctor() {
    return doctor;
  }

  void setDoctor(Doctor doctor) {
    this.doctor = doctor;
  }

  VisitExt(String id, DateTime planDate, DateTime factDate, String service,
      Doctor doctor, ByteData rating, String status)
      : super.all(id, planDate, factDate, service) {
    ;
    this.rating = rating;
    this.status = status;
    this.doctor = doctor;
  }

  @override
  String toString() {
    return 'VisitExt{rating: $rating, status: $status, doctor: $doctor} ${super.toString()}';
  }
}

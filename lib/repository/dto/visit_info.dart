import 'dart:typed_data';

import 'package:mvp_platform/repository/dto/visit.dart';

import 'doctor.dart';
import 'medical_organization.dart';

class VisitInfo {
  String controlCardId;
  MedicalOrganization medicalOrganization;
  List<VisitExt> visits;

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

  VisitInfo(
      {String controlCardId,
      MedicalOrganization medicalOrganization,
      List<VisitExt> visits}) {
    this.controlCardId = controlCardId;
    this.medicalOrganization = medicalOrganization;
    this.visits = visits;
  }
}

class VisitExt extends Visit {
  Doctor doctor;
  ByteData rating;
  String status;

  Doctor getDoctor() {
    return doctor;
  }

  void setDoctor(Doctor doctor) {
    this.doctor = doctor;
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

  VisitExt(DateTime planDate, DateTime factDate, String service,
      String doctorId, Doctor doctor, ByteData rating, String status)
      : super(
            planDate: planDate,
            factDate: factDate,
            doctorId: doctorId,
            service: service) {
    this.doctor = doctor;
    this.rating = rating;
    this.status = status;
  }
}

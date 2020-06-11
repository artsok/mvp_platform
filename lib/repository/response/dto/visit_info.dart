import 'dart:developer';
import 'dart:typed_data';

import 'package:mvp_platform/repository/response/dto/visit_base.dart';

import 'doctor.dart';
import 'medical_organization.dart';

class VisitInfo {
  String controlCardId;
  MedicalOrganization medicalOrganization;
  List<VisitExt> visits;
  Client client;

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

  Client getClient() {
    return client;
  }

  void setClient(Client client) {
    this.client = client;
  }

  VisitInfo.all(String controlCardId, MedicalOrganization medicalOrganization,
      List<VisitExt> visits, Client client) {
    this.controlCardId = controlCardId;
    this.medicalOrganization = medicalOrganization;
    this.visits = visits;
    this.client = client;
  }

  VisitInfo() {}
}

class VisitExt extends VisitBase {
  ByteData rating;
  String status;
  Doctor doctor;
  Service service;

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

  Service getService() {
    return service;
  }

  void setService(Service service) {
    this.service = service;
  }

  VisitExt(String id, DateTime planDate, DateTime factDate,
      Service service, Doctor doctor, ByteData rating, String status) : super.a(id, planDate, factDate) {
    this.rating = rating;
    this.status = status;
    this.doctor = doctor;
    this.service = service;
  }
}

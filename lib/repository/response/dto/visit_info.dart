import 'dart:typed_data';

import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/service.dart';
import 'package:mvp_platform/repository/response/dto/visit_base.dart';

import 'doctor.dart';
import 'medical_organization.dart';

class VisitInfo {
  String controlCardId;
  MedicalOrganization medicalOrganization;
  List<VisitExt> visits;
  Client client;

  VisitInfo.fromJson(Map<String, dynamic> json) {
    controlCardId =
        json['controlCardId'] != null ? json['controlCardId'] : null;
    medicalOrganization = json['medicalOrganization'] != null
        ? MedicalOrganization.fromJson(json['medicalOrganization'])
        : null;
    visits = (json['visits'] as List).map((i) => VisitExt.fromJson(i)).toList();
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
  }

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

  VisitInfo();

  @override
  String toString() {
    return 'VisitInfo{controlCardId: $controlCardId, medicalOrganization: $medicalOrganization, visits: $visits, client: $client}';
  }
}

class VisitExt extends VisitBase {
  int rating;
  String status;
  Doctor doctor;
  Service service;

  VisitExt.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    rating = json['rating'];
    status = json['status'];
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  int getRating() {
    return rating;
  }

  void setRating(int rating) {
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

  VisitExt(String id, DateTime planDate, DateTime factDate, Service service,
      Doctor doctor, int rating, String status)
      : super.all(id, planDate, factDate) {
    this.rating = rating;
    this.status = status;
    this.doctor = doctor;
    this.service = service;
  }

  @override
  String toString() {
    return 'VisitExt{rating: $rating, status: $status, doctor: $doctor, service: $service}';
  }
}

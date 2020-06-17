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
    controlCardId = json['controlCardId'];
    if (json['medicalOrganization'] != null) {
      medicalOrganization =
          MedicalOrganization.fromJson(json['medicalOrganization']);
    }
    visits = (json['visits'] as List).map((i) => VisitExt.fromJson(i)).toList();
    if (json['client'] != null) {
      client = Client.fromJson(json['client']);
    }
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
  int _rating;
  String _ratingComment;
  String status;
  Doctor doctor;
  Service service;

  VisitExt.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    _rating = json['rating'];
    status = json['status'];
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    ratingComment = json['visit'];
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  int get rating => _rating;

  set rating(int rating) {
    _rating = rating;
    notifyListeners();
  }

  String get ratingComment => _ratingComment;

  set ratingComment(String ratingComment) {
    _ratingComment = ratingComment;
    notifyListeners();
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

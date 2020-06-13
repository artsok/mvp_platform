import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/gos_service.dart';
import 'package:mvp_platform/screens/doctor/doctor_info_screen.dart';
import 'package:mvp_platform/screens/medical_organization/medical_organization_info_screen.dart';
import 'package:mvp_platform/screens/smo/smo_info_screen.dart';

class GosServicesProvider {
  static List<GosService> _services = [
    GosService(
      icon: Icons.business,
      name: 'Выбор медицинского учреждения',
      callback: (ctx) => Navigator.pushNamed(ctx, MedicalOrganizationInfoScreen.routeName),
    ),
    GosService(
      icon: Icons.healing,
      name: 'Запись к врачу',
      callback: (ctx) => Navigator.pushNamed(ctx, DoctorInfoScreen.routeName),
    ),
    GosService(
      icon: Icons.description,
      name: 'Выбор СМО',
      callback: (ctx) => Navigator.pushNamed(ctx, SmoInfoScreen.routeName),
    ),
  ];

  static List<GosService> get items => _services;
}

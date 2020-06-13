import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvp_platform/providers/gos_notifications_provider.dart';
import 'package:mvp_platform/screens/auth_screen.dart';
import 'package:mvp_platform/screens/doctor/doctor_form_screen.dart';
import 'package:mvp_platform/screens/doctor/doctor_info_screen.dart';
import 'package:mvp_platform/screens/doctor/doctor_success_screen.dart';
import 'package:mvp_platform/screens/doctor/doctor_visit_details_screen.dart';
import 'package:mvp_platform/screens/calendar/calendar_screen.dart';
import 'package:mvp_platform/screens/calendar/detailed_event_screen.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/screens/medical_organization/medical_organization_form_screen.dart';
import 'package:mvp_platform/screens/medical_organization/medical_organization_info_screen.dart';
import 'package:mvp_platform/screens/medical_organization/medical_organization_success_screen.dart';
import 'package:mvp_platform/screens/pin_screen.dart';
import 'package:mvp_platform/screens/root_screen.dart';
import 'package:mvp_platform/screens/smo/smo_birth_screen.dart';
import 'package:mvp_platform/screens/smo/smo_form_screen.dart';
import 'package:mvp_platform/screens/smo/smo_info_screen.dart';
import 'package:mvp_platform/screens/test/http_connection_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const locale = 'ru';

void main() {
  runApp(MvpPlatform());
  _addClientIdToSF();
  _addBirthActIdToSF();
}

_addClientIdToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('clientId', "1003");
}

_addBirthActIdToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('birthActId', "11020R390000402017005");
}



class MvpPlatform extends StatefulWidget {
  @override
  _MvpPlatformState createState() => _MvpPlatformState();
}

class _MvpPlatformState extends State<MvpPlatform> {
  final gosNotifications = GosNotifications();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GosNotifications>.value(
          value: gosNotifications,
        ),
      ],
      child: MaterialApp(
        title: 'MVP Platform',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black87,
            ),
            textTheme: TextTheme(
              headline6: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.indigo,
          //'0xFF2763AA'.colorFromHex().,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black87,
          ),
          accentColor: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: RootScreen(),
        initialRoute: '/',
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          PinScreen.routeName: (ctx) => PinScreen(),
          DetailedEventScreen.routeName: (ctx) => DetailedEventScreen(),
          DoctorInfoScreen.routeName: (ctx) => DoctorInfoScreen(),
          DoctorFormScreen.routeName: (ctx) => DoctorFormScreen(),
          DoctorSuccessScreen.routeName: (ctx) => DoctorSuccessScreen(),
          DoctorVisitDetailsScreen.routeName: (ctx) => DoctorVisitDetailsScreen(),
          CalendarScreen.routeName: (ctx) => CalendarScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          MedicalOrganizationInfoScreen.routeName: (ctx) => MedicalOrganizationInfoScreen(),
          MedicalOrganizationFormScreen.routeName: (ctx) => MedicalOrganizationFormScreen(),
          MedicalOrganizationSuccessScreen.routeName: (ctx) => MedicalOrganizationSuccessScreen(),
          RootScreen.routeName: (ctx) => RootScreen(),
          SmoBirthInfoScreen.routeName: (ctx) => SmoBirthInfoScreen(),
          SmoInfoScreen.routeName: (ctx) => SmoInfoScreen(),
          SmoFormScreen.routeName: (ctx) => SmoFormScreen(),
          HttpConnectionScreen.routeName: (ctx) => HttpConnectionScreen(),
        },
      ),
    );
  }

}

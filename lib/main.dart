import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvp_platform/providers/gos_notifications_provider.dart';
import 'package:mvp_platform/screens/auth_screen.dart';
import 'package:mvp_platform/screens/doctor/doctor_info_screen.dart';
import 'package:mvp_platform/screens/hospital/hospital_form_screen.dart';
import 'package:mvp_platform/screens/hospital/hospital_info_screen.dart';
import 'package:mvp_platform/screens/hospital/hospital_success_screen.dart';
import 'package:mvp_platform/screens/smo/smo_birth_screen.dart';
import 'package:mvp_platform/screens/smo/smo_info_screen.dart';
import 'package:mvp_platform/screens/smo/smo_form_screen.dart';
import 'package:mvp_platform/screens/smo/smo_success_screen.dart';
import 'package:mvp_platform/screens/splash_screen.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:mvp_platform/extensions/string_extensions.dart';


void main() => runApp(MvpPlatform());

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
          primarySwatch: Colors.indigo, //'0xFF2763AA'.colorFromHex().,
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
        home: SplashScreen(),
        initialRoute: '/',
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          HospitalInfoScreen.routeName: (ctx) => HospitalInfoScreen(),
          HospitalFormScreen.routeName: (ctx) => HospitalFormScreen(),
          SmoBirthInfoScreen.routeName: (ctx) => SmoBirthInfoScreen(),
          SmoInfoScreen.routeName: (ctx) => SmoInfoScreen(),
          SmoFormScreen.routeName: (ctx) => SmoFormScreen(),
          SplashPage.routeName: (ctx) => SplashScreen(),
          SuccessfullSmoScreen.routeName: (ctx) => SuccessfullSmoScreen(),
          SuccessfulHospitalScreen.routeName: (ctx) => SuccessfulHospitalScreen(),
          DoctorInfoScreen.routeName: (ctx) => DoctorInfoScreen(),
        },
      ),
    );
  }
}
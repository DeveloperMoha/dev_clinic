import 'package:devclinic/presentation/add_reservation/add_reservation_view.dart';
import 'package:devclinic/presentation/doctor/add_doctor_view.dart';
import 'package:devclinic/presentation/doctor/doctor_view.dart';
import 'package:devclinic/presentation/home/home_view.dart';
import 'package:devclinic/presentation/patient/patient_view.dart';
import 'package:devclinic/presentation/splash/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String homeRoute = "/home";
  static const String addReservationRoute = "/home/addReservation";
  static const String doctor = "/home/doctor";
  static const String addDoctor = "/home/doctor/addDoctor";
  static const String patient = "/home/patient";
  static const String addPatient = "/home/patient/addPatient";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.addReservationRoute:
        return MaterialPageRoute(builder: (_) => const AddReservationScreen());
      case Routes.doctor:
        return MaterialPageRoute(builder: (_) => const DoctorScreen());
      case Routes.addDoctor:
        return MaterialPageRoute(builder: (_) => AddDoctorScreen());
      case Routes.patient:
        return MaterialPageRoute(builder: (_) => const PatientScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}

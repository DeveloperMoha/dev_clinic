import 'package:devclinic/presentation/add_reservation/add_reservation_view.dart';
import 'package:devclinic/presentation/doctor/add_doctor_view.dart';
import 'package:devclinic/presentation/doctor/doctor_view.dart';
import 'package:devclinic/presentation/home/home_view.dart';
import 'package:devclinic/presentation/splash/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String homeRoute = "/home";
  static const String addReservationRoute = "/addReservation";
  static const String doctor = "/doctor";
  static const String addDoctor = "/addDoctor";
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
      default:
        return MaterialPageRoute(builder: (_) => const DoctorScreen());
    }
  }
}

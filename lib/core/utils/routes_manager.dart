import 'package:devclinic/presentation/add_reservation/add_reservation_view.dart';
import 'package:devclinic/presentation/home/home_view.dart';
import 'package:devclinic/presentation/splash/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String homeRoute = "/home";
  static const String addReservationRoute = "/addReservation";
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
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}

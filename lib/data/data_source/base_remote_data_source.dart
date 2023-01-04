import 'package:devclinic/data/models/patient_model.dart';
import 'package:devclinic/domain/entities/adding_reservation.dart';
import 'package:devclinic/domain/entities/patient.dart';

import '../../domain/entities/reservations.dart';

abstract class BaseHomeRemoteDataSource {
  Future<List<Reservations>> getAllReservations(String date);
}

abstract class BasePatientRemoteDataSource {
  Future<List<Patient>> getAllPatients();

  Future<int> addNewPatient(Patient patient);
}

abstract class BaseAddReservationRemoteDataSource {
  Future<int> addNewreservation(AddingReservation addingReservation);
}

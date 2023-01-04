import 'package:devclinic/domain/entities/patient.dart';
import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';

abstract class BasePatientRepository {
  Future<Either<Failure, List<Patient>>> getAllPatients();

  //adding new patient will return id of the inserted patient row
  Future<Either<Failure, int>> addNewPatient(Patient patient);
}

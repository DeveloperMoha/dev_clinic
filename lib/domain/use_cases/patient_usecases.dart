import 'package:devclinic/domain/repository/base_patient_repository.dart';
import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/patient.dart';

class PatientUseCases {
  BasePatientRepository basePatientRepository;
  PatientUseCases({
    required this.basePatientRepository,
  });
  Future<Either<Failure, List<Patient>>> getAllPatients() async {
    return await basePatientRepository.getAllPatients();
  }

  Future<Either<Failure, int>> addNewPatient(Patient patient) async {
    return await basePatientRepository.addNewPatient(patient);
  }

  Future<Either<Failure, List<Patient>>> getPatientsOrederdBy(
      String order) async {
    return await basePatientRepository.getPatientsOrederdBy(order);
  }
}

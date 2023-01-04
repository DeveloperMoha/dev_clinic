// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/src/either.dart';

import 'package:devclinic/core/error/failure.dart';
import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/domain/entities/patient.dart';
import 'package:devclinic/domain/repository/base_patient_repository.dart';

import '../../core/error/exception.dart';

class PatientRepository implements BasePatientRepository {
  BasePatientRemoteDataSource basePatientRemoteDataSource;
  PatientRepository({
    required this.basePatientRemoteDataSource,
  });
  @override
  Future<Either<Failure, int>> addNewPatient(Patient patient) async {
    final result = await basePatientRemoteDataSource.addNewPatient(patient);

    try {
      return Right(result);
    } on RemoteDataBaseException catch (failure) {
      return Left(RemoteDataBaseFailure(message: failure.msg));
    }
  }

  @override
  Future<Either<Failure, List<Patient>>> getAllPatients() async {
    final result = await basePatientRemoteDataSource.getAllPatients();

    try {
      return Right(result);
    } on RemoteDataBaseException catch (failure) {
      return Left(RemoteDataBaseFailure(message: failure.msg));
    }
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:devclinic/core/error/failure.dart';
import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/domain/entities/doctor.dart';
import 'package:devclinic/domain/repository/base_doctor_repository.dart';
import 'package:either_dart/either.dart';

import '../../core/error/exception.dart';

class DoctorRepository implements BaseDoctorRepository {
  BaseDoctorRemoteDataSource baseDoctorRemoteDataSource;
  DoctorRepository({
    required this.baseDoctorRemoteDataSource,
  });
  @override
  Future<Either<Failure, int>> addNewDoctor(Doctor doctor) async {
    final result = await baseDoctorRemoteDataSource.addNewDoctor(doctor);

    try {
      return Right(result);
    } on RemoteDataBaseException catch (failure) {
      return Left(RemoteDataBaseFailure(message: failure.msg));
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> getAllDoctors() async {
    final result = await baseDoctorRemoteDataSource.getAllDoctors();

    try {
      return Right(result);
    } on RemoteDataBaseException catch (failure) {
      return Left(RemoteDataBaseFailure(message: failure.msg));
    }
  }

  @override
  Future<Either<Failure, int>> updateDoctor(Doctor doctor) async {
    final result = await baseDoctorRemoteDataSource.updateDoctor(doctor);

    try {
      return Right(result);
    } on RemoteDataBaseException catch (failure) {
      return Left(RemoteDataBaseFailure(message: failure.msg));
    }
  }
}

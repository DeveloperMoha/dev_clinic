import 'package:devclinic/domain/entities/doctor.dart';
import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';

abstract class BaseDoctorRepository {
  Future<Either<Failure, List<Doctor>>> getAllDoctors();

  //adding new doctor will return id of the inserted patient row
  Future<Either<Failure, int>> addNewDoctor(Doctor doctor);

  Future<Either<Failure, int>> updateDoctor(Doctor doctor);
}

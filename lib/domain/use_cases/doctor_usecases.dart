// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devclinic/domain/repository/base_doctor_repository.dart';
import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/doctor.dart';

class DoctorUseCases {
  BaseDoctorRepository baseDoctorRepository;
  DoctorUseCases({
    required this.baseDoctorRepository,
  });

  Future<Either<Failure, List<Doctor>>> getAllDoctors() async {
    return await baseDoctorRepository.getAllDoctors();
  }

  Future<Either<Failure, int>> addNewDoctor(Doctor doctor) async {
    return await baseDoctorRepository.addNewDoctor(doctor);
  }

  Future<Either<Failure, int>> updateDoctor(Doctor doctor) async {
    return await baseDoctorRepository.updateDoctor(doctor);
  }
}

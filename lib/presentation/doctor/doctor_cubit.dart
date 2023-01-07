import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/data/data_source/doctor_remote_data_source.dart';
import 'package:devclinic/data/repository_impl/doctor_repository.dart';
import 'package:devclinic/domain/entities/doctor.dart';
import 'package:devclinic/domain/repository/base_doctor_repository.dart';
import 'package:devclinic/domain/use_cases/doctor_usecases.dart';
import 'package:devclinic/presentation/doctor/doctor_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorCubit extends Cubit<DoctorStates> {
  DoctorCubit(super.initialState) {
    getAllDoctors();
  }

  List<Doctor> doctorDataList = [];
  int addedDoctorId = 0;
  int updatedDoctorId = 0;

  void resetForms(
      nameController, ageController, phoneController, specificatonController) {
    ageController.text = "";
    phoneController.text = "";
    specificatonController.text = "";
    nameController.text = "";
  }

  void getAllDoctors() async {
    emit(LoadingDoctor());

    BaseDoctorRemoteDataSource baseDoctorRemoteDataSource =
        DoctorRemoteDataSource();

    BaseDoctorRepository baseDoctorRepository = DoctorRepository(
        baseDoctorRemoteDataSource: baseDoctorRemoteDataSource);

    DoctorUseCases doctorUseCases =
        DoctorUseCases(baseDoctorRepository: baseDoctorRepository);

    final allDoctorsData = await doctorUseCases.getAllDoctors();
    allDoctorsData.fold((left) {
      print("left");
      emit(ErrorLoadedDoctor());
    }, (right) {
      doctorDataList.clear();
      print("right start");
      for (Doctor doctor in right) {
        doctorDataList.add(
          Doctor(
              id: doctor.id,
              doctorName: doctor.doctorName,
              age: doctor.age,
              phone: doctor.phone,
              specification: doctor.specification),
        );
      }
      emit(LoadedDoctor());
    });
  }

  Future<void> addNewDoctor(Doctor doctor) async {
    emit(LoadingDoctor());

    BaseDoctorRemoteDataSource baseDoctorRemoteDataSource =
        DoctorRemoteDataSource();

    BaseDoctorRepository baseDoctorRepository = DoctorRepository(
        baseDoctorRemoteDataSource: baseDoctorRemoteDataSource);

    DoctorUseCases doctorUseCases =
        DoctorUseCases(baseDoctorRepository: baseDoctorRepository);

    final responseDoctorQuery = await doctorUseCases.addNewDoctor(doctor);

    responseDoctorQuery.fold((left) {
      emit(ErrorLoadedDoctor());
    }, (right) {
      addedDoctorId = right;
      print("test Doctor id inserted : $addedDoctorId");
    });
    emit(LoadedDoctor());
  }

  Future<void> updateDoctor(Doctor doctor) async {
    emit(LoadingDoctor());

    BaseDoctorRemoteDataSource baseDoctorRemoteDataSource =
        DoctorRemoteDataSource();

    BaseDoctorRepository baseDoctorRepository = DoctorRepository(
        baseDoctorRemoteDataSource: baseDoctorRemoteDataSource);

    DoctorUseCases doctorUseCases =
        DoctorUseCases(baseDoctorRepository: baseDoctorRepository);

    final responseDoctorQuery = await doctorUseCases.updateDoctor(doctor);

    responseDoctorQuery.fold((left) {
      emit(ErrorLoadedDoctor());
    }, (right) {
      updatedDoctorId = right;
      print("test Doctor id updated : $addedDoctorId");
    });
    emit(LoadedDoctor());
  }

  void setFields(id, nameController, ageController, phoneController,
      specificatonController, name, age, phone, specification) {
    if (id != 0) {
      ageController.text = age;
      phoneController.text = phone;
      specificatonController.text = specification;
      nameController.text = name;
    }
  }
}

import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/data/data_source/patient_remote_data_source.dart';
import 'package:devclinic/data/repository_impl/patient_repository.dart';
import 'package:devclinic/domain/entities/patient.dart';
import 'package:devclinic/domain/repository/base_patient_repository.dart';
import 'package:devclinic/domain/use_cases/patient_usecases.dart';
import 'package:devclinic/presentation/patient/patient_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientCubit extends Cubit<PatientStates> {
  PatientCubit(super.initialState) {
    getOrderedPatientData();
  }

  List<Patient> orderedPatientDataList = [];

  List<String> orderedData = ["patient_id", "name", "age", "social_statue"];

  int selectedSortIndex = 0;

  void getOrderedPatientData() async {
    String orderBy = orderedData[selectedSortIndex];
    emit(LoadingPatient());

    BasePatientRemoteDataSource basePatientRemoteDataSource =
        PatientRemoteDataSource();

    BasePatientRepository basePatientRepository = PatientRepository(
        basePatientRemoteDataSource: basePatientRemoteDataSource);

    PatientUseCases patientUseCases =
        PatientUseCases(basePatientRepository: basePatientRepository);
    final allPatientsData = await patientUseCases.getPatientsOrederdBy(orderBy);
    allPatientsData.fold((left) {
      print("left");
      emit(ErrorLoadedPatient());
    }, (right) {
      orderedPatientDataList.clear();
      print("right start");
      for (Patient patient in right) {
        orderedPatientDataList.add(
          Patient(
            patientId: patient.patientId,
            patientName: patient.patientName,
            patientAge: patient.patientAge,
            patientAddress: patient.patientAddress,
            patientPhone: patient.patientPhone,
            patientEducation: patient.patientEducation,
            patientSocialStatue: patient.patientSocialStatue,
          ),
        );
      }
      emit(LoadedPatient());
    });
  }

  void changeSelectedIndex(index) {
    selectedSortIndex = index;
    emit(selectedIndexPatient(selectedIndex: selectedSortIndex));
  }
}

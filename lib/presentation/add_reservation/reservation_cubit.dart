import 'dart:ffi';

import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/data/data_source/patient_remote_data_source.dart';
import 'package:devclinic/data/data_source/reservation_remote_data_source.dart';
import 'package:devclinic/data/repository_impl/add_reserv_Repository.dart';
import 'package:devclinic/data/repository_impl/patient_repository.dart';
import 'package:devclinic/domain/entities/adding_reservation.dart';
import 'package:devclinic/domain/entities/patient.dart';
import 'package:devclinic/domain/repository/base_patient_repository.dart';
import 'package:devclinic/domain/repository/base_reservation_repository.dart';
import 'package:devclinic/domain/use_cases/patient_usecases.dart';
import 'package:devclinic/domain/use_cases/reservation_usecases.dart';
import 'package:devclinic/presentation/add_reservation/reservation_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationCubit extends Cubit<ReservationStates> {
  ReservationCubit(super.initialState) {
    reservationTypeValue = reservationType.first;
    reservationCaseValue = reservationCase.first;
    doctorNameValue = doctorNamesList.first;
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    todayDate = selectedDate.toString().substring(0, 10);
    todayTime = selectedTime.toString().substring(10, 15);

    setRestValue();
    getAllPatient();
  }
  late Function mohaFun;
//==========================Controllers
  late int restValue;

  var priceController = TextEditingController();
  var paidController = TextEditingController();
  var restController = TextEditingController();
  var paitientNameController = TextEditingController();
  var paitientAgeController = TextEditingController();
  var paitientPhoneController = TextEditingController();
  var paitientAddressController = TextEditingController();
  var paitientEducationController = TextEditingController();
  var paitientsocialStatueController = TextEditingController();
  var paitientSpecificationController = TextEditingController();
  var paitientMedicineController = TextEditingController();
  var paitientNotesController = TextEditingController();

//==========================
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  late String todayDate;
  late String todayTime;
  List<String> reservationType = [
    'examination',
    'consultation',
    'session',
  ];

  int patientId = 0;
  String patientName = "";
  int reservationId = 0;
  List<Patient> patientAllDataList = [];
  List<String> patientNamesList = [];
  late String reservationTypeValue;

  List<String> reservationCase = <String>['out', 'exist', 'in', 'done'];
  late String reservationCaseValue;

  List<String> doctorNamesList = <String>['sameh', 'dalla', 'hala', 'doaa'];
  late String doctorNameValue;

  void selectReservationType(newVal) {
    reservationTypeValue = newVal;
    emit(ReservationType());
  }

  void selectReseravtionCase(newVal) {
    reservationCaseValue = newVal;
    emit(ReservationCase());
  }

  void selectDoctorNam(newVal) {
    doctorNameValue = newVal;
    emit(DoctorName());
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      todayDate = picked.toString().substring(0, 10);
    }
    emit(SelectDate(todayDate));
    print("date is : $todayDate");
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (picked != null) {
      selectedTime = picked;
      //todayTime = picked.toString().substring(10, 20);
      todayTime = selectedTime.toString().substring(10, 15);
      emit(SelectDate(todayTime));
    }
  }

  void testFun() {
    print(
        "===> Price : ${priceController.text}  int is : ${int.parse(priceController.text)}");
    print("===> paid : ${paidController.text}");
    print("===> rest : ${restController.text}");

    print("===> name : ${paitientNameController.text}");
    print("===> age : ${paitientAgeController.text}");
    print("===> address : ${paitientAddressController.text}");

    print("===> phone : ${paitientPhoneController.text}");
    print("===> educations : ${paitientEducationController.text}");
    print("===> social : ${paitientsocialStatueController.text}");

    print("===> spec : ${paitientSpecificationController.text}");
    print("===> medicine : ${paitientMedicineController.text}");
    print("===> notes : ${paitientNotesController.text}");
  }

  int priceVal = 200;
  int paidVal = 0;
  setRestValue() {
    priceVal = (priceController.text.isEmpty)
        ? 200
        : int.parse(priceController.text.trim());

    paidVal = (paidController.text.isEmpty)
        ? 0
        : int.parse(paidController.text.trim());

    restValue = priceVal - paidVal;
    print("price :${priceVal}   , paid : ${paidVal}   , rest : ${restValue}  ");
    priceController = TextEditingController(text: priceVal.toString());
    paidController = TextEditingController(text: paidVal.toString());
    restController = TextEditingController(text: restValue.toString());
    emit(SetRestValue(priceVal, paidVal, restValue));
  }

  setControllerValues(context, index) {
    var cubitObj = BlocProvider.of<ReservationCubit>(context);
    cubitObj.patientId = cubitObj.patientAllDataList[index].patientId;
    cubitObj.paitientNameController.text =
        cubitObj.patientAllDataList[index].patientName;
    cubitObj.paitientAgeController.text =
        cubitObj.patientAllDataList[index].patientAge.toString();
    cubitObj.paitientAddressController.text =
        cubitObj.patientAllDataList[index].patientAddress;
    cubitObj.paitientPhoneController.text =
        cubitObj.patientAllDataList[index].patientPhone;
    cubitObj.paitientEducationController.text =
        cubitObj.patientAllDataList[index].patientEducation;
    cubitObj.paitientsocialStatueController.text =
        cubitObj.patientAllDataList[index].patientSocialStatue;
  }

  void getAllPatient() async {
    emit(LoadingReservation());
    BasePatientRemoteDataSource basePatientRemoteDataSource =
        PatientRemoteDataSource();

    BasePatientRepository basePatientRepository = PatientRepository(
        basePatientRemoteDataSource: basePatientRemoteDataSource);

    PatientUseCases patientUseCases =
        PatientUseCases(basePatientRepository: basePatientRepository);

    final allPatientData = await patientUseCases.getAllPatients();
    allPatientData.fold((left) {
      print("left");
      emit(ErrorLoadedReservation());
    }, (right) {
      patientAllDataList.clear();
      patientNamesList.clear();
      print("right start");
      for (Patient patient in right) {
        patientAllDataList.add(
          Patient(
              patientId: patient.patientId,
              patientName: patient.patientName,
              patientAge: patient.patientAge,
              patientAddress: patient.patientAddress,
              patientPhone: patient.patientPhone,
              patientEducation: patient.patientEducation,
              patientSocialStatue: patient.patientSocialStatue),
        );
        patientNamesList.add(patient.patientName);
      }
      emit(LoadedReservation());
    });
  }

  Future<void> addNewPatient() async {
    emit(LoadingReservation());
    BasePatientRemoteDataSource basePatientRemoteDataSource =
        PatientRemoteDataSource();

    BasePatientRepository basePatientRepository = PatientRepository(
        basePatientRemoteDataSource: basePatientRemoteDataSource);

    PatientUseCases patientUseCases =
        PatientUseCases(basePatientRepository: basePatientRepository);

    final insertedPatientData = await patientUseCases.addNewPatient(
      Patient(
          patientId: patientId,
          patientName: paitientNameController.text,
          patientAge: int.parse(paitientAgeController.text),
          patientAddress: paitientAddressController.text,
          patientPhone: paitientPhoneController.text,
          patientEducation: paitientEducationController.text,
          patientSocialStatue: paitientsocialStatueController.text),
    );

    insertedPatientData.fold((left) {
      emit(ErrorLoadedReservation());
    }, (right) {
      patientId = right;
      //print("test patient id before : $patientId");
      emit(SelectPaitientId(patientId));
      getAllPatient();
    });
    emit(LoadedReservation());
    //print("test patient id after : $patientId");
  }

  Future<void> addNewReservation() async {
    if (patientId == 0) {
      print("sorry select patient");

      addNewPatient().then((value) => addNewReservation());
    }
    print("patient id already exist is : $patientId");

    emit(LoadingReservation());
    BaseAddReservationRemoteDataSource baseAddReservationRemoteDataSource =
        ReservationRemoteDataSource();
    BaseReservationRepository baseReservationRepository =
        AddReservationRepository(
            baseAddReservationRemoteDataSource:
                baseAddReservationRemoteDataSource);
    ReservationUseCases reservationUseCases = ReservationUseCases(
        baseReservationRepository: baseReservationRepository);
    final insertedReservationData = await reservationUseCases.addNewReservation(
      AddingReservation(
          reservationId: reservationId,
          patientId: patientId,
          type: reservationTypeValue,
          date: todayDate,
          time: todayTime,
          price: int.parse(priceController.text),
          paid: int.parse(paidController.text),
          rest: int.parse(restController.text),
          currentSpecification: paitientSpecificationController.text,
          givenMedicine: paitientMedicineController.text,
          notes: paitientNotesController.text,
          reservationCase: reservationCaseValue),
    );

    insertedReservationData.fold((left) {
      emit(ErrorLoadedReservation());
    }, (right) {
      reservationId = right;
      print("inserted Reservation id is $reservationId");
      getAllPatient();
      emit(LoadedReservation());
    });
  }
}

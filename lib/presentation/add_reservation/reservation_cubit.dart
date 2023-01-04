import 'dart:ffi';

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
    // mohaFun = () {
    //   int priceVal = int.parse(priceController.text);
    //   int paidVal = int.parse(paidController.text);
    //   restValue = priceVal - paidVal;
    //   emit(SetRestValue(restValue));
    // };
    setRestValue();
  }
  late Function mohaFun;
//==========================Controllers
  late int restValue;

  var priceController = TextEditingController();
  var paidController = TextEditingController();
  var restController = TextEditingController();
  final paitientNameController = TextEditingController();
  final paitientAgeController = TextEditingController();
  final paitientPhoneController = TextEditingController();
  final paitientAddressController = TextEditingController();
  final paitientEducationController = TextEditingController();
  final paitientsocialStatueController = TextEditingController();
  final paitientSpecificationController = TextEditingController();
  final paitientMedicineController = TextEditingController();
  final paitientNotesController = TextEditingController();

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
}

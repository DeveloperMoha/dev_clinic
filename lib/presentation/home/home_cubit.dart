import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/data/data_source/home_remote_data_source.dart';
import 'package:devclinic/data/repository_impl/home_repository.dart';
import 'package:devclinic/domain/repository/base_home_repository.dart';
import 'package:devclinic/domain/use_cases/home_usecases.dart';
import 'package:devclinic/presentation/home/home_states.dart';
import 'package:devclinic/presentation/home/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/color_manager.dart';
import '../../domain/entities/reservations.dart';

class HomeCubit extends Cubit<HomeStates> {
  late DateTime selectedDate;
  late String todayDate;
  late String todayTime;
  int selectedBottomIndex = 1;

  List<dynamic> allHomeList = [];

  List<Reservations> examinationList = [];
  List<Reservations> consultationList = [];
  List<Reservations> sessionList = [];

  HomeCubit(super.initialState) {
    selectedDate = DateTime.now();
    todayDate = selectedDate.toString().substring(0, 10);
    todayTime = selectedDate.toString().substring(11, 16);
    print(selectedDate);
    print(todayTime);
    getAllReservations();
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
    emit(ChangeHomeSelectedDate(selectedDate: selectedDate.toString()));
    getAllReservations();
  }

  void changeBottomBarIndex(newVal) {
    selectedBottomIndex = newVal;
    emit(ChangeHomeBottomIndex(bottomIndex: selectedBottomIndex));
  }

  Future<void> dialogBuilder(BuildContext context, int id) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorManager.lightGreyColor,
          title: const Text('Edit patient case'),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                patientCaseEditBtn("out", context, id),
                patientCaseEditBtn("exist", context, id),
                patientCaseEditBtn("in", context, id),
                patientCaseEditBtn("done", context, id),
              ],
            ),
          ],
        );
      },
    );
  }

  void editPatientCase(String value, int id) {
    int length = allHomeList[selectedBottomIndex];
    for (int i = 0; i < length; i++) {
      if (allHomeList[selectedBottomIndex][i].id == id) {
        print("equal");
      } else {
        print("not equal");
      }
    }
  }

  void getAllReservations() async {
    emit(LoadingHome());
    BaseHomeRemoteDataSource baseHomeRemoteDataSource = HomeRemoteDataSource();
    BaseHomeRepository baseHomeRepository =
        HomeRepository(baseHomeRemoteDataSource: baseHomeRemoteDataSource);
    HomeUseCases homeUseCases =
        HomeUseCases(baseHomeRepository: baseHomeRepository);
    final allReservationData = await homeUseCases.getAllReservations(todayDate);

    allReservationData.fold((left) {
      allHomeList.add(consultationList);
      allHomeList.add(examinationList);
      allHomeList.add(sessionList);
      print("left");
      emit(ErrorLoadedHome());
    }, (right) {
      examinationList.clear();
      consultationList.clear();
      sessionList.clear();
      allHomeList.clear();
      print("right start");
      for (Reservations reservation in right) {
        if (reservation.type == "examination") {
          print("type is examination");
          examinationList.add(
            Reservations(
                reservationId: reservation.reservationId,
                patientName: reservation.patientName,
                type: reservation.type,
                date: reservation.date,
                time: reservation.time,
                price: reservation.price,
                paid: reservation.paid,
                rest: reservation.rest,
                currentSpecification: reservation.currentSpecification,
                givenMedicine: reservation.givenMedicine,
                notes: reservation.notes,
                reservationCase: reservation.reservationCase),
          );
        } else if (reservation.type == "consultation") {
          print("type is consultation");
          consultationList.add(
            Reservations(
                reservationId: reservation.reservationId,
                patientName: reservation.patientName,
                type: reservation.type,
                date: reservation.date,
                time: reservation.time,
                price: reservation.price,
                paid: reservation.paid,
                rest: reservation.rest,
                currentSpecification: reservation.currentSpecification,
                givenMedicine: reservation.givenMedicine,
                notes: reservation.notes,
                reservationCase: reservation.reservationCase),
          );
        } else if (reservation.type == "session") {
          print("type is session");
          sessionList.add(
            Reservations(
                reservationId: reservation.reservationId,
                patientName: reservation.patientName,
                type: reservation.type,
                date: reservation.date,
                time: reservation.time,
                price: reservation.price,
                paid: reservation.paid,
                rest: reservation.rest,
                currentSpecification: reservation.currentSpecification,
                givenMedicine: reservation.givenMedicine,
                notes: reservation.notes,
                reservationCase: reservation.reservationCase),
          );
        } else {
          print("type is unknown");
        }
      }
      //print("right 1");
      allHomeList = [consultationList, examinationList, sessionList];
      // print("right 2");
      // print("${examinationList[0].patientName} ,, ${examinationList[0].price}");
      // print(
      //     "${consultationList[0].patientName} ,, ${consultationList[0].price}");
      // print("${sessionList[0].patientName} ,, ${sessionList[0].price}");

      emit(LoadedHome());
    });
  }
}

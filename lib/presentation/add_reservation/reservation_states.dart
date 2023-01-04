import 'package:flutter/cupertino.dart';

abstract class ReservationStates {}

class IntialReservationState extends ReservationStates {}

class LoadingReservation extends ReservationStates {}

class LoadedReservation extends ReservationStates {}

class ErrorLoadedReservation extends ReservationStates {}

class ReservationType extends ReservationStates {}

class ReservationCase extends ReservationStates {}

class DoctorName extends ReservationStates {}

class SelectDate extends ReservationStates {
  String selectedDate;

  SelectDate(this.selectedDate);
}

class SelectTime extends ReservationStates {
  String selectedTime;

  SelectTime(this.selectedTime);
}

class SetRestValue extends ReservationStates {
  int priceValue;
  int paidValue;
  int restValue;
  SetRestValue(this.priceValue, this.paidValue, this.restValue);
}

class SelectPaitientId extends ReservationStates {
  int paitientId;

  SelectPaitientId(this.paitientId);
}

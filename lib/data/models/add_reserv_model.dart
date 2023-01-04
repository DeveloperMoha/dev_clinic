import 'package:devclinic/domain/entities/adding_reservation.dart';

class AddingReservationModel extends AddingReservation {
  AddingReservationModel(
      {required super.reservationId,
      required super.patientId,
      required super.type,
      required super.date,
      required super.time,
      required super.price,
      required super.paid,
      required super.rest,
      required super.currentSpecification,
      required super.givenMedicine,
      required super.notes,
      required super.reservationCase});

  static List<dynamic> toMySql(AddingReservation addingReservation) => [
        addingReservation.patientId,
        addingReservation.type,
        addingReservation.date,
        addingReservation.time,
        addingReservation.price,
        addingReservation.paid,
        addingReservation.rest,
        addingReservation.currentSpecification,
        addingReservation.givenMedicine,
        addingReservation.notes,
        addingReservation.reservationCase,
      ];
}

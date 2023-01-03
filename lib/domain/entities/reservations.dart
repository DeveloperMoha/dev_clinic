// ignore_for_file: public_member_api_docs, sort_constructors_first
class Reservations {
  int reservationId;
  String patientName;
  String type;
  String date;
  String time;
  int price;
  int paid;
  int rest;
  String currentSpecification;
  String givenMedicine;
  String notes;
  String reservationCase;
  Reservations({
    required this.reservationId,
    required this.patientName,
    required this.type,
    required this.date,
    required this.time,
    required this.price,
    required this.paid,
    required this.rest,
    required this.currentSpecification,
    required this.givenMedicine,
    required this.notes,
    required this.reservationCase,
  });
}

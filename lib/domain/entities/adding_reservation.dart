class AddingReservation {
  int reservationId;
  int patientId;
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
  AddingReservation({
    required this.reservationId,
    required this.patientId,
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

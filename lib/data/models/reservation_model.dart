import '../../domain/entities/reservations.dart';

class ReservationModel extends Reservations {
  ReservationModel(
      {required super.reservationId,
      required super.patientName,
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

  factory ReservationModel.fromMysql(List<dynamic> mysqlObj) =>
      ReservationModel(
          reservationId: mysqlObj[0],
          date: mysqlObj[3],
          time: mysqlObj[4],
          patientName: mysqlObj[12],
          type: mysqlObj[2],
          price: mysqlObj[5],
          paid: mysqlObj[6],
          rest: mysqlObj[7],
          currentSpecification: mysqlObj[8],
          givenMedicine: mysqlObj[9],
          notes: mysqlObj[10],
          reservationCase: mysqlObj[11]);
}

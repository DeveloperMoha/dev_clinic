import 'package:devclinic/domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel(
      {required super.id,
      required super.doctorName,
      required super.age,
      required super.phone,
      required super.specification});

  factory DoctorModel.fromMySql(List<dynamic> mysqlObj) => DoctorModel(
      id: mysqlObj[0],
      doctorName: mysqlObj[1],
      age: mysqlObj[2],
      phone: mysqlObj[3],
      specification: mysqlObj[4]);

  static List<dynamic> toMySql(Doctor doctor) => [
        doctor.doctorName,
        doctor.age,
        doctor.phone,
        doctor.specification,
      ];

  static List<dynamic> toUpdateMySql(Doctor doctor) => [
        doctor.doctorName,
        doctor.age,
        doctor.phone,
        doctor.specification,
        doctor.id,
      ];
}

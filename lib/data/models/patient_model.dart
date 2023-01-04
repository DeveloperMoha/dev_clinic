import 'package:devclinic/domain/entities/patient.dart';

class PatientModel extends Patient {
  PatientModel(
      {required super.patientId,
      required super.patientName,
      required super.patientAge,
      required super.patientAddress,
      required super.patientPhone,
      required super.patientEducation,
      required super.patientSocialStatue});

  factory PatientModel.fromMySql(List<dynamic> mysqlObj) => PatientModel(
      patientId: mysqlObj[0],
      patientName: mysqlObj[1],
      patientAge: mysqlObj[2],
      patientAddress: mysqlObj[3],
      patientPhone: mysqlObj[4],
      patientEducation: mysqlObj[5],
      patientSocialStatue: mysqlObj[6]);

  static List<dynamic> toMySql(Patient patient) => [
        patient.patientName,
        patient.patientAge,
        patient.patientAddress,
        patient.patientPhone,
        patient.patientEducation,
        patient.patientSocialStatue,
      ];
}

import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/data/models/doctor_model.dart';
import 'package:devclinic/domain/entities/doctor.dart';
import 'package:mysql1/mysql1.dart';

import '../../core/error/exception.dart';
import '../../core/utils/app_constants.dart';

class DoctorRemoteDataSource implements BaseDoctorRemoteDataSource {
  @override
  Future<List<Doctor>> getAllDoctors() async {
    List<DoctorModel> responseList = [];
    print("let's start !!");
    try {
      final conn = await MySqlConnection.connect(ConnectionSettings(
        host: AppConstants.connectionHost,
        port: AppConstants.connectionPort,
        user: AppConstants.connectionUser,
        db: AppConstants.connectionDbName,
        password: AppConstants.connectionPass,
      ));

      print("Connection opened");
      var response = await conn.query(AppConstants.getAllDoctorsQuery);
      print("response done");
      for (var row in response) {
        responseList.add(DoctorModel.fromMySql(row));
      }

      await conn.close();
      print("connection closed");
    } catch (error) {
      throw RemoteDataBaseException(msg: error.toString());
    }
    return responseList;
  }

  @override
  Future<int> addNewDoctor(Doctor doctor) async {
    int insertedDoctorId = 0;
    print("let's start !!");
    try {
      final conn = await MySqlConnection.connect(ConnectionSettings(
        host: AppConstants.connectionHost,
        port: AppConstants.connectionPort,
        user: AppConstants.connectionUser,
        db: AppConstants.connectionDbName,
        password: AppConstants.connectionPass,
      ));

      print("Connection opened");
      //  print( "${AppConstants.addNewPatientQuery}${PatientModel.toMySql(patient)}");
      var response = await conn.query(
          AppConstants.addNewDoctorQuery, DoctorModel.toMySql(doctor));

      print("response done");

      insertedDoctorId = response.insertId!;

      print("Data inserted Successfully ,");
      await conn.close();
      print("connection closed");
    } catch (error) {
      throw RemoteDataBaseException(msg: error.toString());
    }
    return insertedDoctorId;
  }

  @override
  Future<int> updateDoctor(Doctor doctor) async {
    int updatedDoctorId = 0;
    print("let's start !!");
    try {
      final conn = await MySqlConnection.connect(ConnectionSettings(
        host: AppConstants.connectionHost,
        port: AppConstants.connectionPort,
        user: AppConstants.connectionUser,
        db: AppConstants.connectionDbName,
        password: AppConstants.connectionPass,
      ));

      print("Connection opened");
      print(
          "${AppConstants.updateDoctorQuery}${DoctorModel.toUpdateMySql(doctor)}");
      var response = await conn.query(
          AppConstants.updateDoctorQuery, DoctorModel.toUpdateMySql(doctor));

      print("response done");

      updatedDoctorId = response.insertId!;

      print("Data updated Successfully ,");
      await conn.close();
      print("connection closed");
    } catch (error) {
      throw RemoteDataBaseException(msg: error.toString());
    }
    return updatedDoctorId;
  }
}

import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/data/models/patient_model.dart';
import 'package:devclinic/domain/entities/patient.dart';
import 'package:mysql1/mysql1.dart';

import '../../core/error/exception.dart';
import '../../core/utils/app_constants.dart';

class PatientRemoteDataSource implements BasePatientRemoteDataSource {
  @override
  Future<int> addNewPatient(Patient patient) async {
    int insertedPatientId = 0;
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
          "${AppConstants.addNewPatientQuery}${PatientModel.toMySql(patient)}");
      var response = await conn.query(
          AppConstants.addNewPatientQuery, PatientModel.toMySql(patient));

      print("response done");

      insertedPatientId = response.insertId!;

      print("Data inserted Successfully ,");
      await conn.close();
      print("connection closed");
    } catch (error) {
      throw RemoteDataBaseException(msg: error.toString());
    }
    return insertedPatientId;
  }

  @override
  Future<List<PatientModel>> getAllPatients() async {
    List<PatientModel> responseList = [];
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
      var response = await conn.query(AppConstants.getAllPatientQuery);
      print("response done");
      for (var row in response) {
        responseList.add(PatientModel.fromMySql(row));
      }

      await conn.close();
      print("connection closed");
    } catch (error) {
      throw RemoteDataBaseException(msg: error.toString());
    }
    return responseList;
  }

  @override
  Future<List<Patient>> getPatientsOrederdBy(String order) async {
    List<PatientModel> responseList = [];
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
      print("${AppConstants.getPatientByOrderedQuery(order)}");
      var response =
          await conn.query(AppConstants.getPatientByOrderedQuery(order));
      print("response done");
      for (var row in response) {
        responseList.add(PatientModel.fromMySql(row));
        print("name is : ${row[1]}");
      }

      await conn.close();
      print("connection closed");
    } catch (error) {
      throw RemoteDataBaseException(msg: error.toString());
    }
    return responseList;
  }
}

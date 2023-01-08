import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/domain/entities/adding_reservation.dart';
import 'package:mysql1/mysql1.dart';

import '../../core/error/exception.dart';
import '../../core/utils/app_constants.dart';
import '../models/add_reserv_model.dart';

class ReservationRemoteDataSource
    implements BaseAddReservationRemoteDataSource {
  @override
  Future<int> addNewreservation(AddingReservation addingReservation) async {
    int insertedReservationId = 0;
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
          "${AppConstants.addNewReservationQuery}${AddingReservationModel.toMySql(addingReservation)}");
      var response = await conn.query(AppConstants.addNewReservationQuery,
          AddingReservationModel.toMySql(addingReservation));

      print("response done");

      insertedReservationId = response.insertId!;

      print("Data inserted Successfully ,");
      await conn.close();
      print("connection closed");
    } catch (error) {
      throw RemoteDataBaseException(msg: error.toString());
    }
    return insertedReservationId;
  }
}

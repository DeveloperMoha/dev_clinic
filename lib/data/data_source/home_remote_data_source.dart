import 'package:devclinic/core/error/exception.dart';
import 'package:devclinic/core/utils/app_constants.dart';
import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/data/models/reservation_model.dart';
import 'package:mysql1/mysql1.dart';

import '../../domain/entities/reservations.dart';

class HomeRemoteDataSource implements BaseHomeRemoteDataSource {
  @override
  Future<List<Reservations>> getAllReservations() async {
    List<ReservationModel> responseList = [];
    print("let's start !!");
    try {
      final conn = await MySqlConnection.connect(ConnectionSettings(
          host: AppConstants.connectionHost,
          port: AppConstants.connectionPort,
          user: AppConstants.connectionUser,
          db: AppConstants.connectionDbName,
          password: AppConstants.connectionPass));

      print("Connection opened");
      var response = await conn.query(AppConstants.getAllReservationQuery);
      print("response done");
      for (var row in response) {
        print('Name: ${row[0]}, email: ${row[1]}');
        responseList.add(ReservationModel.fromMysql(row));
      }

      await conn.close();
      print("connection closed");
    } catch (error) {
      throw RemoteDataBaseException(msg: error.toString());
    }
    return responseList;
  }
}

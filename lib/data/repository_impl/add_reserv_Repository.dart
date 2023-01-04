// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:devclinic/core/error/failure.dart';
import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/domain/entities/adding_reservation.dart';
import 'package:either_dart/either.dart';

import '../../core/error/exception.dart';
import '../../domain/repository/base_reservation_repository.dart';

class AddReservationRepository implements BaseReservationRepository {
  BaseAddReservationRemoteDataSource baseAddReservationRemoteDataSource;
  AddReservationRepository({
    required this.baseAddReservationRemoteDataSource,
  });
  @override
  Future<Either<Failure, int>> addNewReservation(
      AddingReservation addingReservation) async {
    final result = await baseAddReservationRemoteDataSource
        .addNewreservation(addingReservation);

    try {
      return Right(result);
    } on RemoteDataBaseException catch (failure) {
      return Left(RemoteDataBaseFailure(message: failure.msg));
    }
  }
}

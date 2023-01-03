// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devclinic/core/error/exception.dart';
import 'package:devclinic/core/error/failure.dart';
import 'package:devclinic/data/data_source/base_remote_data_source.dart';
import 'package:devclinic/domain/repository/base_home_repository.dart';
import 'package:either_dart/either.dart';

import '../../domain/entities/reservations.dart';

class HomeRepository implements BaseHomeRepository {
  BaseHomeRemoteDataSource baseHomeRemoteDataSource;
  HomeRepository({
    required this.baseHomeRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<Reservations>>> getAllReservations() async {
    final result = await baseHomeRemoteDataSource.getAllReservations();

    try {
      return Right(result);
    } on RemoteDataBaseException catch (failure) {
      return Left(RemoteDataBaseFailure(message: failure.msg));
    }
  }
}

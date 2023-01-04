// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devclinic/domain/repository/base_home_repository.dart';
import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/reservations.dart';

class HomeUseCases {
  BaseHomeRepository baseHomeRepository;
  HomeUseCases({
    required this.baseHomeRepository,
  });

  Future<Either<Failure, List<Reservations>>> getAllReservations(
      String date) async {
    return await baseHomeRepository.getAllReservations(date);
  }
}

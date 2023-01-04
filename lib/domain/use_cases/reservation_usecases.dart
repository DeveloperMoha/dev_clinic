// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devclinic/domain/repository/base_reservation_repository.dart';
import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/adding_reservation.dart';

class ReservationUseCases {
  BaseReservationRepository baseReservationRepository;
  ReservationUseCases({
    required this.baseReservationRepository,
  });

  Future<Either<Failure, int>> addNewReservation(
      AddingReservation addingReservation) async {
    return await baseReservationRepository.addNewReservation(addingReservation);
  }
}

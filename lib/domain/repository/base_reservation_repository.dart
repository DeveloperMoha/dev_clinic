import 'package:devclinic/domain/entities/adding_reservation.dart';
import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';

abstract class BaseReservationRepository {
  Future<Either<Failure, int>> addNewReservation(
      AddingReservation addingReservation);
}

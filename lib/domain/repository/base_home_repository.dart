import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/reservations.dart';

abstract class BaseHomeRepository {
  Future<Either<Failure, List<Reservations>>> getAllReservations(String date);
}

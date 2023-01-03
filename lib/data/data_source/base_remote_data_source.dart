import '../../domain/entities/reservations.dart';

abstract class BaseHomeRemoteDataSource {
  Future<List<Reservations>> getAllReservations();
}

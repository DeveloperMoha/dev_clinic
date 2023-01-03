import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message);
}

class RemoteDataBaseFailure extends Failure {
  const RemoteDataBaseFailure({required String message}) : super(message);
}

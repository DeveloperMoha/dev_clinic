import '../network/err_msg_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;
  ServerException({
    required this.errorMessageModel,
  });
}

class RemoteDataBaseException implements Exception {
  final String msg;
  RemoteDataBaseException({
    required this.msg,
  });
}

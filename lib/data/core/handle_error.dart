import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_freezed/domain/core/app_errors.dart';
import 'package:test_freezed/utils/logger.dart';

Either<AppError, T> handleDioError<T>(DioError e) {
  logger.e(e.response);
  if (e.message.toString().contains("SocketException")) {
    return left(AppError.socket);
  } else {
    String error = e.response!.data["error"]["message"];
    if (error.contains("quota")) {
      return left(AppError.quotaExceeds);
    }
    return left(AppError.unexpected);
  }
}

String getErrorMessage(AppError error) {
  switch (error) {
    case AppError.socket:
      return "socket";
    case AppError.quotaExceeds:
      return "Vous avez dépassé votre quota actuel.";
    case AppError.unexpected:
      return "Une erreur inattendue s'est produite. Veuillez rééssayer!";
    case AppError.notAllowed:
      return "Combinaison email-mot de passe invalide.";
    case AppError.nullLocalDb:
      return "Une erreur inattendue s'est produite.";
    default:
      throw (UnimplementedError("Unknow error $error"));
  }
}

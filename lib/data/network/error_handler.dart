import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'failure.dart';

class ErrorHandler implements Exception{
  late Failure failure;
  ErrorHandler.handle(dynamic error)
  {
    if(error is DioError) //dio error so its an error from response or from dio itself
      {
        failure= _handleError(error);
      }
    else
      {
        failure =DataSource.Default.getFailure();
      }
  }

}

Failure _handleError(DioError error)
{
  switch(error.type) {
    case DioErrorType.connectionTimeout:
      return DataSource.connectTimeOut.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.receiveTimeOut.getFailure();
    case DioErrorType.badCertificate:
      return DataSource.internalServerError.getFailure();
    case DioErrorType.badResponse:
      if(error.response!.statusCode != null && error.response!.statusMessage != null)
        {
          return Failure(error.response!.statusCode!, error.response!.statusMessage!);
        }
      else
        {
          return DataSource.Default.getFailure();
        }
    case DioErrorType.cancel:
      return DataSource.cancel.getFailure();
    case DioErrorType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioErrorType.unknown:
      return DataSource.Default.getFailure();
  }
}



enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorized,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  Default,
}

  class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unAuthorized = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, not found

  // local status code
  static const int connectTimeOut = -1; //
  static const int cancel = -2; //
  static const int receiveTimeOut = -3; //
  static const int sendTimeOut = -4; //
  static const int cacheError = -5; //
  static const int noInternetConnection = -6; //
  static const int Default = -7; //
}
extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unAuthorized:
        return Failure(ResponseCode.unAuthorized, ResponseMessage.unAuthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeOut:
        return Failure(
            ResponseCode.connectTimeOut, ResponseMessage.connectTimeOut);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeOut:
        return Failure(
            ResponseCode.receiveTimeOut, ResponseMessage.receiveTimeOut);
      case DataSource.sendTimeOut:
        return Failure(ResponseCode.sendTimeOut, ResponseMessage.sendTimeOut);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.Default:
        return Failure(ResponseCode.Default,
            ResponseMessage.Default);
    }
  }
}

class ResponseMessage {
  static String success = AppStrings.success.tr(); // success with data
  static String noContent =
      AppStrings.success.tr(); // success with no data (no content)
  static String badRequest =
      AppStrings.badRequestError.tr(); // failure, API rejected request
  static String unAuthorized =
      AppStrings.unauthorizedError.tr(); // failure, user is not authorised
  static String forbidden =
      AppStrings.forbiddenError.tr(); //  failure, API rejected request
  static String internalServerError =
      AppStrings.internalServerError.tr();
  static String notFound =
      AppStrings.notFoundError.tr(); // failure, crash in server side// failure, crash in server side

  // local status code
  static String connectTimeOut = AppStrings.timeoutError.tr();
  static String cancel = AppStrings.defaultError.tr();
  static String receiveTimeOut = AppStrings.timeoutError.tr();
  static String sendTimeOut = AppStrings.timeoutError.tr();
  static String cacheError = AppStrings.cacheError.tr();
  static String noInternetConnection =
      AppStrings.noInternetError.tr();
  static String Default = AppStrings.defaultError.tr();
}

class ApiInternalStatus{
  static const int success = 0;
  static const int failure = 1;
}
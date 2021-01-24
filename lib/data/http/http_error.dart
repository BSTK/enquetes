import 'dart:io';

enum HttpError {
  notFound,
  badRequest,
  serverError,
  unauthorized,
  forbidden,
  invalidData
}

final httpErrorsMapStatusCode = Map.from({
  HttpStatus.notFound: HttpError.notFound,
  HttpStatus.forbidden: HttpError.forbidden,
  HttpStatus.badRequest: HttpError.badRequest,
  HttpStatus.unauthorized: HttpError.unauthorized,
  HttpStatus.internalServerError: HttpError.serverError
});

class AppException implements Exception {
  final message;
  final prefix;

  AppException({this.message, this.prefix});

  String toString() {
    return "$prefix$message";
  }
}

class BadConnectionException extends AppException {
  BadConnectionException([message])
      : super(message: message, prefix: "Network Connection Error: ");
}

class BadRequestException extends AppException {
  BadRequestException([message])
      : super(message: message, prefix: "Invalid Request: ");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([message])
      : super(message: message, prefix: "Unauthorized: ");
}

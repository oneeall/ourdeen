/// Network exception types for API errors.
enum NetworkErrorType {
  networkUnavailable,
  requestTimeout,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  serverError,
  unknown,
}

/// Custom exception for network-related errors.
class NetworkException implements Exception {
  final NetworkErrorType type;
  final String message;
  final int? statusCode;

  const NetworkException({
    required this.type,
    required this.message,
    this.statusCode,
  });

  factory NetworkException.networkUnavailable([String? message]) {
    return NetworkException(
      type: NetworkErrorType.networkUnavailable,
      message: message ?? 'No internet connection available',
    );
  }

  factory NetworkException.requestTimeout([String? message]) {
    return NetworkException(
      type: NetworkErrorType.requestTimeout,
      message: message ?? 'Request timeout',
    );
  }

  factory NetworkException.badRequest([String? message]) {
    return NetworkException(
      type: NetworkErrorType.badRequest,
      message: message ?? 'Bad request',
      statusCode: 400,
    );
  }

  factory NetworkException.unauthorized([String? message]) {
    return NetworkException(
      type: NetworkErrorType.unauthorized,
      message: message ?? 'Unauthorized',
      statusCode: 401,
    );
  }

  factory NetworkException.forbidden([String? message]) {
    return NetworkException(
      type: NetworkErrorType.forbidden,
      message: message ?? 'Forbidden',
      statusCode: 403,
    );
  }

  factory NetworkException.notFound([String? message]) {
    return NetworkException(
      type: NetworkErrorType.notFound,
      message: message ?? 'Resource not found',
      statusCode: 404,
    );
  }

  factory NetworkException.serverError([String? message, int? statusCode]) {
    return NetworkException(
      type: NetworkErrorType.serverError,
      message: message ?? 'Server error occurred',
      statusCode: statusCode ?? 500,
    );
  }

  factory NetworkException.fromStatusCode(int statusCode, String? message) {
    switch (statusCode) {
      case 400:
        return NetworkException.badRequest(message);
      case 401:
        return NetworkException.unauthorized(message);
      case 403:
        return NetworkException.forbidden(message);
      case 404:
        return NetworkException.notFound(message);
      case 408:
        return NetworkException.requestTimeout(message);
      case >= 500 && < 600:
        return NetworkException.serverError(message, statusCode);
      default:
        return NetworkException(
          type: NetworkErrorType.unknown,
          message: message ?? 'Unknown error occurred',
          statusCode: statusCode,
        );
    }
  }

  @override
  String toString() => message;
}

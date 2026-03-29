import 'package:equatable/equatable.dart';

/// Type-safe wrapper for API responses.
///
/// Provides a consistent interface for handling success and failure states
/// from API calls.
class ApiResponse<T> extends Equatable {
  /// Whether the request was successful.
  final bool success;

  /// The response data on success.
  final T? data;

  /// Error message on failure.
  final String? error;

  /// HTTP status code.
  final int? statusCode;

  const ApiResponse({
    required this.success,
    this.data,
    this.error,
    this.statusCode,
  });

  /// Creates a successful response with data.
  factory ApiResponse.success(T data, [int statusCode = 200]) {
    return ApiResponse(
      success: true,
      data: data,
      statusCode: statusCode,
    );
  }

  /// Creates a failure response with error message.
  factory ApiResponse.failure(String error, [int statusCode = 500]) {
    return ApiResponse(
      success: false,
      error: error,
      statusCode: statusCode,
    );
  }

  /// Creates a loading state response.
  factory ApiResponse.loading() {
    return const ApiResponse(
      success: false,
    );
  }

  /// Returns true if the response is in loading state.
  bool get isLoading => !success && data == null && error == null;

  @override
  List<Object?> get props => [success, data, error, statusCode];
}

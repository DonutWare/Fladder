import 'package:chopper/chopper.dart';

class ApiError {
  final int? statusCode;
  final String? reason;
  final String message;

  ApiError({this.statusCode, this.reason, required this.message});

  @override
  String toString() {
    final statusPart = statusCode != null ? '($statusCode) ' : '';
    final reasonPart = reason != null ? '$reason: ' : '';
    return statusPart + reasonPart + message;
  }
}

class ApiResult<T> {
  final T? data;
  final ApiError? error;

  const ApiResult._({this.data, this.error});

  factory ApiResult.success(T? data) => ApiResult._(data: data);

  factory ApiResult.failure(ApiError error) => ApiResult._(error: error);

  bool get isSuccess => error == null;

  String get errorMessage => error?.toString() ?? '';
}

extension ResponseFutureExtensions<T> on Future<Response<T>> {
  Future<ApiResult<T>> get apiResult async {
    try {
      final response = await this;
      if (response.isSuccessful) {
        return ApiResult.success(response.body);
      }

      final reason = response.base.reasonPhrase;
      final body = response.body?.toString() ?? response.error?.toString() ?? 'Unknown error';
      return ApiResult.failure(ApiError(
        statusCode: response.base.statusCode,
        reason: reason,
        message: body,
      ));
    } catch (e) {
      return ApiResult.failure(ApiError(message: e.toString()));
    }
  }
}

extension ResponseExtensions<T> on Response<T> {
  ApiResult<T> get apiResult {
    if (isSuccessful) {
      final responseBody = body;
      if (responseBody is T) {
        return ApiResult.success(responseBody as T);
      }

      return ApiResult.success(null);
    } else {
      final reason = base.reasonPhrase;
      final body = this.body?.toString() ?? error?.toString() ?? 'Unknown error';
      return ApiResult.failure(ApiError(
        statusCode: base.statusCode,
        reason: reason,
        message: body,
      ));
    }
  }
}

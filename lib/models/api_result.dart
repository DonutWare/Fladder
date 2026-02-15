import 'package:chopper/chopper.dart';

class ApiError {
  final int? statusCode;
  final String message;

  ApiError({this.statusCode, required this.message});

  @override
  String toString() => (statusCode != null ? '($statusCode) ' : '') + message;
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

      final body = response.body?.toString() ?? response.base.reasonPhrase ?? '';
      return ApiResult.failure(ApiError(statusCode: response.base.statusCode, message: body));
    } catch (e) {
      return ApiResult.failure(ApiError(message: e.toString()));
    }
  }
}

extension ResponseExtensions<T> on Response<T> {
  ApiResult<T> get apiResult {
    if (isSuccessful) {
      return ApiResult.success(bodyOrThrow);
    } else {
      final body = this.body?.toString() ?? base.reasonPhrase ?? '';
      return ApiResult.failure(ApiError(statusCode: base.statusCode, message: body));
    }
  }
}

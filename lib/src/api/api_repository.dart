import 'package:dio/dio.dart';


class ApiRepository {
  final String url;
  final Map<String, dynamic> payload;

  ApiRepository({required this.url, required this.payload});

  Dio _dio = Dio();

  Future<void> get({
  Function()? beforeSend,
  Function(dynamic data)? onSuccess,
  Function(dynamic error)? onError,
}) async {
  beforeSend?.call();
  try {
    var response = await _dio.get(url, queryParameters: payload);
    onSuccess?.call(response.data);
  } catch (error) {
    if (error is DioError) {
      // You can handle Dio-specific errors here
      onError?.call(error.response?.data ?? error.message);
    } else {
      onError?.call(error.toString());
    }
  }
}

}

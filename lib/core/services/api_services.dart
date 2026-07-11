import 'package:dio/dio.dart';

class ApiServices {
  ApiServices(this.dio);

  final Dio dio;

  Future<Response> post({
    required dynamic body,
    required String url,
    required String token,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    Response response = await dio.post(
      url,
      data: body,
      options: Options(
        contentType: contentType,
        headers: {'Authorization': "Bearer $token", ...headers ?? {}},
      ),
    );

    return response;
  }
}

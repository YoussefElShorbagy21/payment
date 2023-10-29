import 'package:dio/dio.dart';
class ApiService
{
final Dio dio = Dio();

final Dio dio2 = Dio(
  BaseOptions(
    baseUrl: 'https://accept.paymob.com/api/',
    headers: {
      'Content-Type': 'application/json',
    },
    receiveDataWhenStatusError: true,
  )
);


  Future<Response> post({required body , required String url , required String token,String? contentType
  ,Map<String,String>? headers ,
  })
  async {
    var response = await dio.post(
        url,
        data: body,
        options: Options(
          contentType: contentType,
            headers: headers ?? {
        'Authorization' : "Bearer $token"
      }
    ));
    return response ;
  }
}
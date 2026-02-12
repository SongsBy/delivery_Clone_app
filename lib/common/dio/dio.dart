import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project01/common/const/data.dart';

final dioProvider = Provider;

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });


  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');


    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');


      final token = await storage.read(key: ACCESS_TOKEN_KEY);


      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');
      final token = await storage.read(key: REFRESH_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

// 2) 응답을 받을때
  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    print('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');
   return super.onResponse(response, handler);
  }


// 3) 에러가 났을때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async{

    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if(refreshToken == null){
      handler.reject(err);
      return;
    }
    //만약 상태 코드가 401 이면...
    final isStatus401 = err.response?.statusCode == 401;
    //내가 새로운 토큰을 발급 받으려다가 에러가 난경우..
    final isPathRefresh = err.requestOptions.path == '/auth/token';



    if(isStatus401 && !isPathRefresh){
      final dio = Dio();
      try{
        final resp = await dio.post('http://$ip/auth/token',
            options: Options(
                headers: {
                  'authorization': 'Bearer $refreshToken',
                }
            )
        );
        final accessToken = resp.data['accessToken'];
        final options= err.requestOptions;

        options.headers.addAll({
          'authorization': 'Bearer $accessToken'
        });
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        final response = await dio.fetch(options);

        return handler.resolve(response);

      }on DioError catch(e){
        return handler.reject(e);
      }
    }
    return super.onError(err, handler);
  }
}
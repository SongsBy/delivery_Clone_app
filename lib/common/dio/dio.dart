import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project01/common/const/data.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1) 요청을 보낼 때 (Pre-processing)
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    // 헤더에 'accessToken': 'true'가 있다면, 실제 토큰으로 치환하는 로직
    if (options.headers['accessToken'] == 'true') {
      // 1. 가짜 헤더 삭제
      options.headers.remove('accessToken');

      // 2. 실제 토큰 가져오기 (I/O 작업이므로 await)
      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 3. Authorization 헤더에 주입
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
  // 2) 응답을 받을떄
  // 3) 에러가 났을때

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../user/provider/auth_provider.dart';
import '../const/data.dart';
import '../secure_storage/secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();


  dio.options.connectTimeout=10000;
  dio.options.connectTimeout=10000;
  dio.options.sendTimeout=10000;
  final storage = ref.watch(secureStorageProvider);
  dio.interceptors.add(CustomInterceptor(storage: storage, ref: ref));
  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({required this.ref, required this.storage});

  // 1)요청을 보낼때
  // 로그로 사용할 수도 있음.
  // 요청을 보내기 전의 상태임.
  //만약에 요청의 header에 accessToken : true라는 값이 있다면
  //실제 토큰을 가져와서 authorization : bearer 의 값을 변경함.
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    //acessToken
    print(options.headers['accessKey']);
    if (options.headers['accessKey'] == 'true') {
      options.headers.remove('accessKey');
      final token = await storage.read(key: CONST_ACCESS_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    // if (options.headers['refreshToken'] == 'true') {
    //   options.headers.remove('refreshToken');
    //   final token = await storage.read(key: REFRESH_TOKEN_KEY);
    //   options.headers.addAll({
    //     'authorization': 'Bearer $token',
    //   });
    // }

    // TODO: implement onRequest
    return super.onRequest(options, handler);
  }

  // 2)응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    // TODO: implement onResponse
    return super.onResponse(response, handler);
  }

// 3)에러가 났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    //401 에러가 났을때 (status code)
    //토큰을 재발급 받는 시도를 하고 토큰이 재발급되면
    //다시 새로운 토큰으로 요청.


    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri} ${err.message} ${err.stackTrace.toString()}');

    //토큰이 없을 경우 로그아웃 처리함.

    try {
      final isStatus401 = err.response?.statusCode == 401;
      if (isStatus401) {
        ref.read(authProvider.notifier).logout();

        await storage.write(key: CONST_ACCESS_KEY, value: null);
      }
    } on DioError catch (e) {
      handler.reject(e);
    }

    //에러 없이 종료할 수 있다.
    // return handler.resolve(response);

    // TODO: implement onError
    return super.onError(err, handler);
  }
}

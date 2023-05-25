
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/login_reponse.dart';
import '../../common/utils/data_utils.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = AuthRepository(dio: dio, baseUrl: 'http://$ip/auth');
  return repository;
});


class AuthRepository {
  final String baseUrl;
  final Dio dio;

//http://wlkfjwe/auth
  AuthRepository({required this.baseUrl, required this.dio});

  Future<LoginResponse> login(
      {required String HSP_TP_CD, required String STF_NO, required String PASSWORD}) async {
    final String serialized = DataUtils.plainToBase64('$HSP_TP_CD:$STF_NO:$PASSWORD');
    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {
          'authorization': 'Basic $serialized',
        },
      ),
    );
    return LoginResponse.fromJson(resp.data);
  }
}
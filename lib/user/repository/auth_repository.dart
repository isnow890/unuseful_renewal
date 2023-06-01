
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/user/model/login_model.dart';
import 'package:unuseful/user/model/user_model.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/utils/data_utils.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = AuthRepository(dio: dio, baseUrl: 'http://$ip');
  return repository;
});


class AuthRepository {
  final String baseUrl;
  final Dio dio;

//http://wlkfjwe/auth
  AuthRepository({required this.baseUrl, required this.dio});

  Future<UserModel> login(
      {required String hspTpCd, required String stfNo, required String password}) async {
    final String serialized = DataUtils.plainToBase64('$stfNo:$password:$hspTpCd');


    print(serialized);
    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {
          'authorization': 'Basic $serialized',
        },
      ),
    );

    print(resp);

    return UserModel.fromJson(resp.data);
  }
}
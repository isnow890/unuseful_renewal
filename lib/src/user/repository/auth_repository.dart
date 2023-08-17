
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/data.dart';
import 'package:unuseful/dio.dart';
import 'package:unuseful/src/user/model/user_model.dart';


import '../../../util/helper/data_utils.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = AuthRepository(dio: dio, baseUrl: '$ip/auth');
  return repository;
});


class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({required this.baseUrl, required this.dio});

  Future<UserModel> login(
      {required String hspTpCd, required String stfNo, required String password}) async {
    final String serialized = DataHelper.plainToBase64('$stfNo:$password:$hspTpCd');

    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {
          'authorization': 'Basic $serialized',
        },
      ),
    );


    return UserModel.fromJson(resp.data);
  }
}
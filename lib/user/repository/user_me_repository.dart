import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/const/data.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import '../../common/dio/dio.dart';
import '../model/user_model.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = UserMeRepository(dio, baseUrl: '$ip/auth');
  return repository;
});

//
// http://$ip/user/me
@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;
  @POST('/getMe')
  @Headers({'accessKey': 'true'})
  Future<UserModel> getMe();

}

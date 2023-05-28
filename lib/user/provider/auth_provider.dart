import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/common/secure_storage/secure_storage.dart';
import 'package:unuseful/common/view/root_tab.dart';
import 'package:unuseful/speciemen/view/speciemen_screen.dart';
import 'package:unuseful/user/provider/user_me_provider.dart';
import '../../common/const/data.dart';
import '../../telephone/view/telephone_main_screen.dart';
import '../model/user_model.dart';
import '../repository/login_variable_provider.dart';
import '../view/login_screen.dart';
import '../view/splash_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    //유저가 로딩중인지 에러가 나는지등등을 알 수 있음
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      //다른 값이 들어올때만 AuthProvider에서 알려줌.
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  // );

  //SplashScreen
  //앱을 처음 시작했을때
  //토큰이 존재하는지 확인하고
  //로그인 스크린으로 보내줄지
  //홈 스크린으로 보내줄지 확인하는 과정이 필요하다.
  String? redirectLogic(_, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';
    //유저 정보가 없는데
    //로그인중이면 그대로 로그인 페이지에 두고
    //만약에 로그인중이 아니라면 로그인 페이지로 이동

    if (user == null) {
      return logginIn ? null : '/login';
    }

    //UserModel
    //사용자 정보가 있는 상태면
    //로그인 중이거나 현재 위치가 SplashScreen이면
    //홈으로 이동

    print(user);

    if (user is UserModel) {
      return logginIn || state.location == '/splash'
          ?
          //null은 원래의 위치를 의미함.
          '/'
          : null;
    }

    //UserModelError
    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }
    return null;
  }

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (contex, state) => RootTab(),
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (context, state) {
            final secure = ref.watch(secureStorageProvider);

            final loginValue = ref.read(loginVariableStateProvider);

            return LoginScreen(loginValue.STF_NO);
          },
        ),
        GoRoute(
          path: '/speciemen',
          name: SpeciemenScreen.routeName,
          builder: (context, state) => SpeciemenScreen(),
        ),
        GoRoute(
          path: '/telephone',
          name: TelePhoneMainScreen.routeName,
          builder: (context, state) => TelePhoneMainScreen(),
        ),
      ];
}

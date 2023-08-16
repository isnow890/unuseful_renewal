import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unuseful/firebase/push_redirection_logic.dart';
import 'package:unuseful/secure_storage/secure_storage.dart';
import 'package:unuseful/src/common/model/model_base.dart';
import 'package:unuseful/src/home/view/home_screen.dart';
import 'package:unuseful/src/hit_schedule/view/hit_schedule_main_screen.dart';
import 'package:unuseful/src/meal/view/meal_screen.dart';
import 'package:unuseful/src/patient/view/patient_screen.dart';
import 'package:unuseful/src/specimen/model/specimen_params.dart';
import 'package:unuseful/src/specimen/view/specimen_result_screen.dart';
import 'package:unuseful/src/telephone/view/telephone_search_screen.dart';
import 'package:unuseful/src/user/provider/user_me_provider.dart';
import 'package:unuseful/theme/component/full_photo.dart';

import '../../src/common/provider/drawer_selector_provider.dart';
import '../../firebase/firebase_module.dart';
import '../../src/specimen/view/specimen_main_screen.dart';
import '../../src/specimen/view/specimen_result_detail_screen.dart';
import '../../src/specimen/view/specimen_search_screen.dart';
import '../../src/telephone/view/telephone_main_screen.dart';
import '../../src/user/model/user_model.dart';
import '../../src/user/view/join_screen.dart';
import '../../src/user/view/login_screen.dart';
import '../../theme/component/splash_screen.dart';
import '../../src/user/provider/joing_now_provider.dart';
import '../../src/user/provider/gloabl_variable_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    //유저가 로딩중인지 에러가 나는지등등을 알 수 있음
    ref.listen<ModelBase?>(userMeProvider, (previous, next) {
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
    print('redirect');
    final ModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';

    print(state);
    //유저 정보가 없는데
    //로그인중이면 그대로 로그인 페이지에 두고
    //만약에 로그인중이 아니라면 로그인 페이지로 이동

    // if (ref.read(joinNowProvider)) {
    //   ref.read(joinNowProvider.notifier).update((state) => false);
    //   return '/join';
    // }

    if (user == null) {
      return logginIn ? null : '/login';
    }

    //UserModel
    //사용자 정보가 있는 상태면
    //로그인 중이거나 현재 위치가 SplashScreen이면
    //홈으로 이동

    print('here');
    print(user);

    if (user is UserModel) {

      print('logginIn' + logginIn.toString());
      if (logginIn || state.location == '/splash') {
        //fcm messaging 토큰 발급 및 저장
        // firebaseMessagingGetMyDeviceTokenAndSave(ref: ref);
        //
        // routerLogicForegroundHitDutyAlarmRef1(ref);

        //null은 원래의 위치를 의미함.
        print('splash');
        return '/';
      }


      print('여기?');

      return null;
    }

    //UserModelError
    if (user is ModelBaseError) {
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
          name: HomeScreen.routeName,
          builder: (contex, state) => HomeScreen(),
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
            final loginValue = ref.read(globalVariableStateProvider);
            return LoginScreen(loginValue.stfNo);
          },
        ),
        GoRoute(
          path: '/specimenMain',
          name: SpecimenMainScreen.routeName,
          builder: (context, state) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ref
                  .read(drawerSelectProvider.notifier)
                  .update((state) => SpecimenMainScreen.routeName);
            });

            return SpecimenMainScreen();
          },
        ),
        GoRoute(
          path: '/meal',
          name: MealScreen.routeName,
          builder: (context, state) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ref
                  .read(drawerSelectProvider.notifier)
                  .update((state) => MealScreen.routeName);
            });

            return MealScreen();
          },
        ),
        GoRoute(
          path: '/patient',
          name: PatientScreen.routeName,
          builder: (context, state) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ref
                  .read(drawerSelectProvider.notifier)
                  .update((state) => PatientScreen.routeName);
            });

            return PatientScreen();
          },
        ),
        GoRoute(
          path: '/telephone',
          name: TelePhoneMainScreen.routeName,
          builder: (context, state) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ref
                  .read(drawerSelectProvider.notifier)
                  .update((state) => TelePhoneMainScreen.routeName);
            });
            return const TelePhoneMainScreen();
          },
        ),
        GoRoute(
          path: '/hitSchedule',
          name: HitScheduleMainScreen.routeName,
          builder: (context, state) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ref
                  .read(drawerSelectProvider.notifier)
                  .update((state) => HitScheduleMainScreen.routeName);
            });

            return HitScheduleMainScreen(
                baseIndex:
                    int.parse(state.queryParameters['baseIndex'] ?? '0'));
          },
        ),
        GoRoute(
          path: '/fullPhoto',
          name: FullPhoto.routeName,
          builder: (context, state) {
            final values = state.extra as List<String>;
            return FullPhoto(
                images: values,
                title: state.queryParameters['title']!,
                currentIndex: int.parse(state.queryParameters['currentIndex']!),
                totalCount: int.parse(
                  state.queryParameters['totalCount']!,
                ));
          },
        ),
        GoRoute(
          path: '/specimenResult',
          name: SpecimenResultScreen.routeName,
          builder: (context, state) {
            // final values = state.extra as SpecimenParams;
            final values = state.extra as SpecimenParams;

            return SpecimenResultScreen(
              params: values,
            );
          },
        ),
        GoRoute(
          path: '/specimenResultDetail',
          name: SpecimenResultDetailScreen.routeName,
          builder: (context, state) {
            // final values = state.extra as SpecimenParams;
            final values = state.extra as SpecimenParams;
            return SpecimenResultDetailScreen(
              params: values,
            );
          },
        ),
        GoRoute(
          path: '/telephoneSearchScreen',
          name: TelephoneSearchScreen.routeName,
          builder: (context, state) => TelephoneSearchScreen(),
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: TelephoneSearchScreen(),
          ),
        ),
        GoRoute(
          path: '/specimenSearchScreen',
          name: SpecimenSearchScreen.routeName,
          builder: (context, state) => SpecimenSearchScreen(
            searchType: state.queryParameters['searchType']!,
          ),
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: SpecimenSearchScreen(
              searchType: state.queryParameters['searchType']!,
            ),
          ),
        ),
        GoRoute(
          path: '/join',
          name: JoinScreen.routeName,
          builder: (context, state) => JoinScreen(),
        ),
      ];

  CustomTransitionPage buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

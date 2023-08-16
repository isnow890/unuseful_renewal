import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:unuseful/router/provider/go_router.dart';

import 'firebase/firebase_options.dart';
import 'theme/component/constrained_screen.dart';
import 'theme/provider/theme_provider.dart';

// _intializeFcmMessagingService() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   firebaseMessagingGetAlarmAuth();
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   // //토큰 갱신될때.
//   // FirebaseMessaging.instance.onTokenRefresh.listen((event) { }).onError((err){});
//   // authorized: 사용자에게 권한이 부여되었습니다.
//   // denied: 사용자가 권한을 거부했습니다.
//   // notDetermined: 사용자가 아직 권한 부여 여부를 선택하지 않았습니다.
//   // provisional: 사용자에게 임시 권한이 부여됩니다.
// }

void main() async {
  //fcm 초기화
  // await _intializeFcmMessagingService();

  //언어 번역
  await initializeDateFormatting();
  runApp(ProviderScope(child: _App()));
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeServiceProvider);
    final router = ref.watch(goRouterProvider);
    // //나머지 fcm 초기화 여기서
    // initializeflutterLocalNotificationsPlugin(ref);

    return Center(
      child: ConstrainedScreen(
        child: MaterialApp.router(
          builder: (context, child) {
            return Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) => child!,
                )
              ],
            );
          },
          routerConfig: router,
          theme: ref.read(themeServiceProvider.notifier).themeData,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

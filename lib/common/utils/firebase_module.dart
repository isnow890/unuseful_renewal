import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unuseful/common/provider/fcm_router_provider.dart';
import 'package:unuseful/common/repository/firestorage_repository.dart';

import '../../user/provider/user_me_provider.dart';
import '../model/fcm_registration_params.dart';

//디바이스 토큰 알아내기

void firebaseMessagingGetMyDeviceTokenAndSave({required WidgetRef ref}) async {
  final token = await FirebaseMessaging.instance.getToken();

  final userMe = ref.read(userMeProvider);

  print("내 디바이스 토큰: $token");
  try {
    await ref.read(firestorageRepositoryProvider).saveFcmToken(
            fcmRegistrationParams: FcmRegistrationParams(
          lastUsedDate: DateTime.now(),
          fcmToken: token,
          isHitDutyAlarm: true,
          isMealAlarm: true,
          sid: sid,
          id: id,
        ));
  } catch (e) {}
}

//iOS를 위하여 권한 요청하기.
firebaseMessagingGetAlarmAuth() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //메시지 요청 권한 획득하기.
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
}

//onDidReceiveNotificationResponse  android & ios foreground
//foreground 순서
//1. FirebaseMessaging.onMessage.listen((RemoteMessage message)
//2. onDidReceiveNotificationResponse: (details) {

//Android Background & Android Terminated & iOS Terminated (안드로이드 백그라운드, 앱 종료 상태 및 iOS 앱 종료 상태)
//순서
//1. FirebaseMessaging.instance.getInitialMessage
//2. onDidReceiveBackgroundNotificationResponse

//navigation 로직 넣어줘야 할 부분

//onDidReceiveNotificationResponse
//backgroundHandler
//FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message)
//await FirebaseMessaging.instance.getInitialMessage()
//_handleMessage

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
late BuildContext buildContext;
late WidgetRef ref;

void initializeflutterLocalNotificationsPlugin(
    BuildContext context, WidgetRef ref) async {
  buildContext = context;
  WidgetRef? ref;

//안드로이드 설정
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', 'High Importance Notifications',
          importance: Importance.max));

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    ),

    //forground2 -> foreground1에서의 payload 데이터가 나오게 됨.
    onDidReceiveNotificationResponse: (details) {
      //화면 navigation
      if (details.payload == 'haha') {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
      }
      if (details.payload == 'hoho') {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
      }
      // 액션 추가...
    },
    onDidReceiveBackgroundNotificationResponse: backgroundHandler,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      ref!.read(fcmRouterProvider.notifier).update((state) => FcmRouterModel(
          page: message.data['page'],
          action: message.data['action'],
          param: message.data['param']));

      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'high_importance_notification',
            importance: Importance.max,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        //payload에서 전달하고자 하는 데이터를 가공해줘야함 foreground1
        // payload: message.data['page']
      );
    }
  });

  //iOS Background (iOS 앱 백그라운드 상태 -> 앱이 완전히 닫혀진 상태는 아니지만 백그라운드에서 작동중...)
  if (Platform.isIOS) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      ref!.read(fcmRouterProvider.notifier).update((state) => FcmRouterModel(
          page: message.data['page'],
          action: message.data['action'],
          param: message.data['param']));

      // 액션 추가 ... 파라미터를 전송하는 경우는 message.data['test_parameter1'] 이런 방식...
    });
  }

  // Android Background & Android Terminated & iOS Terminated (안드로이드 백그라운드, 앱 종료 상태 및 iOS 앱 종료 상태) 1
  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    _handleMessage(message);
    // // 앱이 백그라운드 상태에서 푸시 알림 클릭 하여 열릴 경우 메세지 스트림을 통해 처리
  }
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

//백라운드 상태
void _handleMessage(RemoteMessage message) {
  ref!.read(fcmRouterProvider.notifier).update((state) => FcmRouterModel(
      page: message.data['page'],
      action: message.data['action'],
      param: message.data['param']));
}

@pragma('vm:entry-point')
void backgroundHandler(NotificationResponse details) {
  // 액션 추가... 파라미터는 details.payload 방식으로 전달
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('여긴가');
  RemoteNotification? notification = message.notification;
  // 세부 내용이 필요한 경우 추가...
}

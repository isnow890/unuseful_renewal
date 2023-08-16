import 'package:flutter/cupertino.dart';
import 'package:unuseful/router/provider/go_router.dart';
import 'package:unuseful/theme/component/toast/toast_builder.dart';

abstract class Toast {
  static void show(
    String text, {
    Duration duration = const Duration(seconds: 3),
  }) async {
    GlobalKey<ToastBuilderState> toastKey = GlobalKey();

    BuildContext? context = navigatorKey.currentContext;

    print(context);

    if (context == null) return;

    /// Insert
    final overlay = Overlay.of(context);
    final toast = OverlayEntry(
      builder: (context) => ToastBuilder(
        key: toastKey,
        text: text,
        animDuration: const Duration(milliseconds: 333),
      ),
    );
    overlay.insert(toast);

    //toast가 실행되고 한프레임 실행 된 이후에 callback 메소드 호출됨.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// 코드 작성
      toastKey.currentState?.isShow = true;
    });

    /// Remove
    await Future.delayed(duration);
    toastKey.currentState?.isShow = false;
    await Future.delayed(duration);

    toast.remove();
  }
}

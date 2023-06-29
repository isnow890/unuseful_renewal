import 'package:flutter_riverpod/flutter_riverpod.dart';

final fcmRouterProvider = StateProvider<FcmRouterModel>((ref) => FcmRouterModel(
      page: '',
      action: '',
      param: '',
    ));

class FcmRouterModel {
  final String page;
  final String action;
  final String param;

  FcmRouterModel({
    required this.page,
    required this.action,
    required this.param,
  });

// data.Add("page", "hitSchedule1");
// data.Add("action", "selectDay");
// data.Add("selectedDay", $"{upload.WK_MONTH.Substring(0,4)}-{upload.WK_MONTH.Substring(4, 2)}-01");
}

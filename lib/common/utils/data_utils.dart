import 'dart:convert';

import '../../user/model/user_model.dart';
import '../const/data.dart';

class DataUtils {
  //ADVANCE_TYPE enum으로 변환
  static findAdvanceTypeEnum(String value) =>
      AdvanceType.values.firstWhere((element) => element.name == value);

  static bool toBool(String value) => value == 'Y' ? true : false;

  static String pathToUrl(String value) => 'http://$ip/$value';

//Base64 인코딩
  static String plainToBase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(plain);
    return encoded;
  }

  static DateTime stringToDateTime(String value) {
    return DateTime.parse(value);
  }
}

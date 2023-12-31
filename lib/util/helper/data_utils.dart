import 'dart:convert';
import 'dart:typed_data';

import 'package:unuseful/data.dart';

import '../../src/user/model/user_model.dart';

class DataHelper {
  //ADVANCE_TYPE enum으로 변환
  static findAdvanceTypeEnum(String? value) =>
      AdvancedType.values.firstWhere((element) => element.name == value);

  static bool toBool(String? value) => value == 'Y' ? true : false;

  static String pathToUrl(String? value) => '$ip/$value';

  static String hspTpCdToNm(String value) => value == '01' ? "서울" : "목동";

//Base64 인코딩
  static String plainToBase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(plain);
    return encoded;
  }

  static DateTime stringToDateTime(String value) {
    return DateTime.parse(value);
  }


  static Uint8List base64Decoder(String encodedImage){
    return base64.decode(encodedImage);
  }


  static bool isValidEmail(value){
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }



}

import 'dart:convert';

import '../const/data.dart';

class DataUtils{
  static String pathToUrl(String value)=> 'http://$ip/$value';


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
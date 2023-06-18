import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const CONST_ACCESS_KEY ='ACCESS_KEY';

const CONST_HSP_TP_CD ='HSP_TP_CD';
const CONST_STF_NO = 'STF_NO';
const CONST_PASSWORD = 'PASSWORD';


final emulatorIp = 'https://4303-106-250-199-244.ngrok-free.app';
final simulatorIp = '127.0.0.1:8031';

//런타임에 어떤 운영체제에서 사용중인지 알수 있음.
final ip = Platform.isIOS ? simulatorIp : emulatorIp;


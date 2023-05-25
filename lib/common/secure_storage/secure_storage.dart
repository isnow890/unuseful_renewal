import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unuseful/common/const/data.dart';
import 'package:unuseful/common/model/initial_data_from_secure_storage.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) =>
    FlutterSecureStorage());



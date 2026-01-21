import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';
final storage = FlutterSecureStorage();
//안드로이드 애뮬레이터의 경우 이 ip로 보내야 함
final emulatorIp = '10.0.2.2:3000';
//아이폰 시뮬레이터
final simulatorIp = '127.0.0.1:3000';
//안드로이드 환경과 ios시뮬레이터 환경에서 ip값을 다르게 입력해줘야하는 변수를 막아주는 코드
final ip = Platform.isIOS ? simulatorIp : emulatorIp;
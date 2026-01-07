import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project01/common/const/colors.dart';
import 'package:project01/common/layout/default_layout.dart';

import '../../common/const/component/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final emulatorIp = '10.0.2.2:3000';//안드로이드 애뮬레이터의 경우 이 ip로 보내야 함
    final simulatorIp = '127.0.0.1:3000'; //아이폰 시뮬레이터
    final ip = Platform.isIOS ? simulatorIp : emulatorIp; //안드로이드 환경과 ios시뮬레이터 환경에서 ip값을 다르게 입력해줘야하는 변수를 막아주는 코드

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                SizedBox(height: 16.0),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  onChanged: (String Value) {},
                ),
                SizedBox(height: 16.0),
                CustomTextFormField(
                  hintText: '비밀번호를  입력해주세요',
                  onChanged: (String Value) {},
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: ()async{
                    //ID:비밀번호
                    final rawString ='test@codefactory.ai:testtest';

                    Codec<String , String> stringToBase64 = utf8.fuse(base64);

                    String token = stringToBase64.encode(rawString);

                    final resp  = await dio.post('http://${ip}/auth/login' ,
                        options: Options(
                          headers: {
                            'authorization': 'Basic $token',
                          },

                        )
                    );
                    print(resp.data);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text('로그인', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () async{

                    final refreshtoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTc2Nzc4NTUxNCwiZXhwIjoxNzY3ODcxOTE0fQ.RkUwgh_nYDK1aaXJmX9TOv3M9fx79dngSxbxbq75sDs';

                    final resp  = await dio.post('http://${ip}/auth/token' ,
                        options: Options(
                            headers: {
                              'authorization': 'Bearer $refreshtoken',
                            }
                        )
                    );
                    print(resp.data);
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  child: Text('화원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n 오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(fontSize: 16.0, color: BODY_COLOR),
    );
  }
}

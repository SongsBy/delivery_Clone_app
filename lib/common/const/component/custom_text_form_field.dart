import 'package:flutter/material.dart';
import 'package:project01/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autoFocus = false,
    required this.onChanged,
    super.key});

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: BORDER_COLOR,
        width: 2.0
      ),
    );
    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      //비밀번호 입력할때
      obscureText: obscureText,
      //자동 커서 할당
      autofocus: autoFocus,
      onChanged: onChanged,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        errorText: errorText,
        hintText: hintText,
        hintStyle: TextStyle(
            color: BODY_COLOR,
          fontSize: 14.0,
        ),
        fillColor: INPUT_BG_COLOR,
        filled: true,
        //모든 인풋 상태의 스타일
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          )
        )
      ),
    );
  }
}

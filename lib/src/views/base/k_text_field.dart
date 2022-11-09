import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/styles.dart';

class KTextFiled extends StatelessWidget {
  const KTextFiled(
      {Key? key,
      required this.controller,
      this.hintText,
      this.labelText,
      this.onChanged,
      this.inputType,
      this.inputAction,
      this.suffix,
      this.obscureValue})
      : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final Function(String value)? onChanged;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Widget? suffix;
  final bool? obscureValue;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: 1,
      keyboardType: inputType,
      textInputAction: inputAction,
      obscureText: obscureValue ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: GoogleFonts.roboto(
          textStyle: h4.copyWith(
            color: kGreyDeep1,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: kGreyDeep1,
          ),
        ),
        suffixIcon: suffix,
      ),
    );
  }
}

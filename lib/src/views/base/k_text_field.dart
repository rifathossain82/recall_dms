import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/styles.dart';

class KTextFiled extends StatelessWidget {
  const KTextFiled({
    Key? key,
    required this.controller,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.inputType,
    this.inputAction,
    this.suffix,
    this.obscureValue,
    this.isBorder = true,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final Function(String value)? onChanged;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Widget? suffix;
  final bool? obscureValue;
  final bool isBorder;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
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
        border: isBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kGreyDeep1,
                ),
              )
            : InputBorder.none,
        suffixIcon: suffix,
      ),
    );
  }
}

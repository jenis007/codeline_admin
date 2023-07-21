import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final obscureText;
  final int? maxLines, maxLength;
  final Widget? suffixIcon, prefixIcon;
  final String? fontFamily, hintText;
  final TextInputType? keyboardType;
  final double? inputTextSize, borderRadius, textFieldSize;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap, onEditingComplete;
  final Color? cursorColor, inputTextColor, hintTextColor;
  final List<TextInputFormatter>? formatter;
  final bool? enabled;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged, onFieldSubmitted;

  const CommonTextField({
    Key? key,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines,
    this.textInputAction = TextInputAction.next,
    this.cursorColor,
    this.inputTextColor,
    this.inputTextSize,
    this.fontFamily,
    this.validator,
    this.borderRadius = 10,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.textFieldSize,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.maxLength,
    this.hintTextColor,
    this.formatter,
    this.enabled,
  }) : super(key: key);

  // OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: BorderSide(color: AppColor.grey400));
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      enabled: enabled,
      inputFormatters: formatter,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      maxLength: maxLength,
      validator: validator,
      style: TextStyle(
        color: inputTextColor,
        fontSize: inputTextSize,
        fontFamily: fontFamily,
      ),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText!,
      maxLines: maxLines,
      textInputAction: textInputAction,
      cursorColor: cursorColor,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: BorderSide(color: AppColor.grey400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: BorderSide(color: AppColor.grey400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: BorderSide(color: AppColor.grey400),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: BorderSide(color: AppColor.grey400),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: const BorderSide(color: Colors.red)),
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintTextColor,
            fontSize: inputTextSize,
            fontFamily: fontFamily,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          isDense: true,
          counter: const Offstage(),
          counterText: ''),
    );
  }
}

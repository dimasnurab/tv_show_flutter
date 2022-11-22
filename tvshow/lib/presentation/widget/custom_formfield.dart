import 'package:flutter/material.dart';

import '../../config/config.dart';

class FormfieldCustom extends StatelessWidget {
  const FormfieldCustom({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.textInputAction,
    this.maxLines,
    this.enabled,
    this.minLines,
    this.colorBorder,
    this.colorHint,
    this.colorText,
    this.colorLabel,
    this.colorCursor,
    this.obsecureText = false,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.readOnly = false,
    this.autoFocust,
    this.focusNode,
    this.onchanged,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final Color? colorLabel;
  final Color? colorCursor;

  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obsecureText;
  final String? initialValue;
  final bool readOnly;
  final FocusNode? focusNode;
  final bool? autoFocust;
  final Function(String)? onchanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      autofocus: autoFocust ?? false,
      onChanged: onchanged,
      minLines: minLines,
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      style: TextStyleApp.poppins.copyWith(
        fontSize: 15,
        color: colorText,
      ),
      readOnly: readOnly,
      enabled: enabled,
      obscureText: obsecureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      cursorColor: colorCursor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        prefix: prefix,
        prefixIcon: prefixIcon,
        hintText: hintText,
        suffixIcon: suffixIcon,
        labelStyle: TextStyleApp.poppins.copyWith(
          fontSize: 15,
          color: colorLabel,
        ),
        isDense: true,
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorBorder ?? Colors.black12)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorBorder ?? Colors.black12)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorBorder ?? Colors.black12)),
        hintStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          color: colorHint,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: colorBorder ?? Colors.black12)),
      ),
    );
  }
}

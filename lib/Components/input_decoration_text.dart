import 'package:flutter/material.dart';
import 'package:radium_tech/Utils/colors.dart';

InputDecoration inputDecoration(lableText, hintText) {
  return InputDecoration(
    
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: appColor, style: BorderStyle.solid)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: appColor, style: BorderStyle.solid)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: appColor, style: BorderStyle.solid)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: appColor, style: BorderStyle.solid)),
      labelText: lableText,
      hintText: hintText,
      labelStyle: TextStyle(color: appColor));
}

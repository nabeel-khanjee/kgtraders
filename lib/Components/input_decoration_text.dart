import 'package:flutter/material.dart';
import 'package:radium_tech/Utils/colors.dart';

InputDecoration inputDecoration(lableText, hintText) {
  return InputDecoration(
    
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: appColor, style: BorderStyle.solid)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: appColor, style: BorderStyle.solid)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: appColor, style: BorderStyle.solid)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: appColor, style: BorderStyle.solid)),
      labelText: lableText,
      hintText: hintText,
      // hintStyle: TextStyle(color: appColor),
      labelStyle: TextStyle(color: appColor));
}

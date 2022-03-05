  import 'package:flutter/material.dart';
import 'package:radium_tech/Utils/colors.dart';

BoxDecoration decorationForImageBox() {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: appColor),
        boxShadow: [
          BoxShadow(
            color: appColor.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(150));
  }

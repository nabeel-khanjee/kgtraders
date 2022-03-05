import 'package:flutter/material.dart';
import 'package:radium_tech/Utils/colors.dart';

BoxShadow boxShadowForApp() {
    return BoxShadow(
      color: appColor.withOpacity(0.1),
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(0, 3),
    );
  }
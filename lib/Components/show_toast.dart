import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:radium_tech/Utils/colors.dart';

showToastApp() {
  Fluttertoast.showToast(
    msg: "Successfully Updated",
    backgroundColor: appColor,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}



showToastAppFalse() {
  Fluttertoast.showToast(
    msg: "Something went wrong...",
    backgroundColor: appColor,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}




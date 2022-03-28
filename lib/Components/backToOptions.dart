
import 'package:flutter/material.dart';
import 'package:radium_tech/Utils/colors.dart';

class BackToOptions extends StatelessWidget {
  const BackToOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: appColor)),
      color: appColor.withOpacity(.5),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Icon(
            Icons.arrow_back_ios_outlined,
            size: 13,
            color: textColor,
          ),
          Text(
            "Back To Options",
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}

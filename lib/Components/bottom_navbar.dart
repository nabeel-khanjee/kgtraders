import 'package:flutter/material.dart';
import 'package:radium_tech/Screens/ResidenceForm/myhome.dart';
import 'package:radium_tech/Utils/colors.dart';

class ButtomNavBar extends StatelessWidget {
  const ButtomNavBar({
    Key? key,
    required this.widget,
    required this.onTapBack,
    required this.onTapSave,
  }) : super(key: key);

  final MyHomePageResidence widget;
  final VoidCallback onTapBack;
  final VoidCallback onTapSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MaterialButton(
          onPressed: onTapBack,
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: appColor)),
          color: appColor.withOpacity(.5),
         
          child: Row(
            children: [
               Icon(
                Icons.arrow_back_ios,
                color: textColor,
                size: 15,
              ),
             Text(
                'Back To List',
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: appColor)),
          color: appColor.withOpacity(.5),
          onPressed: onTapSave,
          child: Row(
            children: [
              Text(
                'Submit',
                style: TextStyle(color: textColor),
              ),
              Icon(
                Icons.navigate_next,
                color: textColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

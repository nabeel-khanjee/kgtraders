import 'package:flutter/material.dart';
import 'package:radium_tech/Screens/ResidenceForm/myhome.dart';
import 'package:radium_tech/Utils/colors.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    Key? key,
     this.widget,
    required this.buttonTitle,
    required this.onTap,
    required this.iconData,
  }) : super(key: key);
  final String buttonTitle;
  final VoidCallback onTap;
  final IconData iconData;
  final MyHomePageResidence? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
          borderRadius: BorderRadius.circular(30)),
      child: FlatButton.icon(
        onPressed: onTap,
        icon: Icon(
          iconData,
          color: appColor,
        ),
        label: Text(
          buttonTitle,
          style: TextStyle(color: appColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

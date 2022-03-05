
import 'package:flutter/material.dart';
import 'package:radium_tech/Screens/ResidenceForm/myhome.dart';
import 'package:radium_tech/Utils/colors.dart';

class ButtomNavBar extends StatelessWidget {
  const ButtomNavBar({
    Key? key,
    required this.widget,required this.onTapBack,required  this.onTapSave,
  }) : super(key: key);

  final MyHomePageResidence widget;
  final VoidCallback onTapBack;
  final VoidCallback onTapSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FlatButton.icon(
          onPressed: onTapBack,
          label: Text(
            'Back To List',
            style: TextStyle(color: appColor),
          ),
          icon: Icon(
            Icons.arrow_back_ios,
            color: appColor,
            size: 15,
          ),
        ),
        MaterialButton(
          onPressed: onTapSave,
          child: Row(
        children: [ Text(
            'Submit',
            style: TextStyle(color: appColor),
          ),
          Icon(
            Icons.navigate_next,
            color: appColor,
          ),],    
          ),
          
        ),
      ],
    );
  }
}


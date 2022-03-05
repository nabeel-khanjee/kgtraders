import 'package:flutter/material.dart';

class DropDownDesign extends StatefulWidget {
  const DropDownDesign({Key? key}) : super(key: key);

  @override
  _DropDownDesignState createState() => _DropDownDesignState();
}

class _DropDownDesignState extends State<DropDownDesign> {
  List<DropdownMenuItem<String>> _dropDownPostion() {
    List<String> ddll = [
      "STRIKER",
      "MIDFIELDER",
      "KEEPER",
      "FORWARD",
      "WINGER",
      "DEFENDER"
    ];
    return ddll
        .map((valuee) => DropdownMenuItem(
      value: valuee,
      child: Text(
        valuee,
        style: TextStyle(color: Colors.black,
            fontSize: 15.0
        ),
      ),
    ))
        .toList();
  }
  String? _selectedPosition;
  String hold = '';

  String? dropdownPosition = 'RECRUITERS';
  void getDropDownPosition() {
    setState(() {
      hold = dropdownPosition!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  DropdownButton(
      iconSize: 30.0,
      dropdownColor: Colors.white,
      value: _selectedPosition,
      items: _dropDownPostion(),
      onChanged: (value) {
        setState(() {
          dropdownPosition = value as String;
        });
        _selectedPosition = value.toString();
        print(_selectedPosition);
      },
      hint: const Text(
        'POSITION',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

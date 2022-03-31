// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:radium_tech/Components/input_decoration_text.dart';
// import 'package:radium_tech/Components/show_toast.dart';
// import 'package:radium_tech/Global/global.dart';
// import 'package:radium_tech/Model/ResidenceModel/get_verification_outcome_data.dart';
// import 'package:radium_tech/Services/ResidenceApi/GetData/get_verification_outcome_details.dart';
// import 'package:radium_tech/Services/ResidenceApi/SendData/send_verification_outcome_details.dart';
// import 'package:radium_tech/Utils/colors.dart';

// class VerificationOutcome extends StatefulWidget {
//   const VerificationOutcome(
//       {Key? key,
//       required this.surveyId,
//       required this.apptitle,
//       required this.formFormate})
//       : super(key: key);
//   final int surveyId;
//   final String apptitle;
//   final String formFormate;

//   @override
//   _VerificationOutcomeState createState() => _VerificationOutcomeState();
// }

// class _VerificationOutcomeState extends State<VerificationOutcome> {
//   final formKey = GlobalKey<FormBuilderState>();

//   List positiveCommentResidence = [
//     "Confirmation about the Applicant received at the given address",
//     "Appicant contact number was not reachable / Poweered off",
//     'Appartment floor was incorrectly mentioned',
//     'Address plate was affixed on the main gate',
//     'Satisfactory',
//     "The Applicant was not known to be the neighbour",
//     "Neighbours confirmation about applicant's residence was not satisfactory",
//     'Applicant contact number provided was incorrect',
//     'Appartment / Flat number was found incorrect',
//     'Address plate was not affixed on the main gate',
//   ];
//   List negativeCommentResidence = [
//     "Applicant was not found residing at the given address",
//     "Appicant contact number was not reachable / Poweered off",
//     "it was inform that the applicant's used to live at the given address However, he has shifted his residence",
//     'Applicant refused to conduct the verification',
//     'Unsatisfactory',
//     'Applicant contact number provided was incorrect',
//     'Appartment / Flat number was found incorrect',
//     'Applicant has shifted from the given address',
//     'The provided address was incomplete, could not located',
//     'Applicant address was found closed',
//     'Appartment / Complex name was incorrect',
//     'Confirmation of residence ontained at the given address. However, it was informed that the applicant is not present in the city',
//   ];

//   Object? reportStatusChange;

//   List positiveCommentWorkplace = [
//     "Applicant's Business address was found non-operational",
//     "Applicant operating a business on open lland, given the nature of their BUsiness",
//     "Applicant is operating its business from a temporary workplace, given the nature of business",
//     "Applicant is operating a seasonal business Office remains non-operatinal after closed off sesson",
//     'Satisfactory',
//   ];
//   List negativeCommentWorkplace = [
//     "Applicant refused to conduct the varification",
//     "Applicant's Business address was non-operational",
//     "Applicant contact number provided was incorrect",
//     "Applicant has shifted the business address to anouther location/address",
//     "Applicant contactnumber was not reachable / incorrect / Powered off",
//     "Business Address Plate / banner was not affixed at the business place",
//     "Office Complex / building's Name was found incorrect",
//     "Applicant is operating its business from a temporary workplace",
//     "Office Floor in the complex / building was found incorrect",
//     "Applicant is operating a businesson open land",
//     "Unsatisfactory",
//     "Applicant business address was found closed. Unsatisfactory response recieved from neighbouing business"
//   ];
//   String? dropdownvalue;
//   String? dropdownvalue1;
//   var test = true;
//   var checkBoxValue = false;
//   var checkBoxValue1 = false;
//   bool _isVisible = Surveyor_list[0].reportStatus == "Positive" ? true : false;
//   bool _Visible = Surveyor_list[0].reportStatus == "Negative" ? true : false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     dropdownvalue = Surveyor_list[0].reportStatus == "Negative"
//         ? positiveCommentResidence[0]
//         : Surveyor_list[0].comments;
//     dropdownvalue1 = Surveyor_list[0].reportStatus == "Positive"
//         ? negativeCommentResidence[0]
//         : Surveyor_list[0].comments;

//     super.initState();
//   }

//   var clickstatus;

//   void waittosendData() async {
//     await Future.delayed(const Duration(seconds: 3), () {
//       if (success == 'true') {
//         clickstatus = true;
//         Fluttertoast.showToast(
//             msg: "Form submitted",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 3,
//             backgroundColor: appColor,
//             textColor: Colors.white,
//             fontSize: 16.0);
//       } else if (success == 'error') {
//         clickstatus = true;

//         Fluttertoast.showToast(
//             msg: "Something went wrong",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 3,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0);
//       } else {
//         waittosendData();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appColor,
//         title: Text(widget.apptitle),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             child: Column(children: [
//               FormBuilder(
//                 key: formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     FormBuilderTextField(
//                         initialValue: Surveyor_list[0].surveyor,
//                         autocorrect: true,
//                         name: 'surveyor',
//                         decoration: inputDecoration(
//                             "Surveyor Name", "Enter Surveyor Name"),
//                         keyboardType: TextInputType.text),
//                     SizedBox(
//                       height: 22,
//                     ),
//                     FormBuilderRadioGroup(
//                       initialValue: Surveyor_list[0].reportStatus == "Positive"
//                           ? test
//                           : checkBoxValue,
//                       name: "report_status",
//                       onChanged: (value) {
//                         setState(() {
//                           Surveyor_list[0].reportStatus == value;
//                         });
//                       },
//                       decoration: inputDecoration("Resport Status", ""),
//                       activeColor: appColor,
//                       options: [
//                         FormBuilderFieldOption(value: "Positive"),
//                         FormBuilderFieldOption(value: "Negative"),
//                       ],
//                     ),
//                     if (Surveyor_list[0].reportStatus == "Positive")
//                       Column(
//                         children: [
//                           SizedBox(height: 22),
//                           FormBuilderDropdown(
//                             initialValue: dropdownvalue,
//                             name: 'comments',
//                             decoration: inputDecoration(
//                                 "Positive Comments", "hintText"),
//                             allowClear: true,
//                             items: widget.formFormate == "1"
//                                 ? positiveCommentWorkplace
//                                     .map((value) => DropdownMenuItem(
//                                           value: value,
//                                           child: Text('$value'),
//                                         ))
//                                     .toList()
//                                 : positiveCommentResidence
//                                     .map((value) => DropdownMenuItem(
//                                           value: value,
//                                           child: Text('$value'),
//                                         ))
//                                     .toList(),
//                           ),
//                         ],
//                       ),
//                     if (Surveyor_list[0].reportStatus == "Negative")
//                       Column(
//                         children: [
//                           SizedBox(height: 22),
//                           FormBuilderDropdown(
//                             initialValue: dropdownvalue1,
//                             name: 'comments',
//                             decoration: inputDecoration(
//                                 "Negative Comments", "hintText"),
//                             allowClear: true,
//                             items: negativeCommentResidence
//                                 .map((value) => DropdownMenuItem(
//                                       value: value,
//                                       child: Text('$value'),
//                                     ))
//                                 .toList(),
//                           ),
//                         ],
//                       ),
//                     SizedBox(height: 22),
//                     FormBuilderTextField(
//                         initialValue: Surveyor_list[0].remarks,
//                         autocorrect: true,
//                         name: 'remarks',
//                         decoration: inputDecoration("Remarks", "Enter Remarks"),
//                         keyboardType: TextInputType.text),
//                   ],
//                 ),
//               ),
//               Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//                 FlatButton.icon(
//                   onPressed: () async {
//                     formKey.currentState!.save();
//                     // if (formKey.currentState!.validate()) {
//                     print(formKey.currentState!.value);
//                     var data = formKey.currentState!.value;
//                     var res = await SendVerificationOutcomeDetails()
//                         .sendVerificationOutcomeDetails(
//                             data, "/postOutcome/${widget.surveyId}");
//                     var body = jsonDecode(res.body);
//                     if (body["success"]) {
//                       showToastApp();
//                       Navigator.pop(context);
//                     } else {
//                       showToastAppFalse();
//                     }
//                   },
//                   label: Text(
//                     "Submit",
//                     style: TextStyle(color: appColor),
//                   ),
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     color: appColor,
//                     size: 15,
//                   ),
//                 ),
//                 FlatButton.icon(
//                   onPressed: () {
//                     formKey.currentState!.reset();
//                   },
//                   label: Text(
//                     'Reset',
//                     style: TextStyle(color: appColor),
//                   ),
//                   icon: Icon(
//                     Icons.navigate_next,
//                     color: appColor,
//                   ),
//                 ),
//               ])
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:radium_tech/Api/apiurl.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/showLoderPauseScreen.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Global/global.dart';
import 'package:radium_tech/Model/ResidenceModel/get_verification_outcome_data.dart';
import 'package:radium_tech/Services/ResidenceApi/SendData/send_verification_outcome_details.dart';
import 'package:radium_tech/Utils/colors.dart';

class VerificationOutcomesWorkPlace extends StatefulWidget {
  final surid;
  const VerificationOutcomesWorkPlace({Key? key, required this.surid})
      : super(key: key);

  @override
  _VerificationOutcomesWorkPlaceState createState() =>
      _VerificationOutcomesWorkPlaceState();
}

class _VerificationOutcomesWorkPlaceState
    extends State<VerificationOutcomesWorkPlace> {
  var checkBoxValue = false;
  var checkBoxValue1 = false;

  var status;
  var clickstatus;
  var test = true;
  bool _isVisible = Surveyor_list[0].reportStatus == "Positive" ? true : false;
  bool _Visible = Surveyor_list[0].reportStatus == "Negative" ? true : false;

  final _surveyorname = TextEditingController();
  final _comments = TextEditingController();
  final _remarks = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? dropdownvalue;
  String? dropdownvalue1;

  Future<GetVerificationOutcome>? verificationOuthcomeData;
  @override
  void initState() {
    // TODO: implement initState
    dropdownvalue = Surveyor_list[0].reportStatus == "Negative"
        ? positive[0]
        : Surveyor_list[0].comments;
    dropdownvalue1 = Surveyor_list[0].reportStatus == "Positive"
        ? negative[0]
        : Surveyor_list[0].comments;
    status = Surveyor_list[0].reportStatus;

    super.initState();
  }

  var positive = [
    "Applicant's Business address was found non-operational",
    "Applicant operating a business on open lland, given the nature of their BUsiness",
    "Applicant is operating its business from a temporary workplace, given the nature of business",
    "Applicant is operating a seasonal business Office remains non-operatinal after closed off sesson",
    'Satisfactory',
  ];
  var negative = [
    "Applicant refused to conduct the varification",
    "Applicant's Business address was non-operational",
    "Applicant contact number provided was incorrect",
    "Applicant has shifted the business address to anouther location/address",
    "Applicant contactnumber was not reachable / incorrect / Powered off",
    "Business Address Plate / banner was not affixed at the business place",
    "Office Complex / building's Name was found incorrect",
    "Applicant is operating its business from a temporary workplace",
    "Office Floor in the complex / building was found incorrect",
    "Applicant is operating a businesson open land",
    "Unsatisfactory",
    "Applicant business address was found closed. Unsatisfactory response recieved from neighbouing business"
  ];
  void waittosendData() async {
    await Future.delayed(const Duration(seconds: 3), () {
      if (success == 'true') {
        Navigator.pop(context);
        clickstatus = true;
        showToastApp();
      } else if (success == 'error') {
        clickstatus = true;

        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        waittosendData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
         title: const Text(
          "Verification Outcome",
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    onChanged: (value) {
                      _surveyorname.text = value;
                    },
                    initialValue: Surveyor_list[0].surveyor,
                    decoration: inputDecoration("Surveyor", "")),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: appColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: 70,
                            child: Text(
                              "Report Status: ",
                              maxLines: 2,
                              style: TextStyle(color: appColor),
                            )),
                        Spacer(),
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            value: Surveyor_list[0].reportStatus == "Positive"
                                ? test
                                : checkBoxValue,

                            activeColor: appColor,

                            // border: BorderSide(color: Colors.white),
                            focusColor: appColor,
                            onChanged: (bool? value) {
                              setState(() {
                                checkBoxValue = value!;
                                Surveyor_list[0].reportStatus = "Positive";
                                checkBoxValue1 = false;
                                _isVisible = true;
                                _Visible = false;
                                status = "Positive";
                              });
                            },
                          ),
                        ),
                        Text(
                          "Positive",
                          style: TextStyle(color: appColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            value: Surveyor_list[0].reportStatus == "Negative"
                                ? test
                                : checkBoxValue1,

                            activeColor: appColor,

                            // border: BorderSide(color: Colors.white),
                            focusColor: appColor,
                            onChanged: (bool? value) {
                              setState(() {
                                checkBoxValue1 = value!;
                                Surveyor_list[0].reportStatus = "Negative";
                                checkBoxValue = false;
                                _Visible = true;
                                _isVisible = false;
                                status = "Negative";
                              });
                            },
                          ),
                        ),
                        Text(
                          "Negative",
                          style: TextStyle(color: appColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: _isVisible,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 60,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          // width: MediaQuery.of(context).size.width / 1.06,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: appColor, width: 1.0),
                          ),
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButtonHideUnderline(
                                child: FittedBox(
                                  child: DropdownButton(
                                    borderRadius: BorderRadius.circular(10),
                                    // Initial Value
                                    value: dropdownvalue,
                                    itemHeight: 60,
                                    menuMaxHeight: 300,

                                    // Down Arrow Icon
                                    icon: const Padding(
                                      padding: EdgeInsets.only(left: 120),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),

                                    // Array list of items
                                    items: positive.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 40,
                        child: Container(
                            color: Colors.grey.shade300,
                            child: Text(
                              'Comments',
                              style: TextStyle(color: appColor),
                            )),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _Visible,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 60,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: appColor, width: 1.0),
                          ),
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButtonHideUnderline(
                                child: FittedBox(
                                  child: DropdownButton(
                                    borderRadius: BorderRadius.circular(10),
                                    // Initial Value
                                    value: dropdownvalue1,
                                    itemHeight: 60,
                                    menuMaxHeight: 300,

                                    // Down Arrow Icon
                                    icon: const Padding(
                                      padding: EdgeInsets.only(left: 120),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),

                                    // Array list of items
                                    items: negative.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue1 = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 40,
                        child: Container(
                            color: Colors.white,
                            child: Text(
                              'Comments',
                              style: TextStyle(color: appColor),
                            )),
                      )
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // TextFormField(
                //   controller: _comments,
                //   decoration:  InputDecoration(
                //       labelText: 'Comments',
                //       hintText: Surveyor_list[0].comments,
                //       border: const OutlineInputBorder(),
                //       enabledBorder: const OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: appColor,
                //         ),
                //       )),
                // ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    initialValue: Surveyor_list[0].remarks,
                    onChanged: (val) {
                      _remarks.text = val;
                    },
                    maxLines: 3,
                    decoration: inputDecoration("Remarks", "")),
                const SizedBox(
                  height: 10,
                ),
                Spacer(),

                Row(
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: appColor)),
                      color: appColor.withOpacity(.5),
                      onPressed: () {
                        Navigator.pop(context);
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const ResidenceForms()),
                        // );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios_outlined,
                            size: 15,
                            color: textColor,
                          ),
                          Text(
                            "Back To Options",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: appColor)),
                      color: appColor.withOpacity(.5),
                      onPressed: () {
                        buildShowDialog(context);
                        Api.SendSorveyorResult(
                            widget.surid,
                            _surveyorname.text.isNotEmpty
                                ? _surveyorname.text
                                : Surveyor_list[0].surveyor,
                            status ?? Surveyor_list[0].reportStatus,
                            status == "Positive"
                                ? dropdownvalue
                                : dropdownvalue1,
                            _remarks.text.isNotEmpty
                                ? _remarks.text
                                : Surveyor_list[0].remarks);
                        waittosendData();
                        // showToastApp();
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                            color: textColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

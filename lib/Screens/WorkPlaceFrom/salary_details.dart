// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:radium_tech/Components/box_shadow_for_app.dart';
// import 'package:radium_tech/Components/decoration_for_image.dart';
// import 'package:radium_tech/Components/input_decoration_text.dart';
// import 'package:radium_tech/Components/show_toast.dart';
// import 'package:radium_tech/Services/ResidenceApi/SendData/add_images.dart';
// import 'package:radium_tech/Utils/colors.dart';

// class SalaryDetails extends StatefulWidget {
//   final int surveyId;

//   const SalaryDetails({required this.surveyId,  Key? key}) : super(key: key);

//   @override
//   _SalaryDetailsState createState() => _SalaryDetailsState();
// }

// class _SalaryDetailsState extends State<SalaryDetails> {
//   Object? isSalarySlipVarified;

//   List verifiedFrom = ["Head Office", 'asd', 'sdf'];

//   AddImages addImages = AddImages();
//   XFile? pickImage1;
//   XFile? pickImage2;
//   XFile? pickImage3;
//   String finalResponse1 = '';
//   String finalResponse2 = '';
//   String finalResponse3 = '';
//   bool finalResponsebool1 = false;
//   bool finalResponsebool2 = false;
//   bool finalResponsebool3 = false;
//   bool isLoader1 = false;
//   bool isLoader2 = false;
//   bool isLoader3 = false;

//   final ImagePicker _picker = ImagePicker();

//   @override
//   Widget build(BuildContext context) {
//     // var snapshot;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Salary Slip Details"),
//       ),
//       body: SingleChildScrollView(
//         child: FormBuilder(
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 22,
//                 ),
//                 FormBuilderRadioGroup(
//                   name: "salary_slip_shown",
//                   focusColor: appColor,
//                   activeColor: appColor,
//                   options: [
//                     FormBuilderFieldOption(value: "Yes"),
//                     FormBuilderFieldOption(value: "No"),
//                   ],
//                   decoration: inputDecoration("Salary Slip Provided Shown", ""),
//                 ),
//                 SizedBox(
//                   height: 22,
//                 ),
//                 FormBuilderRadioGroup(
//                   name: "picture_taken",
//                   focusColor: appColor,
//                   activeColor: appColor,
//                   options: [
//                     FormBuilderFieldOption(value: "Yes"),
//                     FormBuilderFieldOption(value: "No"),
//                   ],
//                   decoration: inputDecoration("If Shown, Picture Taken", ""),
//                 ),
//                 SizedBox(
//                   height: 22,
//                 ),
//                 FormBuilderRadioGroup(
//                   name: "credentials_verified",
//                   focusColor: appColor,
//                   activeColor: appColor,
//                   options: [
//                     FormBuilderFieldOption(value: "Yes"),
//                     FormBuilderFieldOption(value: "No"),
//                   ],
//                   decoration: inputDecoration("Credentials Verified", ""),
//                 ),
//                 SizedBox(
//                   height: 22,
//                 ),
//                 FormBuilderRadioGroup(
//                   name: "salary_slip_verified",
//                   focusColor: appColor,
//                   activeColor: appColor,
//                   onChanged: (val) {
//                     setState(() {
//                       isSalarySlipVarified = val;
//                     });
//                   },
//                   options: [
//                     FormBuilderFieldOption(value: "Yes"),
//                     FormBuilderFieldOption(value: "No"),
//                   ],
//                   decoration: inputDecoration("Salary Slip Verified", ""),
//                 ),
//                 if (isSalarySlipVarified == "Yes")
//                   Column(
//                     children: [
//                       SizedBox(
//                         height: 22,
//                       ),
//                       FormBuilderDropdown(
//                           decoration:
//                               inputDecoration("Salary Verified From", ""),
//                           name: "slary_verified_from",
//                           items: verifiedFrom
//                               .map((value) => DropdownMenuItem(
//                                   value: value, child: Text(value)))
//                               .toList()),
//                       SizedBox(
//                         height: 22,
//                       ),
//                       FormBuilderTextField(
//                         name: "gross_salary",
//                         decoration: inputDecoration("Gross Salary", ""),
//                       ),
//                       SizedBox(
//                         height: 22,
//                       ),
//                       FormBuilderTextField(
//                         name: "net_salary",
//                         decoration: inputDecoration("Net Salary", ""),
//                       ),
//                     ],
//                   ),
//                 SizedBox(
//                   height: 22,
//                 ),
//                 FormBuilderRadioGroup(
//                   name: "report_status",
//                   focusColor: appColor,
//                   activeColor: appColor,
//                   options: [
//                     FormBuilderFieldOption(value: "Yes"),
//                     FormBuilderFieldOption(value: "No"),
//                   ],
//                   decoration: inputDecoration("Report Status", ""),
//                 ),
//                 SizedBox(
//                   height: 22,
//                 ),
//                 FormBuilderTextField(
//                   name: "comments",
//                   decoration: inputDecoration("Comments", ''),
//                 ),
//                            Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             "Image2.",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w900,
//                                 fontStyle: FontStyle.italic,
//                                 color: appColor,
//                                 fontSize: 16),
//                           ),
//                         ),
//                         Stack(
//                           children: [
//                             finalResponsebool2 == false
//                                 ? Container(
//                                     width: 150,
//                                     height: 150,
//                                     decoration: decorationForImageBox(),
//                                     child: isLoader2
//                                         ? Container(
//                                             child: CircularProgressIndicator())
//                                         : snapshot.data!.data![0].image2 != null
//                                             ? Container(
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                     150,
//                                                   ),
//                                                   image: DecorationImage(
//                                                       image: NetworkImage(
//                                                           snapshot
//                                                               .data!
//                                                               .data![0]
//                                                               .image2!)),
//                                                 ),
//                                               )
//                                             : Container(
//                                                 width: 150,
//                                                 height: 150,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   boxShadow: [
//                                                     boxShadowForApp(),
//                                                   ],
//                                                   border: Border.all(
//                                                       color: appColor),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           150),
//                                                   image: DecorationImage(
//                                                     image: AssetImage(
//                                                       'assets/createpic.png',
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                   )
//                                 : Container(
//                                     width: 150,
//                                     height: 150,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         boxShadowForApp(),
//                                       ],
//                                       border: Border.all(color: appColor),
//                                       borderRadius: BorderRadius.circular(150),
//                                       image: DecorationImage(
//                                         image:
//                                             FileImage(File(pickImage2!.path)),
//                                       ),
//                                     ),
//                                   ),
//                             Positioned(
//                                 bottom: 0,
//                                 left: 0,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: appColor,
//                                       borderRadius: BorderRadius.circular(30)),
//                                   child: IconButton(
//                                       onPressed: () async {
//                                         var image = await _picker.pickImage(
//                                             source: ImageSource.camera,
//                                             );

//                                         setState(() {
//                                           pickImage2 = image;
//                                         });
//                                       },
//                                       icon: Icon(
//                                         Icons.camera_alt,
//                                         color: Colors.white,
//                                       )),
//                                 )),
//                             Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: appColor,
//                                       borderRadius: BorderRadius.circular(30)),
//                                   child: IconButton(
//                                       onPressed: () async {
//                                         var image = await _picker.pickImage(
//                                                                                         source: ImageSource.gallery);
//                                         setState(() {
//                                           pickImage2 = image;
//                                         });
//                                       },
//                                       icon: Icon(
//                                         Icons.image,
//                                         color: Colors.white,
//                                       )),
//                                 )),
//                           ],
//                         ),
//                         MaterialButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           color: appColor,
//                           onPressed: () async {
//                             var status = await AddImages().addImage(
//                                 pickImage2!.path,
//                                 "/addimagetwo/${widget.surveyId}");
//                             var result = jsonDecode(status);

//                             setState(() {
//                               finalResponsebool2 = result['success'];
//                               finalResponse2 = result['imagepath'];
//                               isLoader2 = true;
//                             });
//                             if (finalResponsebool1) {
//                               showToastApp();
//                               setState(() {
//                                 isLoader2 = false;
//                               });
//                             }
//                           },
//                           child: Text('Save',
//                               style: TextStyle(
//                                 color: Colors.white,
//                               )),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 22,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             "Image2.",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w900,
//                                 fontStyle: FontStyle.italic,
//                                 color: appColor,
//                                 fontSize: 16),
//                           ),
//                         ),
//                         Stack(
//                           children: [
//                             finalResponsebool2 == false
//                                 ? Container(
//                                     width: 150,
//                                     height: 150,
//                                     decoration: decorationForImageBox(),
//                                     child: isLoader2
//                                         ? Container(
//                                             child: CircularProgressIndicator())
//                                         : snapshot.data!.data![0].image2 != null
//                                             ? Container(
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                     150,
//                                                   ),
//                                                   image: DecorationImage(
//                                                       image: NetworkImage(
//                                                           snapshot
//                                                               .data!
//                                                               .data![0]
//                                                               .image2!)),
//                                                 ),
//                                               )
//                                             : Container(
//                                                 width: 150,
//                                                 height: 150,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   boxShadow: [
//                                                     boxShadowForApp(),
//                                                   ],
//                                                   border: Border.all(
//                                                       color: appColor),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           150),
//                                                   image: DecorationImage(
//                                                     image: AssetImage(
//                                                       'assets/createpic.png',
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                   )
//                                 : Container(
//                                     width: 150,
//                                     height: 150,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         boxShadowForApp(),
//                                       ],
//                                       border: Border.all(color: appColor),
//                                       borderRadius: BorderRadius.circular(150),
//                                       image: DecorationImage(
//                                         image:
//                                             FileImage(File(pickImage2!.path)),
//                                       ),
//                                     ),
//                                   ),
//                             Positioned(
//                                 bottom: 0,
//                                 left: 0,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: appColor,
//                                       borderRadius: BorderRadius.circular(30)),
//                                   child: IconButton(
//                                       onPressed: () async {
//                                         var image = await _picker.pickImage(
//                                             source: ImageSource.camera,
//                                             );

//                                         setState(() {
//                                           pickImage2 = image;
//                                         });
//                                       },
//                                       icon: Icon(
//                                         Icons.camera_alt,
//                                         color: Colors.white,
//                                       )),
//                                 )),
//                             Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: appColor,
//                                       borderRadius: BorderRadius.circular(30)),
//                                   child: IconButton(
//                                       onPressed: () async {
//                                         var image = await _picker.pickImage(
//                                                                                         source: ImageSource.gallery);
//                                         setState(() {
//                                           pickImage2 = image;
//                                         });
//                                       },
//                                       icon: Icon(
//                                         Icons.image,
//                                         color: Colors.white,
//                                       )),
//                                 )),
//                           ],
//                         ),
//                         MaterialButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           color: appColor,
//                           onPressed: () async {
//                             var status = await AddImages().addImage(
//                                 pickImage2!.path,
//                                 "/addimagetwo/${widget.surveyId}");
//                             var result = jsonDecode(status);

//                             setState(() {
//                               finalResponsebool2 = result['success'];
//                               finalResponse2 = result['imagepath'];
//                               isLoader2 = true;
//                             });
//                             if (finalResponsebool1) {
//                               showToastApp();
//                               setState(() {
//                                 isLoader2 = false;
//                               });
//                             }
//                           },
//                           child: Text('Save',
//                               style: TextStyle(
//                                 color: Colors.white,
//                               )),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 22,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             "Image2.",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w900,
//                                 fontStyle: FontStyle.italic,
//                                 color: appColor,
//                                 fontSize: 16),
//                           ),
//                         ),
//                         Stack(
//                           children: [
//                             finalResponsebool2 == false
//                                 ? Container(
//                                     width: 150,
//                                     height: 150,
//                                     decoration: decorationForImageBox(),
//                                     child: isLoader2
//                                         ? Container(
//                                             child: CircularProgressIndicator())
//                                         : snapshot.data!.data![0].image2 != null
//                                             ? Container(
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                     150,
//                                                   ),
//                                                   image: DecorationImage(
//                                                       image: NetworkImage(
//                                                           snapshot
//                                                               .data!
//                                                               .data![0]
//                                                               .image2!)),
//                                                 ),
//                                               )
//                                             : Container(
//                                                 width: 150,
//                                                 height: 150,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   boxShadow: [
//                                                     boxShadowForApp(),
//                                                   ],
//                                                   border: Border.all(
//                                                       color: appColor),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           150),
//                                                   image: DecorationImage(
//                                                     image: AssetImage(
//                                                       'assets/createpic.png',
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                   )
//                                 : Container(
//                                     width: 150,
//                                     height: 150,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         boxShadowForApp(),
//                                       ],
//                                       border: Border.all(color: appColor),
//                                       borderRadius: BorderRadius.circular(150),
//                                       image: DecorationImage(
//                                         image:
//                                             FileImage(File(pickImage2!.path)),
//                                       ),
//                                     ),
//                                   ),
//                             Positioned(
//                                 bottom: 0,
//                                 left: 0,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: appColor,
//                                       borderRadius: BorderRadius.circular(30)),
//                                   child: IconButton(
//                                       onPressed: () async {
//                                         var image = await _picker.pickImage(
//                                             source: ImageSource.camera,
//                                             );

//                                         setState(() {
//                                           pickImage2 = image;
//                                         });
//                                       },
//                                       icon: Icon(
//                                         Icons.camera_alt,
//                                         color: Colors.white,
//                                       )),
//                                 )),
//                             Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: appColor,
//                                       borderRadius: BorderRadius.circular(30)),
//                                   child: IconButton(
//                                       onPressed: () async {
//                                         var image = await _picker.pickImage(
//                                                                                         source: ImageSource.gallery);
//                                         setState(() {
//                                           pickImage2 = image;
//                                         });
//                                       },
//                                       icon: Icon(
//                                         Icons.image,
//                                         color: Colors.white,
//                                       )),
//                                 )),
//                           ],
//                         ),
//                         MaterialButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           color: appColor,
//                           onPressed: () async {
//                             var status = await AddImages().addImage(
//                                 pickImage2!.path,
//                                 "/addimagetwo/${widget.surveyId}");
//                             var result = jsonDecode(status);

//                             setState(() {
//                               finalResponsebool2 = result['success'];
//                               finalResponse2 = result['imagepath'];
//                               isLoader2 = true;
//                             });
//                             if (finalResponsebool1) {
//                               showToastApp();
//                               setState(() {
//                                 isLoader2 = false;
//                               });
//                             }
//                           },
//                           child: Text('Save',
//                               style: TextStyle(
//                                 color: Colors.white,
//                               )),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 22,
//                     ),

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:radium_tech/Components/box_shadow_for_app.dart';
import 'package:radium_tech/Components/decoration_for_image.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Model/ResidenceModel/get_image_data.dart';
import 'package:radium_tech/Model/WorkPlaceModel/get_salary_slip_data.dart';
import 'package:radium_tech/Screens/ResidenceForm/verification_outcome.dart';
import 'package:radium_tech/Services/ResidenceApi/GetData/image_get_api.dart';
import 'package:radium_tech/Services/ResidenceApi/SendData/add_images.dart';
import 'package:radium_tech/Services/WorkplaceApi/GetData/get_salary_dlip_details.dart';
import 'package:radium_tech/Services/WorkplaceApi/SendData/send_market_check_2.dart';
import 'package:radium_tech/Utils/colors.dart';

import '../../Api/apiUrl.dart';
import '../../Global/global.dart';

class SalaryDetails extends StatefulWidget {
  final int surveyId;

  const SalaryDetails({Key? key, required this.surveyId}) : super(key: key);
  @override
  _SalaryDetailsState createState() => _SalaryDetailsState();
}

class _SalaryDetailsState extends State<SalaryDetails> {
  Object? isSalarySlipVarified;
  final formKey = GlobalKey<FormBuilderState>();

  List verifiedFrom = [
    "Head Office",
    'Regional Office',
    'Branch Office',
    'Factory'
  ];

  AddImages addImages = AddImages();
  XFile? pickImage1;
  XFile? pickImage2;
  XFile? pickImage3;
  String finalResponse1 = '';
  String finalResponse2 = '';
  String finalResponse3 = '';
  bool finalResponsebool1 = false;
  bool finalResponsebool2 = false;
  bool finalResponsebool3 = false;
  bool isLoader1 = false;
  bool isLoader2 = false;
  bool isLoader3 = false;

  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  var clickstatus = true;
  _getFromCamera1() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile1 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery1() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile1 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera2() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile2 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery2() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile2 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera3() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile3 = File(pickedFile.path);
      });

      Navigator.pop(context);
    }
  }

  _getFromGallery3() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile3 = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  Future<void> _showChoiceDialog1(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery1();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera1();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery2();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera2();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog3(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery3();
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera3();
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: appColor,
            ),
          );
        });
  }

  void waittoaddImage() async {
    buildShowDialog(context);
    await Future.delayed(const Duration(seconds: 3), () {
      if (success == 'true') {
        clickstatus = true;

        Fluttertoast.showToast(
            msg: "Successfully Add Image.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: appColor,
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => Loginn()));
      } else if (success == 'error') {
        clickstatus = true;

        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: appColor,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        waittoaddImage();
      }
    });
    Navigator.pop(context);
  }

  Future<GetSalaryData>? getSalaryDetails;

  Object? salaryIsProvided;

  Object? ifPicTaken;

  Object? isCredVerified;

  Object? salaryVerifiedFrom;

  String? grossSalary;

  Object? reportStatus;

  String? comments;

  Map<String, Object?>? dataTarget;

  String? netSalary;
  @override
  void initState() {
    // TODO: implement initState
    getSalaryDetails = GetSalaryDetails()
        .getSalaryDetails("/getSalaryDetails/${widget.surveyId}");
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();
  @override
  void dispose() {
    print("Disposing ResidenceHomePage route");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salary Slip Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<GetSalaryData>(
            future: getSalaryDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    FormBuilder(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 22,
                          ),
                          FormBuilderRadioGroup(
                            onChanged: (value) {
                              salaryIsProvided = value;
                            },
                            name: "salary_slip_shown",
                            initialValue:
                                snapshot.data!.data![0].wp_ss_is_provided ?? "",
                            focusColor: appColor,
                            activeColor: appColor,
                            options: [
                              FormBuilderFieldOption(value: "Yes"),
                              FormBuilderFieldOption(value: "No"),
                            ],
                            decoration: inputDecoration(
                                "Salary Slip Provided Shown", ""),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          FormBuilderRadioGroup(
                            onChanged: (value) {
                              ifPicTaken = value;
                            },
                            initialValue:
                                snapshot.data!.data![0].wp_ss_if_pic_taken ??
                                    "",
                            name: "picture_taken",
                            focusColor: appColor,
                            activeColor: appColor,
                            options: [
                              FormBuilderFieldOption(value: "Yes"),
                              FormBuilderFieldOption(value: "No"),
                            ],
                            decoration:
                                inputDecoration("If Shown, Picture Taken", ""),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          FormBuilderRadioGroup(
                            onChanged: (value) {
                              isCredVerified = value;
                            },
                            initialValue: snapshot.data!.data![0]
                                    .wp_ss_credentials_verified ??
                                "",
                            name: "credentials_verified",
                            focusColor: appColor,
                            activeColor: appColor,
                            options: [
                              FormBuilderFieldOption(value: "Yes"),
                              FormBuilderFieldOption(value: "No"),
                            ],
                            decoration:
                                inputDecoration("Credentials Verified", ""),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          FormBuilderRadioGroup(
                            initialValue:
                                snapshot.data!.data![0].wp_ss_slip_verified ??
                                    "",
                            name: "salary_slip_verified",
                            focusColor: appColor,
                            activeColor: appColor,
                            onChanged: (val) {
                              setState(() {
                                isSalarySlipVarified = val;
                                snapshot.data!.data![0].wp_ss_slip_verified =
                                    val as String?;
                              });
                            },
                            options: [
                              FormBuilderFieldOption(value: "Yes"),
                              FormBuilderFieldOption(value: "No"),
                            ],
                            decoration:
                                inputDecoration("Salary Slip Verified", ""),
                          ),
                          if (isSalarySlipVarified == "Yes" ||
                              snapshot.data!.data![0].wp_ss_slip_verified ==
                                  "Yes")
                            Column(
                              children: [
                                SizedBox(
                                  height: 22,
                                ),
                                FormBuilderDropdown(
                                    onChanged: (value) {
                                      salaryVerifiedFrom = value;
                                    },
                                    initialValue: snapshot.data!.data![0]
                                            .wp_ss_slip_verified_from ??
                                        verifiedFrom[0],
                                    decoration: inputDecoration(
                                        "Salary Verified From", ""),
                                    name: "slary_verified_from",
                                    items: verifiedFrom
                                        .map((value) => DropdownMenuItem(
                                            value: value, child: Text(value)))
                                        .toList()),
                                SizedBox(
                                  height: 22,
                                ),
                                FormBuilderTextField(
                                  onChanged: (value) {
                                    grossSalary = value;
                                  },
                                  initialValue: snapshot
                                          .data!.data![0].wp_ss_gross_salary ??
                                      "",
                                  keyboardType: TextInputType.phone,
                                  name: "gross_salary",
                                  decoration:
                                      inputDecoration("Gross Salary", ""),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                FormBuilderTextField(
                                  initialValue: snapshot
                                          .data!.data![0].wp_ss_net_salary ??
                                      "",
                                  onChanged: (value) {
                                    netSalary = value;
                                  },
                                  keyboardType: TextInputType.phone,
                                  name: "net_salary",
                                  decoration: inputDecoration("Net Salary", ""),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 22,
                          ),
                          FormBuilderRadioGroup(
                            onChanged: (value) {
                              reportStatus = value;
                            },
                            initialValue:
                                snapshot.data!.data![0].wp_ss_report_status ??
                                    "",
                            name: "report_status",
                            focusColor: appColor,
                            activeColor: appColor,
                            options: [
                              FormBuilderFieldOption(value: "Positive"),
                              FormBuilderFieldOption(value: "Negative"),
                            ],
                            decoration: inputDecoration("Report Status", ""),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          FormBuilderTextField(
                            onChanged: (value) {
                              comments = value;
                            },
                            initialValue:
                                snapshot.data!.data![0].wp_ss_comments ?? "",
                            name: "comments",
                            decoration: inputDecoration("Comments", ''),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    width: 80,
                                    height: 120,
                                    child: Text(
                                      'Image (1)',
                                      style: TextStyle(
                                          color: appColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )),
                                Container(
                                  width: 120,
                                  height: 120,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(70),
                                            child: imageFile1 != null
                                                ? Image.file(
                                                    imageFile1!,
                                                    fit: BoxFit.fill,
                                                  )
                                                : (snapshot.data!.data![0]
                                                            .wp_ss_image1 ==
                                                        null)
                                                    ? Center(
                                                        child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color:
                                                                        appColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            child: Center(
                                                                child: Text(
                                                                    "Choose Image"))))
                                                    : Image.network(
                                                        snapshot.data!.data![0]
                                                            .wp_ss_image1!,
                                                        fit: BoxFit.fill,
                                                      ),
                                          )),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: appColor,
                                          child: InkWell(
                                            onTap: () {
                                              _showChoiceDialog1(context);
                                            },
                                            child: const Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 23,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Api.Addimage(imageFile1, widget.surveyId,
                                        "addsalaryimageone");
                                    waittoaddImage();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: appColor,
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    width: 80,
                                    height: 120,
                                    child: Text(
                                      'Image (2)',
                                      style: TextStyle(
                                          color: appColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )),
                                Container(
                                  width: 120,
                                  height: 120,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(70),
                                            child: imageFile2 != null
                                                ? Image.file(
                                                    imageFile2!,
                                                    fit: BoxFit.fill,
                                                  )
                                                : (snapshot.data!.data![0]
                                                            .wp_ss_image2 ==
                                                        null)
                                                    ? Center(
                                                        child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color:
                                                                        appColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            child: Center(
                                                                child: Text(
                                                                    "Choose Image"))))
                                                    : Image.network(
                                                        snapshot.data!.data![0]
                                                            .wp_ss_image2!,
                                                        fit: BoxFit.fill,
                                                      ),
                                          )),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: appColor,
                                          child: InkWell(
                                            onTap: () {
                                              _showChoiceDialog2(context);
                                            },
                                            child: const Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 23,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Api.Addimage(imageFile2, widget.surveyId,
                                        "addsalaryimagetwo");
                                    waittoaddImage();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: appColor,
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    width: 80,
                                    height: 120,
                                    child: Text(
                                      'Image (3)',
                                      style: TextStyle(
                                          color: appColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )),
                                Container(
                                  width: 120,
                                  height: 120,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(70),
                                            child: imageFile3 != null
                                                ? Image.file(
                                                    imageFile3!,
                                                    fit: BoxFit.fill,
                                                  )
                                                : (snapshot.data!.data![0]
                                                            .wp_ss_image3 ==
                                                        null)
                                                    ? Center(
                                                        child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color:
                                                                        appColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            child: Center(
                                                                child: Text(
                                                                    "Choose Image"))))
                                                    : Image.network(
                                                        snapshot.data!.data![0]
                                                            .wp_ss_image3!,
                                                        fit: BoxFit.fill,
                                                      ),
                                          )),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: appColor,
                                          child: InkWell(
                                            onTap: () {
                                              _showChoiceDialog3(context);
                                            },
                                            child: const Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 23,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Api.Addimage(imageFile3, widget.surveyId,
                                        "addsalaryimagethree");
                                    waittoaddImage();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: appColor,
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Align(
                          //       alignment: Alignment.bottomLeft,
                          //       child: Text(
                          //         "Image1.",
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.w900,
                          //             fontStyle: FontStyle.italic,
                          //             color: appColor,
                          //             fontSize: 16),
                          //       ),
                          //     ),
                          //     Stack(
                          //       children: [
                          //         finalResponsebool1 == false
                          //             ? Container(
                          //                 width: 150,
                          //                 height: 150,
                          //                 decoration: decorationForImageBox(),
                          //                 child: isLoader1
                          //                     ? Container(
                          //                         child:
                          //                             CircularProgressIndicator())
                          //                     : snapshot.data!.data![0]
                          //                                 .wp_ss_image1 !=
                          //                             null
                          //                         ? Container(
                          //                             decoration: BoxDecoration(
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(
                          //                                 150,
                          //                               ),
                          //                               image: DecorationImage(
                          //                                   image: NetworkImage(
                          //                                       snapshot
                          //                                           .data!
                          //                                           .data![0]
                          //                                           .wp_ss_image1!)),
                          //                             ),
                          //                           )
                          //                         : Container(
                          //                             width: 150,
                          //                             height: 150,
                          //                             decoration: BoxDecoration(
                          //                               color: Colors.white,
                          //                               boxShadow: [
                          //                                 boxShadowForApp(),
                          //                               ],
                          //                               border: Border.all(
                          //                                   color: appColor),
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(150),
                          //                               image: DecorationImage(
                          //                                 image: AssetImage(
                          //                                   'assets/createpic.png',
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ),
                          //               )
                          //             : Container(
                          //                 width: 150,
                          //                 height: 150,
                          //                 decoration: BoxDecoration(
                          //                   color: Colors.white,
                          //                   boxShadow: [
                          //                     boxShadowForApp(),
                          //                   ],
                          //                   border: Border.all(color: appColor),
                          //                   borderRadius:
                          //                       BorderRadius.circular(150),
                          //                   image: DecorationImage(
                          //                     image: FileImage(
                          //                         File(pickImage1!.path)),
                          //                   ),
                          //                 ),
                          //               ),
                          //         Positioned(
                          //             bottom: 0,
                          //             left: 0,
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                   color: appColor,
                          //                   borderRadius:
                          //                       BorderRadius.circular(30)),
                          //               child: IconButton(
                          //                   onPressed: () async {
                          //                     var image =
                          //                         await _picker.pickImage(
                          //                       source: ImageSource.camera,
                          //                     );

                          //                     setState(() {
                          //                       pickImage1 = image;
                          //                     });
                          //                   },
                          //                   icon: Icon(
                          //                     Icons.camera_alt,
                          //                     color: Colors.white,
                          //                   )),
                          //             )),
                          //         Positioned(
                          //             bottom: 0,
                          //             right: 0,
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                   color: appColor,
                          //                   borderRadius:
                          //                       BorderRadius.circular(30)),
                          //               child: IconButton(
                          //                   onPressed: () async {
                          //                     var image =
                          //                         await _picker.pickImage(
                          //                             source:
                          //                                 ImageSource.gallery);
                          //                     setState(() {
                          //                       pickImage1 = image;
                          //                     });
                          //                   },
                          //                   icon: Icon(
                          //                     Icons.image,
                          //                     color: Colors.white,
                          //                   )),
                          //             )),
                          //       ],
                          //     ),
                          //     MaterialButton(
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(30),
                          //       ),
                          //       color: appColor,
                          //       onPressed: () async {
                          //         var status = await AddImages().addImage(
                          //             pickImage1!.path,
                          //             "/addsalaryimageone/${widget.surveyId}");
                          //         var result = jsonDecode(status);

                          //         setState(() {
                          //           finalResponsebool1 = result['success'];
                          //           finalResponse1 = result['imagepath'];
                          //           isLoader1 = true;
                          //         });
                          //         if (finalResponsebool1) {
                          //           showToastApp();
                          //           setState(() {
                          //             isLoader1 = false;
                          //           });
                          //         }
                          //       },
                          //       child: Text('Save',
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //           )),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 22,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Align(
                          //       alignment: Alignment.bottomLeft,
                          //       child: Text(
                          //         "Image2.",
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.w900,
                          //             fontStyle: FontStyle.italic,
                          //             color: appColor,
                          //             fontSize: 16),
                          //       ),
                          //     ),
                          //     Stack(
                          //       children: [
                          //         finalResponsebool2 == false
                          //             ? Container(
                          //                 width: 150,
                          //                 height: 150,
                          //                 decoration: decorationForImageBox(),
                          //                 child: isLoader2
                          //                     ? Container(
                          //                         child:
                          //                             CircularProgressIndicator())
                          //                     : snapshot.data!.data![0]
                          //                                 .wp_ss_image2 !=
                          //                             null
                          //                         ? Container(
                          //                             decoration: BoxDecoration(
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(
                          //                                 150,
                          //                               ),
                          //                               image: DecorationImage(
                          //                                   image: NetworkImage(
                          //                                       snapshot
                          //                                           .data!
                          //                                           .data![0]
                          //                                           .wp_ss_image2!)),
                          //                             ),
                          //                           )
                          //                         : Container(
                          //                             width: 150,
                          //                             height: 150,
                          //                             decoration: BoxDecoration(
                          //                               color: Colors.white,
                          //                               boxShadow: [
                          //                                 boxShadowForApp(),
                          //                               ],
                          //                               border: Border.all(
                          //                                   color: appColor),
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(150),
                          //                               image: DecorationImage(
                          //                                 image: AssetImage(
                          //                                   'assets/createpic.png',
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ),
                          //               )
                          //             : Container(
                          //                 width: 150,
                          //                 height: 150,
                          //                 decoration: BoxDecoration(
                          //                   color: Colors.white,
                          //                   boxShadow: [
                          //                     boxShadowForApp(),
                          //                   ],
                          //                   border: Border.all(color: appColor),
                          //                   borderRadius:
                          //                       BorderRadius.circular(150),
                          //                   image: DecorationImage(
                          //                     image: FileImage(
                          //                         File(pickImage2!.path)),
                          //                   ),
                          //                 ),
                          //               ),
                          //         Positioned(
                          //             bottom: 0,
                          //             left: 0,
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                   color: appColor,
                          //                   borderRadius:
                          //                       BorderRadius.circular(30)),
                          //               child: IconButton(
                          //                   onPressed: () async {
                          //                     var image =
                          //                         await _picker.pickImage(
                          //                       source: ImageSource.camera,
                          //                     );

                          //                     setState(() {
                          //                       pickImage2 = image;
                          //                     });
                          //                   },
                          //                   icon: Icon(
                          //                     Icons.camera_alt,
                          //                     color: Colors.white,
                          //                   )),
                          //             )),
                          //         Positioned(
                          //             bottom: 0,
                          //             right: 0,
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                   color: appColor,
                          //                   borderRadius:
                          //                       BorderRadius.circular(30)),
                          //               child: IconButton(
                          //                   onPressed: () async {
                          //                     var image =
                          //                         await _picker.pickImage(
                          //                             source:
                          //                                 ImageSource.gallery);
                          //                     setState(() {
                          //                       pickImage2 = image;
                          //                     });
                          //                   },
                          //                   icon: Icon(
                          //                     Icons.image,
                          //                     color: Colors.white,
                          //                   )),
                          //             )),
                          //       ],
                          //     ),
                          //     MaterialButton(
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(30),
                          //       ),
                          //       color: appColor,
                          //       onPressed: () async {
                          //         var status = await AddImages().addImage(
                          //             pickImage2!.path,
                          //             "/addsalaryimagetwo/${widget.surveyId}");
                          //         var result = jsonDecode(status);

                          //         setState(() {
                          //           finalResponsebool2 = result['success'];
                          //           finalResponse2 = result['imagepath'];
                          //           isLoader2 = true;
                          //         });
                          //         if (finalResponsebool1) {
                          //           showToastApp();
                          //           setState(() {
                          //             isLoader2 = false;
                          //           });
                          //         }
                          //       },
                          //       child: Text('Save',
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //           )),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 22,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Align(
                          //       alignment: Alignment.bottomLeft,
                          //       child: Text(
                          //         "Image3.",
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.w900,
                          //             fontStyle: FontStyle.italic,
                          //             color: appColor,
                          //             fontSize: 16),
                          //       ),
                          //     ),
                          //     Stack(
                          //       children: [
                          //         finalResponsebool3 == false
                          //             ? Container(
                          //                 width: 150,
                          //                 height: 150,
                          //                 decoration: decorationForImageBox(),
                          //                 child: isLoader3
                          //                     ? Container(
                          //                         child:
                          //                             CircularProgressIndicator())
                          //                     : snapshot.data!.data![0]
                          //                                 .wp_ss_image3 !=
                          //                             null
                          //                         ? Container(
                          //                             decoration: BoxDecoration(
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(
                          //                                 150,
                          //                               ),
                          //                               image: DecorationImage(
                          //                                   image: NetworkImage(
                          //                                       snapshot
                          //                                           .data!
                          //                                           .data![0]
                          //                                           .wp_ss_image3!)),
                          //                             ),
                          //                           )
                          //                         : Container(
                          //                             width: 150,
                          //                             height: 150,
                          //                             decoration: BoxDecoration(
                          //                               color: Colors.white,
                          //                               boxShadow: [
                          //                                 boxShadowForApp(),
                          //                               ],
                          //                               border: Border.all(
                          //                                   color: appColor),
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(150),
                          //                               image: DecorationImage(
                          //                                 image: AssetImage(
                          //                                   'assets/createpic.png',
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ),
                          //               )
                          //             : Container(
                          //                 width: 150,
                          //                 height: 150,
                          //                 decoration: BoxDecoration(
                          //                   color: Colors.white,
                          //                   boxShadow: [
                          //                     boxShadowForApp(),
                          //                   ],
                          //                   border: Border.all(color: appColor),
                          //                   borderRadius:
                          //                       BorderRadius.circular(150),
                          //                   image: DecorationImage(
                          //                     image: FileImage(
                          //                         File(pickImage3!.path)),
                          //                   ),
                          //                 ),
                          //               ),
                          //         Positioned(
                          //             bottom: 0,
                          //             left: 0,
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                   color: appColor,
                          //                   borderRadius:
                          //                       BorderRadius.circular(30)),
                          //               child: IconButton(
                          //                   onPressed: () async {
                          //                     var image =
                          //                         await _picker.pickImage(
                          //                       source: ImageSource.camera,
                          //                     );

                          //                     setState(() {
                          //                       pickImage3 = image;
                          //                     });
                          //                   },
                          //                   icon: Icon(
                          //                     Icons.camera_alt,
                          //                     color: Colors.white,
                          //                   )),
                          //             )),
                          //         Positioned(
                          //             bottom: 0,
                          //             right: 0,
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                   color: appColor,
                          //                   borderRadius:
                          //                       BorderRadius.circular(30)),
                          //               child: IconButton(
                          //                   onPressed: () async {
                          //                     var image =
                          //                         await _picker.pickImage(
                          //                             source:
                          //                                 ImageSource.gallery);
                          //                     setState(() {
                          //                       pickImage3 = image;
                          //                     });
                          //                   },
                          //                   icon: Icon(
                          //                     Icons.image,
                          //                     color: Colors.white,
                          //                   )),
                          //             )),
                          //       ],
                          //     ),

                          //     MaterialButton(
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(30),
                          //       ),
                          //       color: appColor,
                          //       onPressed: () async {
                          //         var status = await AddImages().addImage(
                          //             pickImage3!.path,
                          //             "/addsalaryimagethree/${widget.surveyId}");
                          //         var result = jsonDecode(status);

                          //         setState(() {
                          //           finalResponsebool3 = result['success'];
                          //           finalResponse3 = result['imagepath'];
                          //           isLoader3 = true;
                          //         });
                          //         if (finalResponsebool1) {
                          //           showToastApp();
                          //           setState(() {
                          //             isLoader3 = false;
                          //           });
                          //         }
                          //       },
                          //       child: Text('Save',
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //           )),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 22,
                          // ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BackToOptions(),
                        MaterialButton(
                          onPressed: () async {
                            formKey.currentState!.save();
                            // if (formKey.currentState!.validate()) {
                            print(formKey.currentState!.value);
                            var data = formKey.currentState!.value;
                            dataTarget = {
                              'wp_ss_is_provided': salaryIsProvided ??
                                  snapshot.data!.data![0].wp_ss_is_provided,
                              'wp_ss_if_pic_taken': ifPicTaken ??
                                  snapshot.data!.data![0].wp_ss_if_pic_taken,
                              'wp_ss_credentials_verified': isCredVerified ??
                                  snapshot.data!.data![0]
                                      .wp_ss_credentials_verified,
                              "wp_ss_slip_verified": isSalarySlipVarified ??
                                  snapshot.data!.data![0].wp_ss_slip_verified,
                              'wp_ss_slip_verified_from': salaryVerifiedFrom ??
                                  snapshot
                                      .data!.data![0].wp_ss_slip_verified_from,
                              'wp_ss_gross_salary': grossSalary ??
                                  snapshot.data!.data![0].wp_ss_gross_salary,
                              'wp_ss_net_salary': netSalary ??
                                  snapshot.data!.data![0].wp_ss_net_salary,
                              'wp_ss_report_status': reportStatus ??
                                  snapshot.data!.data![0].wp_ss_report_status,
                              'wp_ss_comments': comments ??
                                  snapshot.data!.data![0].wp_ss_comments,
                            };
                            var res = await SendMarketCheck2Details()
                                .sendMarketCheck2Details(dataTarget,
                                    "/updateSalaryDetails/${widget.surveyId}");
                            var body = jsonDecode(res.body);
                            if (body["success"]) {
                              showToastApp();
                              Navigator.pop(context);
                            } else {
                              showToastAppFalse();
                            }

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SuccessPage(
                            //               surveyId: widget.surveyId,
                            //               userId: widget.userId,
                            //               userName: widget.userName,
                            //             )));
                            // }
                            //  else {
                            //   print("validation failed");
                            // }
                          },
                          child: Row(
                            children: [
                              Text(
                                "Submit",
                                style: TextStyle(color: appColor),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: appColor,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  color: appColor,
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}

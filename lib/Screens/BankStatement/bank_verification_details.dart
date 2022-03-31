import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:radium_tech/Components/backToOptions.dart';
import 'package:radium_tech/Components/showLoderPauseScreen.dart';
import 'package:radium_tech/Components/upper_case.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Model/BankStatement/get_bank_verification_data.dart';
import 'package:radium_tech/Model/ResidenceModel/get_applicant_data.dart';
import 'package:radium_tech/Screens/ResidenceForm/verification_outcome.dart';
import 'package:radium_tech/Services/BankStatementApi/GetData/get_bank_verification_data.dart';
import 'package:radium_tech/Services/ResidenceApi/GetData/get_applicant_details.dart';
import 'package:radium_tech/Services/ResidenceApi/SendData/send_applicant_details.dart';
import 'package:radium_tech/Utils/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BankVerificationDetails extends StatefulWidget {
  final int surveyId;
  final String applicationTitle;
  final String formFormate;

  const BankVerificationDetails({
    Key? key,
    required this.surveyId,
    required this.applicationTitle,
    required this.formFormate,
  }) : super(key: key);

  @override
  _BankVerificationDetailsState createState() =>
      _BankVerificationDetailsState();
}

class _BankVerificationDetailsState extends State<BankVerificationDetails> {
  final formKey = GlobalKey<FormBuilderState>();
  Position? currentPosition;
  String? currentAddress;
  bool _loading = false;

  TextEditingController datepicker = TextEditingController();
  String? date;
  String? landmark;
  String? address;
  String? cell;
  String? work_phone;
  String? res_phone;
  String? father;
  String? name;
  Map<String, dynamic>? dataget;
  String? cnic;
  DateTime selectedDate = DateTime.now();
  var _dob;

  String? officer_mobile;

  String? accountNumber;

  String? accountTitle;

  Object? isAccountActive;

  String? opentingSince;

  Future<GetBankVerificationData>? getBankVerificationDataFromServer;

  String? branchName;

  String? branceCode;

  String? branchAddress;

  String? officerName;

  String? officerDesignamtion;

  String? bankName;

  Object? isDocumentStamped;

  Map<String, String>? locationData;

  bool confirmLocation = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1965, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dob = selectedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    getBankVerificationDataFromServer = GetBankVerificationDetails()
        .getResidenceDetails("/getBankStatement/${widget.surveyId}");
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
       title: Text(widget.applicationTitle),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: FutureBuilder<GetBankVerificationData>(
            future: getBankVerificationDataFromServer,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    FormBuilder(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            FormBuilderTextField(
                              onChanged: (value) {
                                bankName = value;
                              },
                              initialValue:
                                  snapshot.data!.data![0].bnkst_bank_name ?? "",
                              autocorrect: true,
                              name: 'bank_name',
                              decoration: inputDecoration(
                                  widget.formFormate == "4"
                                      ? "Office Name"
                                      : "Bank Name",
                                  ""),
                              keyboardType: TextInputType.name,
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            if (widget.formFormate == "3")
                              Column(
                                children: [
                                  FormBuilderTextField(
                                      onChanged: (value) {
                                        branceCode = value;
                                      },
                                      initialValue: snapshot
                                              .data!.data![0].bnkst_branch ??
                                          "",
                                      name: 'baranch_code_name',
                                      decoration: inputDecoration(
                                          "Branch Code & Name", ""),
                                      keyboardType: TextInputType.name),
                                  SizedBox(
                                    height: 22,
                                  ),
                                ],
                              ),
                            FormBuilderTextField(
                                maxLines: 5,
                                onChanged: (value) {
                                  branchAddress = value;
                                },
                                initialValue: snapshot
                                        .data!.data![0].bnkst_branch_address ??
                                    "",
                                name: 'baranch_address',
                                decoration: inputDecoration(
                                    widget.formFormate == "4"
                                        ? "Office Address"
                                        : "Bank Address",
                                    ""),
                                keyboardType: TextInputType.name),
                            SizedBox(
                              height: 22,
                            ),
                            Text(
                              currentAddress != null
                                  ? currentAddress!
                                  : "Location",
                              style: TextStyle(color: appColor),
                            ),
                            Visibility(
                              visible: confirmLocation,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: appColor)),
                                  color: appColor.withOpacity(.5),
                                  onPressed: () async {
                                    locationData = {
                                      "longitude":
                                          currentPosition!.longitude.toString(),
                                      "latitiude":
                                          currentPosition!.latitude.toString(),
                                    };
                                    print(locationData);
                                    var res = await SendApplicantDetails()
                                        .sendApplicantDetails(locationData,
                                            "/updateCordinates/${widget.surveyId}");
                                    var body = jsonDecode(res.body);
                                    if (body["success"]) {
                                      showToastApp();
                                    }
                                  },
                                  child: Container(
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: appColor),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Confirm Location",
                                        style: TextStyle(color: textColor),
                                      ))),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                onChanged: (value) {
                                  landmark = value;
                                },
                                initialValue:
                                    snapshot.data!.data![0].bnkst_landmark ??
                                        "",
                                name: 'landmark',
                                decoration: inputDecoration(
                                    "Landmark", "Enter Landmark"),
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                onChanged: (value) {
                                  officerName = value;
                                },
                                initialValue: snapshot
                                        .data!.data![0].bnkst_officer_name ??
                                    "",
                                name: 'office_name',
                                decoration:
                                    inputDecoration("Officer's Name", ""),
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                onChanged: (value) {
                                  officerDesignamtion = value;
                                },
                                initialValue: snapshot.data!.data![0]
                                        .bnkst_officer_designation ??
                                    "",
                                name: 'office_designamtion',
                                decoration: inputDecoration(
                                    "Officer's Designamtion", ""),
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: 22,
                            ),
                            TextFormField(
                                initialValue: snapshot
                                        .data!.data![0].bnkst_officer_mobile ??
                                    "",
                                onChanged: (val) {
                                  officer_mobile = val;
                                },
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                  MaskTextInputFormatter(
                                      mask: "+92-###-#######"),
                                ],
                                autocorrect: false,
                                keyboardType: TextInputType.phone,
                                autovalidateMode: AutovalidateMode.always,
                                validator: null,
                                decoration: inputDecoration(
                                    "Officer's Mobile", "+92-000-0000000")),
                            SizedBox(
                              height: 22,
                            ),
                            if (widget.formFormate == "3")
                              Column(
                                children: [
                                  FormBuilderTextField(
                                      onChanged: (value) {
                                        accountNumber = value;
                                      },
                                      initialValue: snapshot.data!.data![0]
                                              .bnkst_account_no ??
                                          "",
                                      name: 'account_number',
                                      decoration:
                                          inputDecoration("Account Number", ""),
                                      keyboardType: TextInputType.phone),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  FormBuilderTextField(
                                      onChanged: (value) {
                                        accountTitle = value;
                                      },
                                      initialValue: snapshot.data!.data![0]
                                              .bnkst_account_title ??
                                          "",
                                      name: 'account_title',
                                      decoration:
                                          inputDecoration("Account Title", ""),
                                      keyboardType: TextInputType.text),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  FormBuilderRadioGroup(
                                      initialValue: snapshot.data!.data![0]
                                              .bnkst_is_account_active ??
                                          "",
                                      decoration: inputDecoration(
                                          "Is Account Active", ''),
                                      activeColor: appColor,
                                      focusColor: appColor,
                                      onChanged: (val) {
                                        isAccountActive = val;
                                      },
                                      name: "is_account_active",
                                      options: [
                                        FormBuilderFieldOption(value: "Yes"),
                                        FormBuilderFieldOption(value: "No"),
                                      ]),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  FormBuilderTextField(
                                      onChanged: (value) {
                                        opentingSince = value;
                                      },
                                      initialValue: snapshot.data!.data![0]
                                              .bnkst_operating_since ??
                                          "",
                                      name: 'opening_sonce',
                                      decoration:
                                          inputDecoration("Opening Since", ""),
                                      keyboardType: TextInputType.text),
                                  SizedBox(
                                    height: 22,
                                  ),
                                ],
                              ),
                            FormBuilderRadioGroup(
                                initialValue: snapshot
                                    .data!.data![0].bnkst_document_stamped,
                                decoration:
                                    inputDecoration("Is Document Stamped", ""),
                                activeColor: appColor,
                                focusColor: appColor,
                                onChanged: (val) {
                                  isDocumentStamped = val;
                                },
                                name: "is_document_stamped",
                                options: [
                                  FormBuilderFieldOption(value: "Yes"),
                                  FormBuilderFieldOption(value: "No"),
                                ]),
                            SizedBox(
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BackToOptions(),
                        MaterialButton(
                          onPressed: () async {
                            buildShowDialog(context);
                            formKey.currentState!.save();
                            print(datepicker.text);
                            print(date);

                            dataget = {
                              "bnkst_bank_name": bankName ??
                                  snapshot.data!.data![0].bnkst_bank_name,
                              "bnkst_branch": branceCode ??
                                  snapshot.data!.data![0].bnkst_branch,
                              "bnkst_branch_address": branchAddress ??
                                  snapshot.data!.data![0].bnkst_branch_address,
                              "bnkst_landmark": landmark ??
                                  snapshot.data!.data![0].bnkst_landmark,
                              "bnkst_officer_name": officerName ??
                                  snapshot.data!.data![0].bnkst_officer_name,
                              "bnkst_officer_designation":
                                  officerDesignamtion ??
                                      snapshot.data!.data![0]
                                          .bnkst_officer_designation,
                              "bnkst_officer_mobile": officer_mobile ??
                                  snapshot.data!.data![0].bnkst_officer_mobile,
                              "bnkst_account_no": accountNumber ??
                                  snapshot.data!.data![0].bnkst_account_no,
                              "bnkst_account_title": accountTitle ??
                                  snapshot.data!.data![0].bnkst_account_title,
                              "bnkst_is_account_active": isAccountActive ??
                                  snapshot
                                      .data!.data![0].bnkst_is_account_active,
                              "bnkst_operating_since": opentingSince ??
                                  snapshot.data!.data![0].bnkst_operating_since,
                              "bnkst_document_stamped": isDocumentStamped ??
                                  snapshot
                                      .data!.data![0].bnkst_document_stamped,
                            };
                            print(dataget);

                            var res = await SendApplicantDetails()
                                .sendApplicantDetails(dataget,
                                    "/updateBankStatement/${widget.surveyId}");
                            var body = jsonDecode(res.body);
                            if (body["success"]) {
                              showToastApp();
                              Navigator.pop(context);
                              Navigator.pop(context);
                              
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: appColor)),
                          color: appColor.withOpacity(.5),
                          child: Row(
                            children: [
                              Text(
                                "Submit",
                                style: TextStyle(color: textColor),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: textColor,
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

  _getCurrentLocation() async {
    setState(() {
      _loading = true;
    });
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);
      print(placemarks);
      Placemark place = placemarks[0];

      setState(() {
        currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}, ${place.subLocality}, ";
        print(currentAddress);
        _loading = false;
        confirmLocation = true;
      });
    } catch (e) {
      print(e);
    }
  }
}

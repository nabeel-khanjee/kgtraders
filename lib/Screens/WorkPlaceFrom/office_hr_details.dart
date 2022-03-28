import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/showLoderPauseScreen.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Components/upper_case.dart';
import 'package:radium_tech/Model/WorkPlaceModel/get_hr_data.dart';
import 'package:radium_tech/Model/WorkPlaceModel/get_market_check_2_data.dart';
import 'package:radium_tech/Screens/ResidenceForm/verification_outcome.dart';
import 'package:radium_tech/Services/WorkplaceApi/GetData/get_hr_details.dart';
import 'package:radium_tech/Services/WorkplaceApi/GetData/get_market_check_2_details.dart';
import 'package:radium_tech/Services/WorkplaceApi/SendData/send_market_check_2.dart';
import 'package:radium_tech/Utils/colors.dart';
import 'package:radium_tech/Components/backToOptions.dart';

class OfficeHrDetails extends StatefulWidget {
  const OfficeHrDetails(
      {Key? key, required this.surveyId, required this.apptitle})
      : super(key: key);
  final int surveyId;
  final String apptitle;

  @override
  _OfficeHrDetailsState createState() => _OfficeHrDetailsState();
}

class _OfficeHrDetailsState extends State<OfficeHrDetails> {
  final formKey = GlobalKey<FormBuilderState>();

  var applicantJobStatus = [
    'Permanent',
    'Temporary',
    'Contractual',
    'Third Party',
    'Others'
  ];

  Object? isKnowApplicant;
  DateTime selectedDate = DateTime.now();
  var _dob;

  String? personMet;

  Object? applicantEnvironmentStatus;

  String? applicantDesignation;

  String? verifierName;

  String? verifierDesignation;

  String? verifierPhone;

  String? verifierMobile;

  String? verifierEmail;

  Map<String, Object?>? dataTaeget;

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

  Future<GetHrData>? marketCheck2DetailsFromServer;
  @override
  void initState() {
    marketCheck2DetailsFromServer =
        GetHrDetails().getHrDetails("/getHRDetails/${widget.surveyId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.apptitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: FutureBuilder<GetHrData>(
              future: marketCheck2DetailsFromServer,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      FormBuilder(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FormBuilderTextField(
                                autocorrect: true,
                                initialValue: snapshot.data!.data![0]
                                        .wp_ohr_name_of_person_met ??
                                    "",
                                name: 'person_met',
                                onChanged: (val) {
                                  personMet = val;
                                },
                                decoration:
                                    inputDecoration("Name of Person Met", ""),
                                // onChanged: _onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter The Neighbour Name"),
                                //   FormBuilderValidators.min(context, 70,
                                //       errorText: "Max Range is 70"),
                                // ]),
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderRadioGroup(
                              initialValue: snapshot
                                      .data!.data![0].wp_ohr_knows_applicant ??
                                  "",
                              name: "knows_applicant",
                              // validator: FormBuilderValidators.required(context,
                              //     errorText: "Please Select"),
                              onChanged: (value) {
                                setState(() {
                                  isKnowApplicant = value;
                                  snapshot.data!.data![0]
                                          .wp_ohr_knows_applicant =
                                      value as String?;
                                });
                              },

                              decoration:
                                  inputDecoration("Knows Applicant", ""),
                              activeColor: appColor,
                              options: [
                                FormBuilderFieldOption(value: "Yes"),
                                FormBuilderFieldOption(value: "No"),
                                FormBuilderFieldOption(value: "Refused"),
                              ],
                            ),
                            if (isKnowApplicant == "Yes" ||
                                snapshot.data!.data![0]
                                        .wp_ohr_knows_applicant ==
                                    "Yes")
                              Column(
                                children: [
                                  SizedBox(height: 22),
                                  FormBuilderDropdown(
                                    onChanged: (value) {
                                      applicantEnvironmentStatus = value;
                                    },
                                    items: [
                                      "Permanent",
                                      "Temporary",
                                      'Contractual',
                                      'Third Party',
                                      'Others',
                                    ]
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    initialValue: snapshot.data!.data![0]
                                            .wp_ohr_employment_status ??
                                        "Permanent",
                                    name: 'applicant_employement_status',
                                    decoration: inputDecoration(
                                        "Applicant Employement Status",
                                        ""), // onChanged: _onChanged,
                                    // valueTransformer: (text) => num.tryParse(text),
                                    // validator: FormBuilderValidators.compose([
                                    //   FormBuilderValidators.required(context,
                                    //       errorText:
                                    //           "Please Enter The Knowing Years"),
                                    //   FormBuilderValidators.min(context, 70,
                                    //       errorText: "Max Range is 70"),
                                    // ]),
                                  ),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: appColor)),
                                    child: MaterialButton(
                                      onPressed: () async {
                                        setState(() {
                                          _dob = "$selectedDate.toLocal()}"
                                              .split(' ')[0];
                                        });

                                        _selectDate(context);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Date of Joining",
                                            style: TextStyle(color: appColor),
                                          ),
                                          Text(
                                            _dob != null
                                                ? "$_dob".split(' ')[0]
                                                : snapshot.data!.data![0]
                                                            .wp_ohr_date_of_joining !=
                                                        null
                                                    ? snapshot.data!.data![0]
                                                        .wp_ohr_date_of_joining!
                                                    : "Pick Date",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  FormBuilderTextField(
                                      onChanged: (value) {
                                        applicantDesignation = value;
                                      },
                                      initialValue: snapshot.data!.data![0]
                                          .wp_ohr_applicant_designation,
                                      name: 'mc_two_business_established_since',
                                      decoration: inputDecoration(
                                          "Applicant's Designamtion",
                                          ""), // onChanged: _onChanged,
                                      // valueTransformer: (text) => num.tryParse(text),
                                      // validator: FormBuilderValidators.compose([
                                      //   FormBuilderValidators.required(context,
                                      //       errorText:
                                      //           "Please Enter The Knowing Years"),
                                      //   FormBuilderValidators.min(context, 70,
                                      //       errorText: "Max Range is 70"),
                                      // ]),
                                      keyboardType: TextInputType.text),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  FormBuilderTextField(
                                      onChanged: (value) {
                                        verifierName = value;
                                      },
                                      initialValue: snapshot
                                          .data!.data![0].wp_ohr_verifier_name,
                                      name: 'mc_two_designation_of_met_person',
                                      decoration: inputDecoration(
                                          "Verifier's Name",
                                          ""), // onChanged: _onChanged,
                                      // valueTransformer: (text) => num.tryParse(text),
                                      // validator: FormBuilderValidators.compose([
                                      //   FormBuilderValidators.required(context,
                                      //       errorText:
                                      //           "Please Enter The Knowing Years"),
                                      //   FormBuilderValidators.min(context, 70,
                                      //       errorText: "Max Range is 70"),
                                      // ]),
                                      keyboardType: TextInputType.text),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  FormBuilderTextField(
                                      onChanged: (value) {
                                        verifierDesignation = value;
                                      },
                                      initialValue: snapshot.data!.data![0]
                                          .wp_ohr_verifier_designation,
                                      name: 'mc_two_applicant_designation',
                                      decoration: inputDecoration(
                                          "Verifiers's Designamtion",
                                          ""), // onChanged: _onChanged,
                                      // valueTransformer: (text) => num.tryParse(text),
                                      // validator: FormBuilderValidators.compose([
                                      //   FormBuilderValidators.required(context,
                                      //       errorText:
                                      //           "Please Enter The Knowing Years"),
                                      //   FormBuilderValidators.min(context, 70,
                                      //       errorText: "Max Range is 70"),
                                      // ]),
                                      keyboardType: TextInputType.text),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  FormBuilderTextField(
                                      onChanged: (value) {
                                        verifierPhone = value;
                                      },
                                      initialValue: snapshot
                                          .data!.data![0].wp_ohr_verifier_phone,
                                      name: 'mc_two_applicant_nature_of_job',
                                      inputFormatters: [
                                        UpperCaseTextFormatter(),
                                        MaskTextInputFormatter(
                                            mask: "+92-###-#######"),
                                      ],
                                      decoration: inputDecoration(
                                          "Verifier's Phone",
                                          ""), // onChanged: _onChanged,
                                      // valueTransformer: (text) => num.tryParse(text),
                                      // validator: FormBuilderValidators.compose([
                                      //   FormBuilderValidators.required(context,
                                      //       errorText:
                                      //           "Please Enter The Knowing Years"),
                                      //   FormBuilderValidators.min(context, 70,
                                      //       errorText: "Max Range is 70"),
                                      // ]),
                                      keyboardType: TextInputType.phone),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  FormBuilderTextField(
                                      onChanged: (value) {
                                        verifierMobile = value;
                                      },
                                      initialValue: snapshot.data!.data![0]
                                          .wp_ohr_verifier_mobile,
                                      name: 'mc_two_applicant_salary',
                                      inputFormatters: [
                                        UpperCaseTextFormatter(),
                                        MaskTextInputFormatter(
                                            mask: "+92-###-#######"),
                                      ],
                                      decoration: inputDecoration(
                                          "Verifier's Mobile",
                                          ""), // onChanged: _onChanged,
                                      // valueTransformer: (text) => num.tryParse(text),
                                      // validator: FormBuilderValidators.compose([
                                      //   FormBuilderValidators.required(context,
                                      //       errorText:
                                      //           "Please Enter The Knowing Years"),
                                      //   FormBuilderValidators.min(context, 70,
                                      //       errorText: "Max Range is 70"),
                                      // ]),
                                      keyboardType: TextInputType.phone),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  FormBuilderTextField(
                                      initialValue: snapshot
                                          .data!.data![0].wp_ohr_verifier_email,
                                      name: 'mc_two_applicant_salary',
                                      onChanged: (val) {
                                        verifierEmail = val;
                                      },
                                      decoration: inputDecoration(
                                          "Verifiers's Email",
                                          ""), // onChanged: _onChanged,
                                      // valueTransformer: (text) => num.tryParse(text),
                                      // validator: FormBuilderValidators.compose([
                                      //   FormBuilderValidators.required(context,
                                      //       errorText:
                                      //           "Please Enter The Knowing Years"),
                                      //   FormBuilderValidators.min(context, 70,
                                      //       errorText: "Max Range is 70"),
                                      // ]),
                                      keyboardType: TextInputType.text),
                                ],
                              ),
                          ],
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

                              // if (formKey.currentState!.validate()) {
                              print(formKey.currentState!.value);
                              var data = formKey.currentState!.value;
                              dataTaeget = {
                                'wp_ohr_name_of_person_met': personMet ??
                                    snapshot.data!.data![0]
                                        .wp_ohr_name_of_person_met,
                                'wp_ohr_knows_applicant': isKnowApplicant ??
                                    snapshot
                                        .data!.data![0].wp_ohr_knows_applicant,
                                'wp_ohr_employment_status':
                                    applicantEnvironmentStatus ??
                                        snapshot.data!.data![0]
                                            .wp_ohr_employment_status,
                                "wp_ohr_date_of_joining":
                                    "$selectedDate.toLocal()}".split(" ")[0],
                                'wp_ohr_applicant_designation':
                                    applicantDesignation ??
                                        snapshot.data!.data![0]
                                            .wp_ohr_applicant_designation,
                                'wp_ohr_verifier_name': verifierName ??
                                    snapshot
                                        .data!.data![0].wp_ohr_verifier_name,
                                'wp_ohr_verifier_designation':
                                    verifierDesignation ??
                                        snapshot.data!.data![0]
                                            .wp_ohr_verifier_designation,
                                'wp_ohr_verifier_phone': verifierPhone ??
                                    snapshot
                                        .data!.data![0].wp_ohr_verifier_phone,
                                'wp_ohr_verifier_mobile': verifierMobile ??
                                    snapshot
                                        .data!.data![0].wp_ohr_verifier_mobile,
                                'wp_ohr_verifier_email': verifierEmail ??
                                    snapshot
                                        .data!.data![0].wp_ohr_verifier_email
                              };
                              var res = await SendMarketCheck2Details()
                                  .sendMarketCheck2Details(dataTaeget,
                                      "/updateHRDetails/${widget.surveyId}");
                              var body = jsonDecode(res.body);
                              if (body["success"]) {
                                showToastApp();
                                Navigator.pop(context);
                                               Navigator.pop(context);
                 
                              } else {
                                showToastAppFalse();
                              }
                          // showToastApp();
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
      ),
    );
  }
}

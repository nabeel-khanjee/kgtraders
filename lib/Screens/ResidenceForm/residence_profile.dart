import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Components/upper_case.dart';
import 'package:radium_tech/Model/ResidenceModel/get_residence_data.dart';
import 'package:radium_tech/Screens/ResidenceForm/verification_outcome.dart';
import 'package:radium_tech/Services/ResidenceApi/GetData/get_residence_details.dart';
import 'package:radium_tech/Services/ResidenceApi/SendData/send_residence_details.dart';
import 'package:radium_tech/Utils/colors.dart';

class ResidenceProfile extends StatefulWidget {
  const ResidenceProfile(
      {Key? key,
      required this.surveyId,
      required this.userId,
      required this.userName,
      required this.applicationTitle})
      : super(key: key);
  final int surveyId;
  final String userId;
  final String userName;
  final String applicationTitle;
  @override
  _ResidenceProfileState createState() => _ResidenceProfileState();
}

enum IsApplicantAvaliable { yes, no }
enum IsAddressCorrect { yes, no }

class _ResidenceProfileState extends State<ResidenceProfile> {
  final formKey = GlobalKey<FormBuilderState>();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  var residenceType = ['House/Bungalow', 'Portion', 'Apartment', 'Others'];

  var residenceIs = [
    'Owned',
    'Rented',
    'Relatives',
    'Parents/Joint',
    'Mortgaged',
    'Pagree',
    'Others'
  ];

  var residenceUtilization = [
    'Residential',
    "Commercial",
    'Residential and Commercial',
    'Industrial'
  ];

  var residenceAreaUnit = [
    "Sq Feets",
    "Sq Yards",
    "Sq Meter",
    "Marla",
    'Acre',
    'Kanal',
    'Hectar',
    'Murabba',
    'Guntha'
  ];

  var residenceCondition = [
    'Excellent',
    'Average',
    'Good',
  ];

  var areaCondition = [
    'Excellent',
    'Average',
    'Good',
  ];

  var residentsBelongTo = [
    "Upper",
    'Upper Middle',
    'Middle',
    "Lower",
  ];

  SendResidenceDetails sendResidenceDetails = SendResidenceDetails();

  Map<String, dynamic>? data;

  Object? isApplicantAvaliable;

  Object? doesApplicantLiveHere;

  Object? isAddressCorrect;

  Object? residenceTypeChange;

  Object? residenceIsChange;

  Future<GetResidenceData>? getResidenceData;
  @override
  void initState() {
   getResidenceData= GetResidenceDetails().getResidenceDetails(
                  "/getResidenceProfile/${widget.surveyId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.applicationTitle),
      ),
      bottomNavigationBar:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BackToOptions(),
                          MaterialButton(
                            onPressed: () async {
                              formKey.currentState!.save();
                              if (formKey.currentState!.validate()) {
                                print(formKey.currentState!.value);
                                data = formKey.currentState!.value;
                                var res = await sendResidenceDetails
                                    .sendResidenceDetails(data,
                                        '/updateResidenceProfile/${widget.surveyId}');

                                var body = jsonDecode(res.body);
                                print(body);
                                print(widget.surveyId);
                                if (body['success']) {
                                  showToastApp();
                                  Navigator.pop(context);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => SuccessPage(
                                  //               surveyId: widget.surveyId,
                                  //               userId: widget.userId,
                                  //               userName: widget.userName,
                                  //             )));
                                }
                              } else {
                                print("validation failed");
                              }
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
                    
      body: SingleChildScrollView(
        child: Form(
          child: FutureBuilder<GetResidenceData>(
              future: getResidenceData,
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
                              FormBuilderRadioGroup(
                                // validator: FormBuilderValidators.required(
                                //     context,
                                //     errorText: "Please Select"),
                                onChanged: (value) {
                                  setState(() {
                                    isApplicantAvaliable = value;
                                    snapshot.data!.data![0]
                                            .applicant_is_avaliable =
                                        value as String?;
                                  });
                                },
                                name: "applicant_is_avaliable",
                                decoration: inputDecoration(
                                    "Is Applicant Avaliable", ""),
                                initialValue: snapshot
                                    .data!.data![0].applicant_is_avaliable
                                    .toString(),
                                activeColor: appColor,
                                options: [
                                  FormBuilderFieldOption(value: "Yes"),
                                  FormBuilderFieldOption(value: "No"),
                                ],
                              ),
                              if (isApplicantAvaliable == "Yes" ||
                                  snapshot.data!.data![0]
                                          .applicant_is_avaliable ==
                                      "Yes")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderRadioGroup(
                                      // validator: FormBuilderValidators.required(
                                      //     context,
                                      //     errorText: "Please Select"),
                                      name: "original_nic_seen",
                                      decoration: inputDecoration(
                                          "Orignal Cnic Seen", ""),
                                      initialValue: snapshot.data!.data![0]
                                              .original_nic_seen ??
                                          "",
                                      activeColor: appColor,
                                      options: [
                                        FormBuilderFieldOption(value: "Yes"),
                                        FormBuilderFieldOption(value: "No"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .cnic_of_applicant ??
                                            "",
                                        name: 'cnic_of_applicant',
                                        inputFormatters: [
                                          UpperCaseTextFormatter(),
                                          MaskTextInputFormatter(
                                              mask: "#####-#######-#"),
                                        ],
                                        decoration: inputDecoration(
                                            "CNIC of Applicant", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.phone),
                                  ],
                                ),
                              if (isApplicantAvaliable == "No" ||
                                  snapshot.data!.data![0]
                                          .applicant_is_avaliable ==
                                      "No")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .name_of_person_met ??
                                            "",
                                        name: 'name_of_person_met',
                                        decoration: inputDecoration(
                                            "Name of Person Met", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.name),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .nic_of_person_met ??
                                            "",
                                        name: 'nic_of_person_met',
                                        inputFormatters: [
                                          UpperCaseTextFormatter(),
                                          MaskTextInputFormatter(
                                              mask: "#####-#######-#"),
                                        ],
                                        decoration: inputDecoration(
                                            "CNIC of Person Met", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.phone),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .relationship_with_applicant ??
                                            "",
                                        name: 'relationship_with_applicant',
                                        decoration: inputDecoration(
                                            "Relationship with Applicant",
                                            ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.text),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue:
                                            snapshot.data!.data![0].rel_phone ??
                                                "",
                                        name: 'rel_phone',
                                        inputFormatters: [
                                          UpperCaseTextFormatter(),
                                          MaskTextInputFormatter(
                                              mask: "+92-###-#######"),
                                        ],
                                        decoration:
                                            inputDecoration("Phone (Res)", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.phone),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        inputFormatters: [
                                          UpperCaseTextFormatter(),
                                          MaskTextInputFormatter(
                                              mask: "+92-###-#######"),
                                        ],
                                        initialValue:
                                            snapshot.data!.data![0].rel_cell ??
                                                "",
                                        name: 'rel_cell',
                                        decoration:
                                            inputDecoration("Cell #", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.phone),
                                  ],
                                ),

                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderRadioGroup(
                                onChanged: (value) {
                                  setState(() {
                                    isAddressCorrect = value;

                                    snapshot.data!.data![0].is_address_correct =
                                        value as String?;
                                  });
                                },
                                activeColor: appColor,
                                name: "is_address_correct",
                                // validator: FormBuilderValidators.required(
                                //     context,
                                //     errorText: "Please Select"),
                                decoration: inputDecoration(
                                    "Is Address Correct", ""),
                                initialValue: snapshot
                                        .data!.data![0].is_address_correct ??
                                    "",
                                options: [
                                  FormBuilderFieldOption(value: "Yes"),
                                  FormBuilderFieldOption(value: "No"),
                                ],
                              ),
                              if (isAddressCorrect == "No" ||
                                  snapshot.data!.data![0].is_address_correct ==
                                      "No")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot
                                            .data!.data![0].correct_address
                                            ??"",
                                        name: 'correct_address',
                                        decoration: inputDecoration(
                                            "Correct Address", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.text),
                                  ],
                                ),

                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderRadioGroup(
                                activeColor: appColor,
                                initialValue: snapshot.data!.data![0]
                                        .does_applicant_live_here ??
                                    "",
                                onChanged: (value) {
                                  setState(() {
                                    doesApplicantLiveHere = value;

                                    snapshot.data!.data![0]
                                            .does_applicant_live_here =
                                        value as String;
                                  });
                                },
                                name: "does_applicant_live_here",
                                // validator: FormBuilderValidators.required(
                                //     context,
                                //     errorText: "Please Select"),
                                decoration: inputDecoration(
                                    "Does Applicant Live Here", "hintText"),
                                options: [
                                  FormBuilderFieldOption(value: "Yes"),
                                  FormBuilderFieldOption(value: "No"),
                                ],
                              ),
                              if (doesApplicantLiveHere == "Yes" ||
                                  snapshot.data!.data![0]
                                          .does_applicant_live_here ==
                                      "Yes")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot
                                                .data!.data![0].living_since ??
                                            "",
                                        name: 'living_since',
                                        decoration: inputDecoration(
                                            "Living Since", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.text),
                                  ],
                                ),
                              if (doesApplicantLiveHere == "No" ||
                                  snapshot.data!.data![0]
                                          .does_applicant_live_here ==
                                      "No")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .permanent_address ??
                                            "",
                                        name: 'permanent_address',
                                        decoration: inputDecoration(
                                            "Permanent Address", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.text),
                                  ],
                                ),

                              SizedBox(
                                height: 22,
                              ),

                              FormBuilderRadioGroup(
                                activeColor: appColor,
                                initialValue:
                                    snapshot.data!.data![0].is_name_plate ?? "",
                                name: "is_name_plate",
                                // validator: FormBuilderValidators.required(
                                //     context,
                                //     errorText: "Please Select"),
                                decoration: inputDecoration(
                                    "Name Plate affixed at Residence?",
                                    "hintText"),
                                options: [
                                  FormBuilderFieldOption(value: "Yes"),
                                  FormBuilderFieldOption(value: "No"),
                                ],
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderDropdown(
                                // activeColor: appColor,
                                initialValue:
                                    snapshot.data!.data![0].residence_type ??
                                        residenceType[0],
                                onChanged: (value) {
                                  setState(() {
                                    snapshot.data!.data![0].residence_type =
                                        value as String;
                                    residenceTypeChange = value;
                                  });
                                },
                                name: 'residence_type',
                                decoration: inputDecoration(
                                    "Residence Type", "House/Bangalow"),
                                allowClear: true,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Select The Residence Type")
                                // ]),
                                items: residenceType
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text('$value'),
                                        ))
                                    .toList(),
                              ),
                              if (residenceTypeChange == "Others" ||
                                  snapshot.data!.data![0].residence_type ==
                                      "Others")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .other_residence_type ??
                                            "",
                                        name: 'other_residence_type',
                                        decoration: inputDecoration(
                                            "Other Details", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.text),
                                  ],
                                ),

                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderDropdown(
                                //  activeColor: appColor,
                                initialValue:
                                    snapshot.data!.data![0].residence_is ??
                                        residenceIs[0],
                                name: 'residence_is',
                                decoration: inputDecoration("Residence Is", ""),
                                allowClear: true,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText: "PLease Select")
                                // ]),
                                onChanged: (val) {
                                  setState(() {
                                    snapshot.data!.data![0]
                                            .residence_is =
                                        val as String;
                                    residenceIsChange = val;
                                  });
                                },

                                items: residenceIs
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text('$value'),
                                        ))
                                    .toList(),
                              ),
                              if (residenceIsChange == 'Rented' ||
                                  snapshot.data!.data![0].residence_is ==
                                      "Rented")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot
                                                .data!.data![0].monthly_rent ??
                                            "",
                                        name: 'monthly_rent',
                                        decoration:
                                            inputDecoration("Monthly Rent", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.text),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderRadioGroup(
                                      activeColor: appColor,
                                      initialValue: snapshot.data!.data![0]
                                              .rent_deed_verified ??
                                          "",
                                      name: "rent_deed_verified",
                                      // validator: FormBuilderValidators.required(
                                      //     context,
                                      //     errorText: "Please Select"),
                                      decoration: inputDecoration(
                                          "Rent Deed Verified", ""),
                                      options: [
                                        FormBuilderFieldOption(value: "Yes"),
                                        FormBuilderFieldOption(value: "No"),
                                      ],
                                    ),
                                  ],
                                ),
                              if (residenceIsChange == "Others"||
                                  snapshot.data!.data![0]
                                          .residence_is ==
                                      "Others")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .residence_is_other ??
                                            "",
                                        name: 'other_residence_type',
                                        decoration: inputDecoration(
                                            "Other Details", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.text),
                                  ],
                                ),

                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderDropdown(
                                initialValue: snapshot
                                        .data!.data![0].residence_utilization ??
                                    residenceUtilization[0],
                                name: 'residence_utilization',
                                decoration: inputDecoration(
                                    "Residence Utilization", "Residential"),
                                allowClear: true,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Select The Residence Utilization")
                                // ]),
                                items: residenceUtilization
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text('$value'),
                                        ))
                                    .toList(),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderTextField(
                                  initialValue:
                                      snapshot.data!.data![0].residence_area ??
                                          "",
                                  name: 'residence_area',
                                  decoration: inputDecoration(
                                      "Residence Area", "Residence Area"),
                                  // validator: FormBuilderValidators.compose([
                                  //   FormBuilderValidators.required(context,
                                  //       errorText:
                                  //           "Please Select The Residence Area"),
                                  //   FormBuilderValidators.numeric(context,
                                  //       errorText: "Please Select The Number"),
                                  //   FormBuilderValidators.min(context, 70,
                                  //       errorText: "Max Range is 70"),
                                  // ]),
                                  keyboardType: TextInputType.phone),

                              // FormBuilderSlider(
                              //   name: 'residence_area',
                              //   validator: FormBuilderValidators.compose([
                              //     FormBuilderValidators.min(context, 6),
                              //   ]),
                              //   // onChanged: _onChanged,
                              //   min: 0.0,
                              //   max: 100.0,
                              //   initialValue: 7.0,
                              //   divisions: 20,
                              //   activeColor: appColor,
                              //   inactiveColor: appColor.withOpacity(0.5),
                              //   decoration: InputDecoration(
                              //     labelText: 'Residence Area',
                              //             labelStyle: TextStyle(color: appColor)),

                              // ),
                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderDropdown(
                                initialValue: snapshot
                                        .data!.data![0].residence_area_unit ??
                                    residenceAreaUnit[0],
                                name: 'residence_area_unit',
                                decoration: inputDecoration(
                                    "Residence Area Unit", "Sq. Feet"),
                                allowClear: true,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText: "Please Select the Residence")
                                // ]),
                                items: residenceAreaUnit
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        ))
                                    .toList(),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderTextField(
                                  initialValue: snapshot.data!.data![0]
                                          .residence_area_details ??
                                      "",
                                  name: 'residence_area_details',
                                  decoration: inputDecoration(
                                      "Residence Area Details",
                                      "A/House Number,Area,City"),
                                  // validator: FormBuilderValidators.compose([
                                  //   FormBuilderValidators.required(context,
                                  //       errorText:
                                  //           "Please fill the Residence Area Details"),
                                  //   FormBuilderValidators.min(context, 70,
                                  //       errorText: "Max Range is 70"),
                                  // ]),
                                  keyboardType: TextInputType.text),

                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderDropdown(
                                initialValue: snapshot
                                        .data!.data![0].residence_condition ??
                                    residenceCondition[0],
                                name: 'residence_condition',
                                decoration: inputDecoration(
                                    "Residence Condition",
                                    "Residence Condition"),
                                allowClear: true,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please select the Residence Condition")
                                // ]),
                                items: residenceCondition
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text('$value'),
                                        ))
                                    .toList(),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderDropdown(
                                initialValue:
                                    snapshot.data!.data![0].area_condition ??
                                        areaCondition[0],
                                name: 'area_condition',
                                decoration: inputDecoration(
                                    "Area Condition", "Area Condition"),
                                allowClear: true,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please select the Area Condition")
                                // ]),
                                items: areaCondition
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text('$value'),
                                        ))
                                    .toList(),
                              ),

                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderRadioGroup(
                                activeColor: appColor,
                                initialValue:
                                    snapshot.data!.data![0].neighbourhood ?? "",
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText: "Please Select")
                                // ]),
                                name: "neighbourhood",
                                decoration: inputDecoration(
                                    "Neighbourhood", ""),
                                options: [
                                  FormBuilderFieldOption(value: "Planned"),
                                  FormBuilderFieldOption(value: "UnPlanned"),
                                ],
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderRadioGroup(
                                activeColor: appColor,
                                initialValue:
                                    snapshot.data!.data![0].area_accessbility ??
                                        "",
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText: "Please Select")
                                // ]),
                                name: "area_accessbility",
                                decoration: inputDecoration(
                                    "Area Accessbility", "hintText"),
                                options: [
                                  FormBuilderFieldOption(value: "Easy"),
                                  FormBuilderFieldOption(value: "Difficult"),
                                ],
                              ),

                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderDropdown(
                                initialValue: snapshot
                                        .data!.data![0].residents_belong_to ??
                                    residentsBelongTo[0],
                                name: 'residents_belong_to',
                                decoration: inputDecoration(
                                    "Residence Belonging", "Upper/Lower"),
                                allowClear: true,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText: "Please Select Belonging")
                                // ]),
                                items: residentsBelongTo
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text('$value'),
                                        ))
                                    .toList(),
                              ),

                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderRadioGroup(
                                activeColor: appColor,
                                initialValue:
                                    snapshot.data!.data![0].repossession ?? "",
                                name: "repossession",
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText: "Please Select")
                                // ]),
                                decoration: inputDecoration(
                                    "Repossession", "Repossession"),
                                options: [
                                  FormBuilderFieldOption(value: "Easy"),
                                  FormBuilderFieldOption(value: "Difficult"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                     ],
                  );
                } else {
                  return Align(
                      alignment: Alignment.center,
                      child: Center(
                      
                          child: CircularProgressIndicator(
                        color: appColor,
                        backgroundColor: Colors.grey,
                      )));
                }
              }),
        ),
      ),
    );
  }
}

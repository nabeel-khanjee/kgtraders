import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Components/upper_case.dart';
import 'package:radium_tech/Model/WorkPlaceModel/get_workplace_data.dart';
import 'package:radium_tech/Services/WorkplaceApi/GetData/get_workplace_details.dart';
import 'package:radium_tech/Services/WorkplaceApi/SendData/send_workplace_details.dart';
import 'package:radium_tech/Utils/colors.dart';

class BusinessProfile extends StatefulWidget {
  const BusinessProfile(
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
  _BusinessProfileState createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  final formKey = GlobalKey<FormBuilderState>();

  var businessType = [
    'Shop',
    'Office',
    'Factory',
    'Others',
  ];

  var premisesIs = [
    'Owned',
    'Rented',
    'Mortgaged',
    'Pagree',
    'Employee',
    'Others'
  ];

  var businessNature = [
    'Services',
    'Manufacturing',
    'Trading',
    'Retail',
    'Wholesale',
    'Others'
  ];

  var businessLegalEntity = [
    "Proprietorship",
    "Private Limited",
    'Partnership',
    'Public Limited',
    'Non-Government Organization',
  ];

  var businessAreaUnit = [
    "Sq Feet",
    "Sq Yard",
    "Sq Meters",
    "Marla",
    'Acre',
    'Kanal',
    'Hectar',
    'Murabba',
    'Guntha',
  ];

  var businessActivity = ['Low', 'Medium', 'High'];

  Map<String, dynamic>? data;

  Object? isApplicantAvaliable;

  Object? isAddressCorrect;

  Object? doesApplicantLiveHere;

  Object? businessTypeOther;

  Object? premisesIsOther;

  Object? businessNatureOther;

  Future<GetWorkplaceData>? getWorkPlaceDetailsFromServer;

  bool visible_establish_since = false;

  bool vasible_correct_address = false;
  @override
  void initState() {
    // TODO: implement initState
    getWorkPlaceDetailsFromServer = GetWorkPLaceDetails()
        .getWorkPlaceDetails("/getWorkplaceProfile/${widget.surveyId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.applicationTitle),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: FutureBuilder<GetWorkplaceData>(
              future: getWorkPlaceDetailsFromServer,
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
                                            .wp_is_applicant_available =
                                        value as String?;
                                  });
                                },

                                name: "applicant_is_avaliable",
                                decoration: inputDecoration(
                                    "Is Applicant Avaliable", ""),
                                initialValue: snapshot.data!.data![0]
                                        .wp_is_applicant_available ??
                                    "",

                                activeColor: appColor,
                                options: [
                                  FormBuilderFieldOption(value: "Yes"),
                                  FormBuilderFieldOption(value: "No"),
                                ],
                              ),
                              if (isApplicantAvaliable == "Yes" ||
                                  snapshot.data!.data![0]
                                          .wp_is_applicant_available ==
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
                                      name: "nic_seen",
                                      decoration: inputDecoration(
                                          "Orignal Cinc seen", "Yes/No"),
                                      initialValue: snapshot.data!.data![0]
                                              .wp_original_nic_seen ??
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
                                                .wp_nic_of_person_met ??
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
                                  ],
                                ),
                              if (isApplicantAvaliable == "No" ||
                                  snapshot.data!.data![0]
                                          .wp_is_applicant_available ==
                                      "No")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .wp_name_of_person_met ??
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
                                                .wp_nic_of_person_met ??
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
                                        initialValue: snapshot
                                                .data!.data![0].wp_res_phone ??
                                            "",
                                        name: 'res_phone',
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
                                        initialValue: snapshot
                                                .data!.data![0].wp_work_phone ??
                                            "",
                                        name: 'cell_of_person',
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
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .wp_reson_of_non_ava ??
                                            "",
                                        name: 'reson_of_non_ava',
                                        decoration: inputDecoration(
                                            "Reason of Non Avaliablity", ""),
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
                                onChanged: (value) {
                                  setState(() {
                                    isAddressCorrect = value;
                                    snapshot.data!.data![0]
                                            .wp_is_address_correct =
                                        value as String?;

                                    if (snapshot.data!.data![0]
                                            .wp_is_address_correct ==
                                        "Yes") {
                                      visible_establish_since = true;
                                      vasible_correct_address = false;
                                       snapshot.data!.data![0].wp_correct_address =
                                          null;
                                    } else {
                                      snapshot.data!.data![0].wp_establish_time =
                                          null;
                                      
                                      visible_establish_since = false;
                                      vasible_correct_address = true;
                                    }
                                  });
                                },
                                activeColor: appColor,
                                name: "is_address_correct",
                                // validator: FormBuilderValidators.required(
                                //     context,
                                //     errorText: "Please Select"),
                                decoration:
                                    inputDecoration("Is Address Correct", ""),
                                initialValue: snapshot
                                        .data!.data![0].wp_is_address_correct ??
                                    "",
                                options: [
                                  FormBuilderFieldOption(value: "Yes"),
                                  FormBuilderFieldOption(value: "No"),
                                ],
                              ),
                              if (isAddressCorrect == "Yes" ||
                                  snapshot.data!.data![0]
                                          .wp_is_address_correct ==
                                      "Yes")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .wp_establish_time ??
                                            "",
                                        name: 'establish_time',
                                        decoration: inputDecoration(
                                            "Established Time", ""),
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
                              if (isAddressCorrect == "No" ||
                                  snapshot.data!.data![0]
                                          .wp_is_address_correct ==
                                      "No")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .wp_correct_address ??
                                            "",
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
                                        .wp_does_applicant_works_here ??
                                    "",

                                onChanged: (value) {
                                  setState(() {
                                    doesApplicantLiveHere = value;
                                    snapshot.data!.data![0]
                                            .wp_does_applicant_works_here =
                                        value as String?;
                                  });
                                },
                                name: "does_applicant_works_here",
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
                              if (doesApplicantLiveHere == "No" ||
                                  snapshot.data!.data![0]
                                          .wp_does_applicant_works_here ==
                                      "No")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .wp_new_address ??
                                            "",
                                        name: 'new_address',
                                        decoration:
                                            inputDecoration("New Address", ""),
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
                              if (doesApplicantLiveHere == "Yes" ||
                                  snapshot.data!.data![0]
                                          .wp_does_applicant_works_here ==
                                      "Yes")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .wp_working_here_since ??
                                            "",
                                        name: 'working_here_since',
                                        decoration: inputDecoration(
                                            "Working Since", ""),
                                        // validator: FormBuilderValidators.compose([
                                        //   FormBuilderValidators.required(context,
                                        //       errorText:
                                        //           "Please Select The Residence Area"),
                                        //   FormBuilderValidators.numeric(context,
                                        //       errorText: "Please Select The Number"),
                                        // ]),
                                        keyboardType: TextInputType.number),
                                  ],
                                ),
                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderRadioGroup(
                                activeColor: appColor,
                                initialValue: snapshot
                                        .data!.data![0].wp_name_plate_affixed ??
                                    "",
                                name: "name_plate_affixed",
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
                                    snapshot.data!.data![0].wp_business_type ??
                                        businessType[0],

                                onChanged: (value) {
                                  setState(() {
                                    snapshot.data!.data![0].wp_business_type =
                                        value as String?;
                                    businessTypeOther = value;
                                  });
                                },
                                name: 'business_type',
                                decoration: inputDecoration(
                                    "Business Type", "Shop/Factory"),
                                allowClear: true,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Select The Residence Type")
                                // ]),
                                items: businessType
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        ))
                                    .toList(),
                              ),
                              if (businessTypeOther == "Others" ||
                                  snapshot.data!.data![0].wp_business_type ==
                                      "Others")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .wp_other_business_type ??
                                            "",
                                        name: 'other_business_type',
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
                                    snapshot.data!.data![0].wp_permisses_is ??
                                        premisesIs[0],
                                onChanged: (value) {
                                  setState(() {
                                    snapshot.data!.data![0].wp_permisses_is =
                                        value as String?;
                                    premisesIsOther = value;
                                  });
                                },
                                name: 'permisses_is',
                                decoration:
                                    inputDecoration("Premises Is", "Owner"),
                                allowClear: true,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText: "PLease Select")
                                // ]),
                                items: premisesIs
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text('$value'),
                                        ))
                                    .toList(),
                              ),
                              if (premisesIsOther == "Ranted" ||
                                  snapshot.data!.data![0].wp_permisses_is ==
                                      "Rented")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .wp_premissi_rent ??
                                            "",
                                        name: 'premissi_rent',
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
                                  ],
                                ),
                              if (premisesIsOther == "Others" ||
                                  snapshot.data!.data![0].wp_permisses_is ==
                                      "Others")
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .wp_other_permisses_is ??
                                            "",
                                        name: 'other_permisses_is',
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
                              FormBuilderTextField(
                                  initialValue: snapshot.data!.data![0]
                                          .wp_is_government_employee ??
                                      "",
                                  name: 'government_employee',
                                  decoration: inputDecoration(
                                      "Government Employee", ""),
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
                              FormBuilderDropdown(
                                initialValue: snapshot
                                        .data!.data![0].wp_business_nature ??
                                    businessNature[0],
                                name: 'business_nature',
                                validator: FormBuilderValidators.required(
                                    context,
                                    errorText:
                                        "please enter the business name"),
                                decoration: inputDecoration(
                                    "Business Nature", "Services/Marketing"),
                                allowClear: true,
                                onChanged: (value) {
                                  setState(() {
                                    snapshot.data!.data![0].wp_business_nature =
                                        value as String?;
                                    businessNatureOther = value;
                                  });
                                },
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Select The Residence Utilization")
                                // ]),
                                items: businessNature
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text('$value'),
                                        ))
                                    .toList(),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              if (businessNatureOther == "Others" ||
                                  snapshot.data!.data![0].wp_business_nature ==
                                      "Others")
                                Column(
                                  children: [
                                    FormBuilderTextField(
                                        initialValue: snapshot.data!.data![0]
                                                .wp_other_business_nature ??
                                            "",
                                        name: 'other_business_nature',
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
                                    SizedBox(
                                      height: 22,
                                    ),
                                  ],
                                ),
                              FormBuilderDropdown(
                                initialValue: snapshot.data!.data![0]
                                        .wp_business_legal_activity ??
                                    businessLegalEntity[0],
                                name: 'business_legal_activity',
                                decoration: inputDecoration(
                                    "Business Legal Entity",
                                    "Services/Marketing"),
                                allowClear: true,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Select The Residence Utilization")
                                // ]),
                                items: businessLegalEntity
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
                                      snapshot.data!.data![0].wp_area_size ??
                                          "",
                                  name: 'area_size',
                                  decoration: inputDecoration(
                                      "Business Area", "12345678"),
                                  keyboardType: TextInputType.number),
                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderDropdown(
                                initialValue:
                                    snapshot.data!.data![0].wp_area_unit ??
                                        businessAreaUnit[0],
                                name: 'area_unit',
                                decoration: inputDecoration(
                                    "Business Area Unit", "Sq. Feet"),
                                allowClear: true,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText: "Please Select the Residence")
                                // ]),
                                items: businessAreaUnit
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
                                  initialValue:
                                      snapshot.data!.data![0].wp_area_details ??
                                          "",
                                  name: 'area_details',
                                  decoration: inputDecoration(
                                      "Business Area Details",
                                      "A/House Number,Area,City"),
                                  keyboardType: TextInputType.text),
                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderDropdown(
                                initialValue: snapshot
                                        .data!.data![0].wp_business_activity ??
                                    businessActivity[0],
                                name: 'business_activity',
                                decoration: inputDecoration(
                                    "Business Activity", "Low/Medium/High"),
                                allowClear: true,
                                items: businessActivity
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
                                  initialValue: snapshot
                                          .data!.data![0].wp_no_of_employees ??
                                      "",
                                  name: 'no_of_employees',
                                  decoration: inputDecoration(
                                      "No of Employees", "numbers"),
                                  keyboardType: TextInputType.number),
                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderTextField(
                                // activeColor: appColor,
                                initialValue: snapshot
                                        .data!.data![0].wp_established_since ??
                                    "",
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText: "Please Select")
                                // ]),
                                name: "established_since",
                                decoration: inputDecoration(
                                    "Established Since", "Years/Month"),
                                // options: [
                                //   FormBuilderFieldOption(value: "Planned"),
                                //   FormBuilderFieldOption(value: "UnPlanned"),
                                // ],
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              FormBuilderTextField(
                                // activeColor: appColor,
                                initialValue:
                                    snapshot.data!.data![0].wp_business_line ??
                                        "",
                                name: "business_line",
                                decoration: inputDecoration(
                                    "Business Line", "hintText"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.navigate_before,
                                  color: appColor,
                                ),
                                Text(
                                  'Back to Form',
                                  style: TextStyle(color: appColor),
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              formKey.currentState!.save();
                              if (formKey.currentState!.validate()) {
                                print(formKey.currentState!.value);
                                data = formKey.currentState!.value;
                                var res = await SendWorkPlaceDetails()
                                    .sendWorkPlaceDetails(data,
                                        '/updateWorkplaceProfile/${widget.surveyId}');

                                var body = jsonDecode(res.body);
                                print(body);
                                if (body['success']) {
                                  showToastApp();
                                  Navigator.pop(context);
                                }
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
                    ],
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: appColor,
                  ));
                }
              }),
        ),
      ),
    );
  }
}

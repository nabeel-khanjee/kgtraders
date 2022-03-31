import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/showLoderPauseScreen.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Model/WorkPlaceModel/get_market_check_2_data.dart';
import 'package:radium_tech/Screens/ResidenceForm/verification_outcome.dart';
import 'package:radium_tech/Services/WorkplaceApi/GetData/get_market_check_2_details.dart';
import 'package:radium_tech/Services/WorkplaceApi/SendData/send_market_check_2.dart';
import 'package:radium_tech/Utils/colors.dart';
import 'package:radium_tech/Components/backToOptions.dart';


class MarketCheck2 extends StatefulWidget {
  const MarketCheck2(
      {Key? key,
      required this.surveyId,
      required this.userId,
      required this.userName,
      required this.apptitle})
      : super(key: key);
  final int surveyId;
  final String userId;
  final String userName;
  final String apptitle;

  @override
  _MarketCheck2State createState() => _MarketCheck2State();
}

class _MarketCheck2State extends State<MarketCheck2> {
  final formKey = GlobalKey<FormBuilderState>();

  var applicantJobStatus = [
    'Permanent',
    'Temporary',
    'Contractual',
    'Third Party',
    'Others'
  ];

  Object? isKnowApplicant;

  Future<GetMarketCheck2Data>? marketCheck2DetailsFromServer;
  @override
  void initState() {
    marketCheck2DetailsFromServer = GetMarketCheck2Details()
        .getMarketCheck2Details("/getMarketchecktwo/${widget.surveyId}");
    super.initState();
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
       title: Text(widget.apptitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: FutureBuilder<GetMarketCheck2Data>(
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
                                initialValue:
                                    snapshot.data!.data![0].mc_two_person_met,
                                name: 'mc_two_person_met',
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
                            FormBuilderTextField(
                              maxLines: 5,
                                initialValue:
                                    snapshot.data!.data![0].mc_two_addrees,
                                name: 'mc_two_addrees',
                                decoration: inputDecoration(
                                    "Address", ""), // onChanged: _onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter The Neighbour Address  "),
                                //   FormBuilderValidators.min(context, 70,
                                //       errorText: "Max Range is 70"),
                                // ]),
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderRadioGroup(
                              initialValue: snapshot
                                  .data!.data![0].mc_two_knows_applicant,
                              name: "mc_two_knows_applicant",
                              // validator: FormBuilderValidators.required(context,
                              //     errorText: "Please Select"),
                              onChanged: (value) {
                                setState(() {
                                  isKnowApplicant = value;
                                  snapshot.data!.data![0]
                                          .mc_two_knows_applicant =
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
                                        .mc_two_knows_applicant ==
                                    "Yes")
                              Column(
                                children: [
                                  SizedBox(height: 22),
                                  FormBuilderTextField(
                                      initialValue: snapshot.data!.data![0]
                                          .mc_two_knows_applicant_since,
                                      name: 'mc_two_knows_applicant_since',
                                      decoration: inputDecoration(
                                          "Know Applicant Since",
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
                                  FormBuilderRadioGroup(
                                    initialValue: snapshot.data!.data![0]
                                        .mc_two_neighbor_comments,
                                    name: "mc_two_neighbor_comments",
                                    // validator: FormBuilderValidators.required(context,
                                    //     errorText: "Please Select"),
                                    decoration: inputDecoration(
                                        "Neighbor Comments", "hintText"),
                                    activeColor: appColor,
                                    options: [
                                      FormBuilderFieldOption(value: "Positive"),
                                      FormBuilderFieldOption(value: "Negative"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  FormBuilderTextField(
                                      initialValue: snapshot.data!.data![0]
                                          .mc_two_business_established_since,
                                      name: 'mc_two_business_established_since',
                                      decoration: inputDecoration(
                                          "Business Established Since",
                                          "Years/Months"), // onChanged: _onChanged,
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
                                      initialValue: snapshot.data!.data![0]
                                          .mc_two_designation_of_met_person,
                                      name: 'mc_two_designation_of_met_person',
                                      decoration: inputDecoration(
                                          "Designation of a person met",
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
                                  FormBuilderDropdown(
                                    items: applicantJobStatus
                                        .map((value) => DropdownMenuItem(
                                              value: value,
                                              child: Text(value),
                                            ))
                                        .toList(),

                                    initialValue: snapshot.data!.data![0]
                                        .mc_two_applicant_emp_status,
                                    name: 'mc_two_applicant_emp_status',
                                    decoration: inputDecoration(
                                        "Applicant's Employment Status",
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
                                  FormBuilderTextField(
                                      initialValue: snapshot.data!.data![0]
                                          .mc_two_applicant_designation,
                                      name: 'mc_two_applicant_designation',
                                      decoration: inputDecoration(
                                          "Applicant's Designation",
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
                                      initialValue: snapshot.data!.data![0]
                                          .mc_two_applicant_nature_of_job,
                                      name: 'mc_two_applicant_nature_of_job',
                                      decoration: inputDecoration(
                                          "Applicant Job Nature",
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
                                      initialValue: snapshot.data!.data![0]
                                          .mc_two_applicant_salary,
                                      name: 'mc_two_applicant_salary',
                                      decoration: inputDecoration(
                                          "Applicant Salary",
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
                        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: appColor)),
          color: appColor.withOpacity(.5),
              onPressed: () async {                            buildShowDialog(context);

                              formKey.currentState!.save();
                              // if (formKey.currentState!.validate()) {
                              print(formKey.currentState!.value);
                              var data = formKey.currentState!.value;
                              var res = await SendMarketCheck2Details()
                                  .sendMarketCheck2Details(data,
                                      "/postMarketchecktwo/${widget.surveyId}");
                              var body = jsonDecode(res.body);
                              if (body["success"]) {
                                showToastApp();
                                Navigator.pop(context);
                              } else {
                                showToastAppFalse();
                              }
if (body["success"]) {
                                // showToastApp();
                                Navigator.pop(context);
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

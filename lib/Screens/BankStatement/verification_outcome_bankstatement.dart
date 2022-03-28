import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:radium_tech/Components/backToOptions.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/showLoderPauseScreen.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Model/ResidenceModel/get_neighbour_1_data.dart';
import 'package:radium_tech/Model/ResidenceModel/get_verification_outcome_data.dart';
import 'package:radium_tech/Screens/ResidenceForm/verification_outcome.dart';
import 'package:radium_tech/Services/ResidenceApi/GetData/get_neighbour_1_details.dart';
import 'package:radium_tech/Services/ResidenceApi/GetData/get_verification_outcome_details.dart';
import 'package:radium_tech/Services/ResidenceApi/SendData/send_neighbour_1_details.dart';
import 'package:radium_tech/Utils/colors.dart';

class VerificationOutcomeBankStatement extends StatefulWidget {
  const VerificationOutcomeBankStatement({Key? key, required this.suid})
      : super(key: key);
  final int suid;

  @override
  _VerificationOutcomeBankStatementState createState() =>
      _VerificationOutcomeBankStatementState();
}

class _VerificationOutcomeBankStatementState
    extends State<VerificationOutcomeBankStatement> {
  Future<GetVerificationOutcome>? getVerificcationDetails;

  @override
  void initState() {
    getVerificcationDetails = GetVerificationDetails()
        .getResidenceDetails("/getOutcome/${widget.suid}");
    super.initState();
  }

  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification Outcome"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: FutureBuilder<GetVerificationOutcome>(
              future: getVerificcationDetails,
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
                                initialValue: snapshot.data!.data![0].surveyor,
                                name: 'surveyor',
                                decoration: inputDecoration("Surveyor", ""),
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderRadioGroup(
                              initialValue:
                                  snapshot.data!.data![0].report_status,
                              name: "report_status",
                              decoration: inputDecoration("Report Status", ""),
                              activeColor: appColor,
                              options: [
                                FormBuilderFieldOption(value: "Verified"),
                                FormBuilderFieldOption(value: "Not Verified"),
                              ],
                            ),
                            SizedBox(height: 22),
                            FormBuilderTextField(
                                initialValue: snapshot.data!.data![0].remarks,
                                name: 'remarks',
                                decoration: inputDecoration("Remarks", ""),
                                keyboardType: TextInputType.text),
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
                            onPressed: () async {
                              buildShowDialog(context);
                              formKey.currentState!.save();
                              print(formKey.currentState!.value);
                              var data = formKey.currentState!.value;
                              var res = await SendNeighbour1Details()
                                  .sendNeighbour1Details(
                                      data, "/postOutcome/${widget.suid}");
                              var body = jsonDecode(res.body);
                              if (body["success"]) {
                                showToastApp();
                                Navigator.pop(context);
                                Navigator.pop(context);
                                
                              } else {
                                showToastAppFalse();
                              }
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

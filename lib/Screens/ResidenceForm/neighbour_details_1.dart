import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:radium_tech/Components/backToOptions.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/showLoderPauseScreen.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Model/ResidenceModel/get_neighbour_1_data.dart';
import 'package:radium_tech/Screens/ResidenceForm/verification_outcome.dart';
import 'package:radium_tech/Services/ResidenceApi/GetData/get_neighbour_1_details.dart';
import 'package:radium_tech/Services/ResidenceApi/SendData/send_neighbour_1_details.dart';
import 'package:radium_tech/Utils/colors.dart';

class NeighbourDetails1 extends StatefulWidget {
  const NeighbourDetails1(
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
  _NeighbourDetails1State createState() => _NeighbourDetails1State();
}

class _NeighbourDetails1State extends State<NeighbourDetails1> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  void dispose() {
    print("Disposing ResidenceHomePage route");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.apptitle),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BackToOptions(),
          MaterialButton(
            onPressed: () async {
              buildShowDialog(context);
              formKey.currentState!.save();
              print(formKey.currentState!.value);
              var data = formKey.currentState!.value;
              var res = await SendNeighbour1Details().sendNeighbour1Details(
                  data, "/postNeighboorone/${widget.surveyId}");
              var body = jsonDecode(res.body);
              if (body["success"]) {
                showToastApp();
                Navigator.pop(context);
                Navigator.pop(context);
                
              } else {
                showToastAppFalse();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: FutureBuilder<GetNeighbour1Data>(
              future: GetNeighbour1Details()
                  .getResidenceDetails("/getNeighboorone/${widget.surveyId}"),
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
                                initialValue: snapshot.data!.data![0].name,
                                name: 'name',
                                decoration: inputDecoration(
                                    "Neighbout Name", "Enter Neighbour Name"),
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                maxLines: 5,
                                initialValue: snapshot.data!.data![0].address,
                                name: 'address',
                                decoration: inputDecoration("Neighbour Address",
                                    "Enter Neighbour Address"),
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderRadioGroup(
                              initialValue:
                                  snapshot.data!.data![0].knows_applicant,
                              name: "knows_applicant",
                              decoration: inputDecoration(
                                  "Knows Applicant", "hintText"),
                              activeColor: appColor,
                              options: [
                                FormBuilderFieldOption(value: "Yes"),
                                FormBuilderFieldOption(value: "No"),
                                FormBuilderFieldOption(value: "Refused"),
                              ],
                            ),
                            SizedBox(height: 22),
                            FormBuilderTextField(
                                initialValue:
                                    snapshot.data!.data![0].knows_since,
                                name: 'knows_since',
                                decoration: inputDecoration(
                                    "Know Applicant Since", "Years"),
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderRadioGroup(
                              initialValue: snapshot.data!.data![0].comments,
                              name: "comments",
                              decoration: inputDecoration(
                                  "Neighbor Comments", "hintText"),
                              activeColor: appColor,
                              options: [
                                FormBuilderFieldOption(value: "Positive"),
                                FormBuilderFieldOption(value: "Negative"),
                              ],
                            ),
                          ],
                        ),
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

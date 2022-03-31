import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:radium_tech/Components/backToOptions.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/showLoderPauseScreen.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Model/ResidenceModel/get_neighbour_2_data.dart';
import 'package:radium_tech/Services/ResidenceApi/GetData/get_neighbour_2_details.dart';
import 'package:radium_tech/Services/ResidenceApi/SendData/send_neighbour_2_details.dart';
import 'package:radium_tech/Utils/colors.dart';

class NeighbourDetails2 extends StatefulWidget {
  const NeighbourDetails2(
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
  _NeighbourDetails2State createState() => _NeighbourDetails2State();
}

class _NeighbourDetails2State extends State<NeighbourDetails2> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.apptitle),
         leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
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
              var res = await SendNeighbour2Details().sendNeighbour2Details(
                  data, "/postNeighboortwo/${widget.surveyId}");
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
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: FutureBuilder<GetNeighbour2Data>(
                future: GetNeighbour2Details()
                    .getResidenceDetails("/getNeighboortwo/${widget.surveyId}"),
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
                                  decoration: inputDecoration(
                                      "Neighbour Address",
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
      ),
    );
  }
}

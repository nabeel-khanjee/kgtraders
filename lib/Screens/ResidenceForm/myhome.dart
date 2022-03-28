import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:radium_tech/Api/apiurl.dart';
import 'package:radium_tech/Components/bottom_navbar.dart';
import 'package:radium_tech/Components/form_button.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Global/global.dart';
import 'package:radium_tech/Screens/BankStatement/bank_applicant_details.dart';
import 'package:radium_tech/Screens/BankStatement/bank_verification_details.dart';
import 'package:radium_tech/Screens/BankStatement/verification_outcome_bankstatement.dart';
import 'package:radium_tech/Screens/ResidenceForm/image_picking.dart';
import 'package:radium_tech/Screens/ResidenceForm/neighbour_details_1.dart';
import 'package:radium_tech/Screens/ResidenceForm/neighbour_details_2.dart';
import 'package:radium_tech/Screens/ResidenceForm/user_applicant_details.dart';
import 'package:radium_tech/Screens/ResidenceForm/verification_outcome.dart';
import 'package:radium_tech/Screens/WorkPlaceFrom/market_check_1.dart';
import 'package:radium_tech/Screens/WorkPlaceFrom/narket_chech_2.dart';
import 'package:radium_tech/Screens/WorkPlaceFrom/office_hr_details.dart';
import 'package:radium_tech/Screens/WorkPlaceFrom/salary_details.dart';
import 'package:radium_tech/Screens/WorkPlaceFrom/verification_outcome_workplace.dart';
import 'package:radium_tech/Screens/WorkPlaceFrom/work_place_applicant_details.dart';
import 'package:radium_tech/Screens/WorkPlaceFrom/work_place_business_prifile.dart';
import 'package:radium_tech/Services/SubmitApi/submit_api.dart';
import 'package:radium_tech/Utils/colors.dart';
import 'package:radium_tech/location/get_location.dart';
import 'residence_profile.dart';

class MyHomePageResidence extends StatefulWidget {
  const MyHomePageResidence(
      {Key? key,
      required this.surveyId,
      required this.userName,
      required this.userId,
      required this.formFormate,
      required this.isSalarySlip,
      required this.isHrDetails})
      : super(key: key);
  final int surveyId;
  final String userName;
  final String userId;
  final String formFormate;
  final int isSalarySlip;
  final int isHrDetails;

  @override
  State<MyHomePageResidence> createState() => _MyHomePageResidenceState();
}

class _MyHomePageResidenceState extends State<MyHomePageResidence> {
  bool _loading = false;

  Map<String, double>? locationData;

  @override
  void initState() {
    super.initState();
    GetLocationState().getLocation();
    print(widget.isSalarySlip);
    print(widget.isHrDetails);
  }

  var clickstatus = true;

  void waittogetsurveyordata() async {
    await Future.delayed(const Duration(seconds: 1), () {
      if (success == 'true') {
        clickstatus = true;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            if (widget.formFormate == "1") {
              return VerificationOutcomesWorkPlace(surid: widget.surveyId);
            } else if (widget.formFormate == "2") {
              return VerificationOutcomes(surid: widget.surveyId);
            } else {
              return VerificationOutcomeBankStatement(
                suid: widget.surveyId,
              );
            }
          }),
        );
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
        waittogetsurveyordata();
      }
    });
  }

  String thirdButtonName() {
    if (widget.formFormate == "1") {
      return "Workplace Profile";
    } else if (widget.formFormate == "2") {
      return "Residence Profile";
    } else {
      return widget.formFormate == "4"
          ? "ATL Verification Details"
          : "Bank Verification Details";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey'),
      ),
      bottomNavigationBar: ButtomNavBar(
          widget: widget,
          onTapSave: () async {
            var res = await SubmitApi()
                .submilData("/submitSurvey/${widget.surveyId}");
            var body = jsonDecode(res.body);
            if (body["success"]) {
              showToastApp();
              Navigator.pop(
                context,
              );
            } else {
              showToastAppFalse();
            }
          },
          onTapBack: () {
            Navigator.pop(
              context,
            );
          }),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80.0),
            child: Column(
              children: <Widget>[
                FormButton(
                    widget: widget,
                    buttonTitle: "Applicant's Details",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            if (widget.formFormate == "1") {
                              return MarketPlaceApplicantDetails(
                                applicationTitle: "Applicant's Details",
                                formFormate: widget.formFormate,
                                surveyId: widget.surveyId,
                                userId: widget.userId,
                                userName: widget.userName,
                              );
                            } else if (widget.formFormate == "2") {
                              return UserApplicantDetail(
                                formFormate: widget.formFormate,
                                applicationTitle: "Applicant's Details",
                                surveyId: widget.surveyId,
                                userId: widget.userId,
                                userName: widget.userName,
                              );
                            } else {
                              return BankApplicantDetails(
                                surveyId: widget.surveyId,
                                applicationTitle: "Applicant's Details",
                              );
                            }
                          },
                        ),
                      );
                    },
                    iconData: Icons.perm_identity_sharp),
                const SizedBox(height: 20),
                FormButton(
                  widget: widget,
                  buttonTitle: thirdButtonName(),
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      if (widget.formFormate == "1") {
                        return BusinessProfile(
                          applicationTitle: "Workplace Profile",
                          surveyId: widget.surveyId,
                          userId: widget.userId,
                          userName: widget.userName,
                        );
                      } else if (widget.formFormate == "2") {
                        return ResidenceProfile(
                          applicationTitle: "Residence Profile",
                          surveyId: widget.surveyId,
                          userId: widget.userId,
                          userName: widget.userName,
                        );
                      } else {
                        return BankVerificationDetails(
                          formFormate: widget.formFormate,
                          applicationTitle: widget.formFormate == "4"
                              ? "ATL Details"
                              : "Bank Details",
                          surveyId: widget.surveyId,
                        );
                      }
                    }));
                  },
                  iconData: Icons.verified,
                ),
             if (widget.formFormate == "1" || widget.formFormate == "2")
                   const SizedBox(height: 20),
                if (widget.formFormate == "1" || widget.formFormate == "2")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FormButton(
                        widget: widget,
                        buttonTitle: widget.formFormate == "1"
                            ? "Market Check 1"
                            : "Neighbour 1",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => widget.formFormate == "1"
                                  ? MarketCheck1(
                                      apptitle: "Market Check 1",
                                      surveyId: widget.surveyId,
                                      userId: widget.userId,
                                      userName: widget.userName,
                                    )
                                  : NeighbourDetails1(
                                      apptitle: "Neighbour 1",
                                      surveyId: widget.surveyId,
                                      userId: widget.userId,
                                      userName: widget.userName,
                                    ),
                            ),
                          );
                        },
                        iconData: Icons.perm_identity_sharp,
                      ),
                      FormButton(
                        widget: widget,
                        buttonTitle: widget.formFormate == "1"
                            ? "Market Check 2"
                            : "Neighbour 2",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => widget.formFormate == "1"
                                  ? MarketCheck2(
                                      apptitle: "Market Check 2",
                                      surveyId: widget.surveyId,
                                      userId: widget.userId,
                                      userName: widget.userName,
                                    )
                                  : NeighbourDetails2(
                                      apptitle: "Neighbour 2",
                                      surveyId: widget.surveyId,
                                      userId: widget.userId,
                                      userName: widget.userName,
                                    ),
                            ),
                          );
                        },
                        iconData: Icons.perm_identity_sharp,
                      )
                    ],
                  ),
              if (widget.formFormate == "1" )
               if(widget.isSalarySlip==1||widget.isHrDetails==1)   const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.isSalarySlip == 1)
                      FormButton(
                          widget: widget,
                          buttonTitle: "Salary Slip Details",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SalaryDetails(
                                          surveyId: widget.surveyId,
                                        ))));
                          },
                          iconData: Icons.receipt),
                    if (widget.isHrDetails == 1)
                      FormButton(
                          widget: widget,
                          buttonTitle: "Office HR Details",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (contect) => OfficeHrDetails(
                                    apptitle: "Office HR Details",
                                    surveyId: widget.surveyId,
                                  ),
                                ));
                          },
                          iconData: Icons.place)
                  ],
                ),
                const SizedBox(height: 20),
                FormButton(
                  widget: widget,
                  buttonTitle: "Take Photograph",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          if (widget.formFormate == "3" ||
                              widget.formFormate == "4") {
                            return PhotoGraphs(
                              formFormate: '0',
                              surid: widget.surveyId);
                          } else {
                            return PhotoGraphs(
                              formFormate: '1',
                              surid: widget.surveyId,);
                          }
                        },
                      ),
                    );
                  },
                  iconData: Icons.camera_alt,
                ),
                const SizedBox(height: 20),
                FormButton(
                  widget: widget,
                  buttonTitle: "Verification Outcome",
                  onTap: () {
                    Api.GetSorveyorResult(widget.surveyId);
                    waittogetsurveyordata();
                  },
                  iconData: Icons.contact_page,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

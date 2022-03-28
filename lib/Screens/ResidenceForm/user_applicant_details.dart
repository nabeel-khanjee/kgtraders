import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:radium_tech/Components/showLoderPauseScreen.dart';
import 'package:radium_tech/Components/upper_case.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Model/ResidenceModel/get_applicant_data.dart';
import 'package:radium_tech/Screens/ResidenceForm/verification_outcome.dart';
import 'package:radium_tech/Services/ResidenceApi/GetData/get_applicant_details.dart';
import 'package:radium_tech/Services/ResidenceApi/SendData/send_applicant_details.dart';
import 'package:radium_tech/Utils/colors.dart';
import 'package:radium_tech/Components/backToOptions.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserApplicantDetail extends StatefulWidget {
  final int surveyId;
  final String userId;
  final String userName;
  final String applicationTitle;
  final String formFormate;

  const UserApplicantDetail({
    Key? key,
    required this.surveyId,
    required this.userId,
    required this.userName,
    required this.applicationTitle,
    required this.formFormate,
  }) : super(key: key);

  @override
  _UserApplicantDetailState createState() => _UserApplicantDetailState();
}

class _UserApplicantDetailState extends State<UserApplicantDetail> {
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

  Future<GetApplicantData>? getApplicantDataFromServer;

  bool confirmLocation = false;

  Map<String, String>? locationData;

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
    getApplicantDataFromServer = GetApplicantDetails()
        .getResidenceDetails("/getapplicantdetails/${widget.surveyId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.applicationTitle),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: FutureBuilder<GetApplicantData>(
            future: getApplicantDataFromServer,
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
                                  name = value;
                                },
                                initialValue:
                                    snapshot.data!.data![0].applicant_name,
                                autocorrect: true,
                                name: 'name',
                                decoration: inputDecoration(
                                    "Applicant Name", "Enter Applicant Name"),
                                keyboardType: TextInputType.name),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                onChanged: (value) {
                                  father = value;
                                },
                                initialValue:
                                    snapshot.data!.data![0].applicant_father,
                                name: 'father',
                                decoration: inputDecoration(
                                    "Father Name", "Enter Father Name"),
                                keyboardType: TextInputType.name),
                            SizedBox(
                              height: 22,
                            ),
                            TextFormField(
                                initialValue:
                                    snapshot.data!.data![0].applicant_cnic,
                                onChanged: (val) {
                                  cnic = val;
                                },
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                  MaskTextInputFormatter(
                                      mask: "#####-#######-#"),
                                ],
                                autocorrect: false,
                                keyboardType: TextInputType.phone,
                                autovalidateMode: AutovalidateMode.always,
                                validator: null,
                                decoration: inputDecoration(
                                    "CNIC of Applicant", "00000-0000000-0")),
                            SizedBox(
                              height: 22,
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: appColor)),
                              color: appColor.withOpacity(.5),
                              onPressed: () async {
                                _selectDate(context);
                                setState(() {
                                  _dob =
                                      "$selectedDate.toLocal()}".split(' ')[0];
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Date of birth",
                                    style: TextStyle(color: textColor),
                                  ),
                                  Text(
                                    _dob != null
                                        ? "$_dob".split(' ')[0]
                                        : snapshot.data!.data![0].dob != null
                                            ? snapshot.data!.data![0].dob!
                                            : "Pick your date of birth",
                                    style: TextStyle(color: textColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            TextFormField(
                                initialValue: snapshot.data!.data![0].res_phone,
                                onChanged: (val) {
                                  res_phone = val;
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
                                    "Residence Phone", "+92-000-0000000")),
                            SizedBox(
                              height: 22,
                            ),
                            TextFormField(
                                initialValue:
                                    snapshot.data!.data![0].work_phone,
                                onChanged: (val) {
                                  work_phone = val;
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
                                    "Workplace Phone", "+92-000-0000000")),
                            SizedBox(
                              height: 22,
                            ),
                            TextFormField(
                                initialValue:
                                    snapshot.data!.data![0].cell_phone,
                                onChanged: (val) {
                                  cell = snapshot.data!.data![0].cell_phone!;
                                  cell = val;
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
                                    "Cell Number", "+92-000-0000000")),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                maxLines: 5,
                                onChanged: (value) {
                                  address = value;
                                },
                                initialValue:
                                    snapshot.data!.data![0].residence_address,
                                name: 'address',
                                decoration: inputDecoration("Residence Address",
                                    "A/House Number-Area,City."),
                                keyboardType: TextInputType.text),
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
                                initialValue: snapshot.data!.data![0].landmark,
                                name: 'landmark',
                                decoration: inputDecoration(
                                    "Landmark", "Enter Landmark"),
                                keyboardType: TextInputType.text),
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
                              "name": name ??
                                  snapshot.data!.data![0].applicant_name,
                              "father": father ??
                                  snapshot.data!.data![0].applicant_father,
                              "cnic": cnic ??
                                  snapshot.data!.data![0].applicant_cnic,
                              "dob": "$selectedDate.toLocal()}".split(" ")[0],
                              "res_phone": res_phone ??
                                  snapshot.data!.data![0].res_phone,
                              "work_phone": work_phone ??
                                  snapshot.data!.data![0].work_phone,
                              "cell":
                                  cell ?? snapshot.data!.data![0].cell_phone,
                              "address": address ??
                                  snapshot.data!.data![0].residence_address,
                              "landmark":
                                  landmark ?? snapshot.data!.data![0].landmark,
                            };
                            print(dataget);

                            var res = await SendApplicantDetails()
                                .sendApplicantDetails(dataget,
                                    "/updateapplicantdetails/${widget.surveyId}");
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

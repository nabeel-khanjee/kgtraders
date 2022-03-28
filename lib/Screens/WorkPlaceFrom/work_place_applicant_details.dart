import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:radium_tech/Components/input_decoration_text.dart';
import 'package:radium_tech/Components/showLoderPauseScreen.dart';
import 'package:radium_tech/Components/show_toast.dart';
import 'package:radium_tech/Components/upper_case.dart';
import 'package:radium_tech/Model/ResidenceModel/get_applicant_data.dart';
import 'package:radium_tech/Services/ResidenceApi/GetData/get_applicant_details.dart';
import 'package:radium_tech/Services/ResidenceApi/SendData/send_applicant_details.dart';
import 'package:radium_tech/Utils/colors.dart';

class MarketPlaceApplicantDetails extends StatefulWidget {
  final int surveyId;
  final String userId;
  final String userName;
  final String applicationTitle;
  final String formFormate;

  const MarketPlaceApplicantDetails({
    Key? key,
    required this.surveyId,
    required this.userId,
    required this.userName,
    required this.applicationTitle,
    required this.formFormate,
  }) : super(key: key);

  @override
  _MarketPlaceApplicantDetailsState createState() =>
      _MarketPlaceApplicantDetailsState();
}

class _MarketPlaceApplicantDetailsState
    extends State<MarketPlaceApplicantDetails> {
  final formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic>? dataValue;
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

  String? cnic;

  String? father;

  String? name;

  Map<String, dynamic>? dataget;

  String? designation;

  String? business_name;

  Future<GetApplicantData>? getApplicantdetailsFromServer;

  Map<String, String>? locationData;

  bool confirmLocation = false;
  @override
  void initState() {
    // TODO: implement initState
    getApplicantdetailsFromServer = GetApplicantDetails()
        .getResidenceDetails("/getapplicantdetails/${widget.surveyId}");
    super.initState();
    _getCurrentLocation();
  }

  DateTime selectedDate = DateTime.now();
  var _dob;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.applicationTitle),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: FutureBuilder<GetApplicantData>(
            future: getApplicantdetailsFromServer,
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
                                    snapshot.data!.data![0].applicant_name ??
                                        "",
                                autocorrect: true,
                                name: 'name',
                                decoration: inputDecoration(
                                    "Applicant Name", "Enter Applicant Name"),
                                // onChanged: _onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter The Applicant Name"),
                                //   FormBuilderValidators.min(context, 70,
                                //       errorText: "Max Range is 70"),
                                // ]),
                                keyboardType: TextInputType.name),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                onChanged: (value) {
                                  father = value;
                                },
                                initialValue:
                                    snapshot.data!.data![0].applicant_father ??
                                        "",
                                name: 'father',
                                decoration: inputDecoration("Father Name",
                                    "Enter Father Name"), // onChanged: _onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter The Applicant Father Name"),
                                //   FormBuilderValidators.min(context, 70,
                                //       errorText: "Max Range is 70"),
                                // ]),
                                keyboardType: TextInputType.name),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                onChanged: (value) {
                                  cnic = value;
                                },
                                initialValue:
                                    snapshot.data!.data![0].applicant_cnic ??
                                        "",
                                name: 'cnic',
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                  MaskTextInputFormatter(
                                      mask: "#####-#######-#"),
                                ],
                                decoration: inputDecoration("Applicant CNIC",
                                    "Enter Applicant CNIC"), // onChanged: _onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter The Applicant CNIC"),
                                //   FormBuilderValidators.numeric(context,
                                //       errorText: "Please Select The Number"),
                                //   FormBuilderValidators.minLength(context, 13,
                                //       errorText: "Max Range is 13"),
                                // ]),
                                keyboardType: TextInputType.phone),
                            SizedBox(
                              height: 22,
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: appColor)),
                              color: appColor.withOpacity(.5),
                              onPressed: () async {
                                setState(() {
                                  _dob =
                                      "$selectedDate.toLocal()}".split(' ')[0];
                                });

                                _selectDate(context);
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
                            FormBuilderTextField(
                                initialValue: snapshot.data!.data![0]
                                        .applicant_business_name ??
                                    "",
                                // inputType: InputType.date,
                                onChanged: (value) {
                                  business_name = value;
                                },
                                cursorColor: appColor,

                                // initialValue: snapshot.data!.data![0].dob,
                                name: 'business_name',
                                decoration: inputDecoration("Business Name",
                                    ""), // onChanged: _onChanged,

                                // valueTransformer: (value) {
                                //   value = value;
                                // },
                                // valueTransformer: (text) =>
                                //     num.tryParse(text as String),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter Applicant Date of Birth"),
                                //   FormBuilderValidators.dateString(context,
                                //       errorText: "Enter the valid date"),
                                //   FormBuilderValidators.max(context, 20,
                                //       errorText: "Max Range is 20"),
                                // ]),
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                initialValue: snapshot
                                        .data!.data![0].applicant_designation ??
                                    "",
                                // inputType: InputType.date,
                                onChanged: (value) {
                                  designation = value;
                                },
                                cursorColor: appColor,

                                // initialValue: snapshot.data!.data![0].dob,
                                name: 'designation',
                                decoration: inputDecoration("Designation",
                                    "R S M"), // onChanged: _onChanged,

                                // valueTransformer: (value) {
                                //   value = value;
                                // },
                                // valueTransformer: (text) =>
                                //     num.tryParse(text as String),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter Applicant Date of Birth"),
                                //   FormBuilderValidators.dateString(context,
                                //       errorText: "Enter the valid date"),
                                //   FormBuilderValidators.max(context, 20,
                                //       errorText: "Max Range is 20"),
                                // ]),
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                initialValue:
                                    snapshot.data!.data![0].res_phone ?? "",
                                name: 'res_phone',
                                onChanged: (value) {
                                  res_phone = value;
                                },
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                  MaskTextInputFormatter(
                                      mask: "+92-###-#######"),
                                ],
                                decoration: inputDecoration(
                                    "Residential Number",
                                    ""), // onChanged: _onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter Applicant Residential Phone Number"),
                                //   FormBuilderValidators.numeric(context,
                                //       errorText: "Please Select The Number"),
                                //   FormBuilderValidators.minLength(context, 11,
                                //       errorText: "Max Range is 11"),
                                // ]),
                                keyboardType: TextInputType.phone),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                onChanged: (value) {
                                  work_phone = value;
                                },
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                  MaskTextInputFormatter(
                                      mask: "+92-###-#######"),
                                ],
                                initialValue:
                                    snapshot.data!.data![0].work_phone ?? "",
                                name: 'work_phone',
                                decoration: inputDecoration("Work Place Number",
                                    ""), // onChanged: _onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter The Applicant Work Place Phone Number"),
                                //   FormBuilderValidators.numeric(context,
                                //       errorText: "Please Select The Number"),
                                //   FormBuilderValidators.minLength(context, 11,
                                //       errorText: "Max Range is 11"),
                                // ]),
                                keyboardType: TextInputType.phone),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                onChanged: (value) {
                                  cell = value;
                                },
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                  MaskTextInputFormatter(
                                      mask: "+92-###-#######"),
                                ],
                                initialValue:
                                    snapshot.data!.data![0].cell_phone ?? "",
                                name: 'cell',
                                decoration: inputDecoration(
                                    "Cell Number", "") // onChanged: _onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                ,
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter The Applicant Cell Number"),
                                //   FormBuilderValidators.numeric(context,
                                //       errorText: "Please Select The Number"),
                                //   FormBuilderValidators.minLength(context, 11,
                                //       errorText: "Max Range is 11"),
                                // ]),
                                keyboardType: TextInputType.phone),
                            SizedBox(
                              height: 22,
                            ),
                            FormBuilderTextField(
                                maxLines: 5,
                                onChanged: (value) {
                                  address = value;
                                },
                                initialValue:
                                    snapshot.data!.data![0].residence_address ??
                                        "",
                                name: 'address',
                                decoration: inputDecoration("Residence Address",
                                    "A/House Number-Area,City."), // onChanged: _onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter The Applicant Address"),
                                //   FormBuilderValidators.min(context, 70,
                                //       errorText: "Max Range is 70"),
                                // ]),
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
                                      // Navigator.pop(context);
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
                                    snapshot.data!.data![0].landmark ?? "",
                                name: 'landmark',
                                decoration: inputDecoration(
                                    "Landmark", "Enter Landmark"),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(context,
                                //       errorText:
                                //           "Please Enter The Applicant Landmark"),
                                //   FormBuilderValidators.min(context, 70,
                                //       errorText: "Max Range is 70"),
                                // ]),
                                keyboardType: TextInputType.text),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: appColor)),
                          color: appColor.withOpacity(.5),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.navigate_before,
                                color: textColor,
                              ),
                              Text(
                                'Back To Options',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () async {
                                  buildShowDialog(context);

                            formKey.currentState!.save();
                            // if (formKey.currentState!.validate()) {
                            print(datepicker.text);
                            // print(formKey.currentState!.value.toString());
                            dataValue = formKey.currentState!.value;
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
                              // "longitude":
                              //     currentPosition!.longitude.toString(),
                              // "latitiude": currentPosition!.latitude.toString(),
                              "designation": designation ??
                                  snapshot.data!.data![0].applicant_designation,
                              "business_name": business_name ??
                                  snapshot
                                      .data!.data![0].applicant_business_name
                            };

                            // dataValue!.addEntries(longitude.entries);
                            // dataValue!.addEntries(latitiude.entries);

                            var res = await SendApplicantDetails()
                                .sendApplicantDetails(dataget,
                                    "/updateapplicantdetails/${widget.surveyId}");
                            var body = jsonDecode(res.body);
                            if (body["success"]) {
                              showToastApp();
                              Navigator.pop(context);
                            }

                                     if (body['success']) {
                                  // showToastApp();
                                  Navigator.pop(context);
                                }
                                 // } else {
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

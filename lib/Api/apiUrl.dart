import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:radium_tech/Api/Apis.dart';
import 'package:radium_tech/Global/global.dart';
import 'package:radium_tech/Model/ResidenceModel/get_image_data.dart';
import 'package:radium_tech/Model/task_listing_model.dart';

import 'apiurl.dart';

class Api {
  static loginAPI(var email, var pass) {
    success = "false";
    Dio dio = new Dio();

    String url = baseurl + 'signin';
    FormData formData = FormData.fromMap({
      'email': email.toString(),
      'password': pass.toString(),
    });
    final Map<String, dynamic> header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    dio
        .post(
      url,
      data: formData,
      options: Options(headers: header),
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var status = data['success'];

      if (response.statusCode == 200) {
        if (status == true) {
          token = data["token"];
          username = data["username"];
          userid = data["userid"];
          success = "true";
        } else {
          success = "error";
          print('error');
        }
      } else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }

  static Future<Welcome> data() async {
    var now = null;

    try {
      final http.Response response =
          await http.get(Uri.parse(baseurl + 'getSurveys/$userid'));

      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        return Welcome.fromJson(jsonDecode(response.body));
      } else {
        return now;
      }
    } catch (e) {
      throw Exception("Unknown Error");
    }
  }

  static Addimage(var photo, id, String path) async {
    success = "false";
    Dio dio = Dio();
    String url = baseurl + path + '/$id';
    FormData formData = FormData.fromMap({
      "image": photo != null
          ? await MultipartFile.fromFile(photo.path,
              filename: photo.path.split('/').last)
          : photo,
    });
    dio
        .post(
      url,
      data: formData,
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var message = data['success'];

      if (response.statusCode == 200) {
        if (message == true) {
          imagepath1 = data['imagepath'];
          success = "true";
          print('done');
          print(response.statusCode);
          print(response.data);
        } else {
          success = "error";
          print('error');
        }
      } else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }

  static onError(dynamic error) {
    success = "error";
  }

  static Future<ImageResponse> GetImagedata(id) async {
    var now = null;

    try {
      final http.Response response =
          await http.get(Uri.parse(baseurl + "getVerificationImages/$id"));

      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        return ImageResponse.fromJson(jsonDecode(response.body));
      } else {
        return now;
      }
    } catch (e) {
      throw Exception("Unknown Error");
    }
  }

  static GetApplicantData(id) {
    success = "false";
    Dio dio = Dio();
    String url = baseurl + "getapplicantdetails/$id";
    dio
        .get(
      url,
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var message = data['status'];

      if (response.statusCode == 200) {
        ApplicantDetail_list.clear();

        print(response.statusCode);
        print(response.data);
        if (message == true) {
          var price = data["data"];

          for (Map i in price) {
            ApplicantDetail_list.add(ApplicantDetail(
              applicantName: i['applicant_name'],
              applicantFather: i['applicant_father'],
              dob: i['dob'],
              applicantCnic: i['applicant_cnic'],
              resPhone: i['res_phone'],
              workPhone: i['work_phone'],
              cellPhone: i['cell_phone'],
              residenceAddress: i['residence_address'],
              landmark: i['landmark'],
            ));
          }

          success = "true";
          print('done');
        } else {
          success = "error";
          print('error');
        }
      } else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }

  static SendApplicantData(id, var name, var fname, var cnic, var dob, var resphone, var workphone, var cell, var address, var landmark, var longitude, var latitude) {
    success = "false";
    Dio dio = new Dio();

    String url = baseurl + 'updateapplicantdetails/$id';
    FormData formData = FormData.fromMap({
      'name': name.toString(),
      'father': fname.toString(),
      'cnic': cnic.toString(),
      'dob': dob.toString(),
      'res_phone': resphone.toString(),
      'work_phone': workphone.toString(),
      'cell': cell.toString(),
      'address': address.toString(),
      'landmark': landmark.toString(),
      'longitude': longitude.toString(),
      'latitiude ': latitude.toString(),
    });

    dio
        .post(
      url,
      data: formData,
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var status = data['success'];

      if (response.statusCode == 200) {
        if (status == true) {
          success = "true";
          print('done');
        } else {
          success = "error";
          print('error');
        }
      } else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }

  static SendResidentData(id, var available, var correct, var livehere, var livingsince, var nameplate, var residencetype, var residenceis, var utilization, var residencearea, var areaunit, var areadetail, var residencecondition, var areacondition, var neighborhood, var areaaccessibility, var belongsto, var repossession) {
    success = "false";
    Dio dio = new Dio();

    String url = baseurl + 'updateResidenceProfile/$id';
    FormData formData = FormData.fromMap({
      'applicant_is_avaliable': available.toString(),
      'is_address_correct': correct.toString(),
      'does_applicant_live_here': livehere.toString(),
      'living_since': livingsince.toString(),
      'is_name_plate': nameplate.toString(),
      'residence_type': residencetype.toString(),
      'residence_is': residenceis.toString(),
      'residence_utilization': utilization.toString(),
      'residence_area': residencearea.toString(),
      'residence_area_unit': areaunit.toString(),
      'residence_area_details': areadetail.toString(),
      'residence_condition': residencecondition.toString(),
      'area_condition': areacondition.toString(),
      'neighbourhood': neighborhood.toString(),
      'area_accessbility': areaaccessibility.toString(),
      'residents_belong_to': belongsto.toString(),
      'repossession': repossession.toString(),
    });

    dio
        .post(
      url,
      data: formData,
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var status = data['success'];

      if (response.statusCode == 200) {
        if (status == true) {
          success = "true";
          print('done');
        } else {
          success = "error";
          print('error');
        }
      } else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }

  static GetResidenceData(id) {
    success = "false";
    Dio dio = Dio();
    String url = baseurl + "getResidenceProfile/$id";
    dio
        .get(
      url,
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var message = data['status'];

      if (response.statusCode == 200) {
        ResidenceDetail_list.clear();

        print(response.statusCode);
        print(response.data);
        if (message == true) {
          var price = data["data"];

          for (Map i in price) {
            ResidenceDetail_list.add(ResidenceDetail(
              applicantIsAvaliable: i['applicant_is_avaliable'],
              isAddressCorrect: i['is_address_correct'],
              doesApplicantLiveHere: i['does_applicant_live_here'],
              livingSince: i['living_since'],
              isNamePlate: i['is_name_plate'],
              residenceType: i['residence_type'],
              residenceIs: i['residence_is'],
              residenceUtilization: i['residence_utilization'],
              residenceArea: i['residence_area'],
              residenceAreaUnit: i['residence_area_unit'],
              residenceAreaDetails: i['residence_area_details'],
              residenceCondition: i['residence_condition'],
              areaCondition: i['area_condition'],
              neighbourhood: i['neighbourhood'],
              areaAccessbility: i['area_accessbility'],
              residentsBelongTo: i['residents_belong_to'],
              repossession: i['repossession'],
            ));
          }

          success = "true";
          print('done');
        } else {
          success = "error";
          print('error');
        }
      } else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }

  static GetNeighborone(id) {
    success = "false";
    Dio dio = Dio();
    String url = baseurl + "getNeighboorone/$id";
    dio
        .get(
      url,
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var message = data['status'];

      if (response.statusCode == 200) {
        Neighborone_list.clear();

        print(response.statusCode);
        print(response.data);
        if (message == true) {
          var price = data["data"];

          for (Map i in price) {
            Neighborone_list.add(NeighborOneDetail(
              name: i['name'],
              address: i['address'],
              knowsApplicant: i['knows_applicant'],
              knowsSince: i['knows_since'],
              comments: i['comments'],

            ));
          }

          success = "true";
          print('done');
        } else {
          success = "error";
          print('error');
        }
     }
      else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }

  static SendNeighboroneData(id, var name, var address, var knowsApplicant, var since, var comments, ) {
    success = "false";
    Dio dio = new Dio();

    String url = baseurl + 'postNeighboorone/$id';
    FormData formData = FormData.fromMap({
      'name': name.toString(),
      'address': address.toString(),
      'knows_applicant': knowsApplicant.toString(),
      'knows_since': since.toString(),
      'comments': comments.toString(),

    });

    dio
        .post(
      url,
      data: formData,
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var status = data['success'];

      if (response.statusCode == 200) {
        if (status == true) {
          success = "true";
          print('done');
        } else {
          success = "error";
          print('error');
        }
      } else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }


  static GetNeighbortwo(id) {
    success = "false";
    Dio dio = Dio();
    String url = baseurl + "getNeighboortwo/$id";
    dio
        .get(
      url,
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var message = data['status'];

      if (response.statusCode == 200) {
        Neighbortwo_list.clear();

        print(response.statusCode);
        print(response.data);
        if (message == true) {
          var price = data["data"];

          for (Map i in price) {
            Neighbortwo_list.add(NeighborTwoDetail(
              name: i['name'],
              address: i['address'],
              knowsApplicant: i['knows_applicant'],
              knowsSince: i['knows_since'],
              comments: i['comments'],

            ));
          }

          success = "true";
          print('done');
        } else {
          success = "error";
          print('error');
        }
      } else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }

  static SendNeighbortwoData(id, var name, var address, var knowsApplicant, var since, var comments, ) {
    success = "false";
    Dio dio = new Dio();

    String url = baseurl + 'postNeighboortwo/$id';
    FormData formData = FormData.fromMap({
      'name': name.toString(),
      'address': address.toString(),
      'knows_applicant': knowsApplicant.toString(),
      'knows_since': since.toString(),
      'comments': comments.toString(),

    });

    dio
        .post(
      url,
      data: formData,
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var status = data['success'];

      if (response.statusCode == 200) {
        if (status == true) {
          success = "true";
          print('done');
        } else {
          success = "error";
          print('error');
        }
      } else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }


  static GetSorveyorResult(id) {
    success = "false";
    Dio dio = Dio();
    String url = baseurl + "getOutcome/$id";
    dio
        .get(
      url,
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var message = data['status'];

      if (response.statusCode == 200) {
        Surveyor_list.clear();

        print(response.statusCode);
        print(response.data);
        if (message == true) {
          var price = data["data"];

          for (Map i in price) {
            Surveyor_list.add(SurveyorDetail(
              surveyor: i['surveyor'],
              reportStatus: i['report_status'],
              comments: i['comments'],
              remarks: i['remarks'],


            ));
          }

          success = "true";
          print('done');
        } else {
          success = "error";
          print('error');
        }
      } else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }

  static SendSorveyorResult(id, var name, var reportstatus, var comments, var remarks, ) {
    success = "false";
    Dio dio = new Dio();

    String url = baseurl + 'postOutcome/$id';
    FormData formData = FormData.fromMap({
      'surveyor': name.toString(),
      'report_status': reportstatus.toString(),
      'comments': comments.toString(),
      'remarks': remarks.toString(),


    });

    dio
        .post(
      url,
      data: formData,
    )
        .then((response) {
      Map<String, dynamic> data = response.data;
      var status = data['success'];

      if (response.statusCode == 200) {
        if (status == true) {
          success = "true";
          print('done');
        } else {
          success = "error";
          print('error');
        }
      } else {
        success = "error";
        throw Exception('Failed to Fetch data');
      }
    }).catchError(onError);
  }

}

import 'dart:convert';

GetApplicantData welcomeFromJson(String str) =>
    GetApplicantData.fromJson(json.decode(str));

String welcomeToJson(GetApplicantData data) => json.encode(data.toJson());

class GetApplicantData {
  GetApplicantData({
    this.status,
    this.error,
    this.data,
  });

  bool? status;
  String? error;
  List<Data>? data;

  factory GetApplicantData.fromJson(Map<String, dynamic> json) =>
      GetApplicantData(
        status: json["status"],
        error: json["error"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  Data(
      {this.applicant_name,
      this.applicant_father,
      this.applicant_cnic,
      this.applicant_business_name,
      this.res_phone,
      this.work_phone,
      this.cell_phone,
      this.residence_address,
      this.landmark,
      this.dob,
      this.applicant_designation,
      this.latitiude,
      this.longitude});

  String? applicant_name;
  String? applicant_father;
  String? applicant_cnic;
  String? applicant_business_name;
  String? res_phone;
  String? work_phone;
  String? cell_phone;
  String? residence_address;
  String? landmark;
  String? dob;
  String? applicant_designation;
  String? longitude;
  String? latitiude;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        applicant_business_name: json["applicant_business_name"],
        applicant_name: json["applicant_name"],
        applicant_father: json['applicant_father'],
        applicant_cnic: json['applicant_cnic'],
        res_phone: json['res_phone'],
        work_phone: json['work_phone'],
        cell_phone: json['cell_phone'],
        residence_address: json['residence_address'],
        landmark: json['landmark'],
        dob: json['dob'],
        applicant_designation: json["applicant_designation"],
        latitiude: json['latitiude'],
        longitude:json['longitude']
      );

  Map<String, dynamic> toJson() => {
        "applicant_business_name": applicant_business_name,
        "applicant_name": applicant_name,
        "applicant_father": applicant_father,
        'applicant_cnic': applicant_cnic,
        'res_phone': res_phone,
        'work_phone': work_phone,
        'cell_phone': cell_phone,
        'residence_address': residence_address,
        'landmark': landmark,
        'dob': dob,
        "applicant_designation": applicant_designation,
        'latitiude':latitiude,
        'longitude':longitude
      };
}

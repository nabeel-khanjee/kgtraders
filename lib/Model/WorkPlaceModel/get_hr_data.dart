import 'dart:convert';


GetHrData welcomeFromJson(String str) => GetHrData.fromJson(json.decode(str));

String welcomeToJson(GetHrData data) => json.encode(data.toJson());

class GetHrData {
  GetHrData({
    this.status,
    this.error,
    this.data,
  });

  bool? status;
  String? error;
  List<Data>? data;

  factory GetHrData.fromJson(Map<String, dynamic> json) => GetHrData(
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
  Data({
    this.wp_ohr_name_of_person_met,
    this.wp_ohr_knows_applicant,
    this.wp_ohr_employment_status,
    this.wp_ohr_date_of_joining,
    this.wp_ohr_applicant_designation,
    this.wp_ohr_verifier_name,
    this.wp_ohr_verifier_designation,
    this.wp_ohr_verifier_phone,
    this.wp_ohr_verifier_mobile,
    this.wp_ohr_verifier_email,
  });

  String? wp_ohr_name_of_person_met;
  String? wp_ohr_knows_applicant;
  String? wp_ohr_employment_status;
  String? wp_ohr_date_of_joining;
  String? wp_ohr_applicant_designation;
  String? wp_ohr_verifier_name;
  String? wp_ohr_verifier_designation;
  String? wp_ohr_verifier_phone;
  String? wp_ohr_verifier_mobile;
  String? wp_ohr_verifier_email;
  
  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        wp_ohr_name_of_person_met: json['wp_ohr_name_of_person_met'],
        wp_ohr_knows_applicant: json['wp_ohr_knows_applicant'],
        wp_ohr_employment_status: json['wp_ohr_employment_status'],
        wp_ohr_date_of_joining: json['wp_ohr_date_of_joining'],
        wp_ohr_applicant_designation: json['wp_ohr_applicant_designation'],
        wp_ohr_verifier_name: json['wp_ohr_verifier_name'],
        wp_ohr_verifier_designation: json['wp_ohr_verifier_designation'],
        wp_ohr_verifier_phone: json['wp_ohr_verifier_phone'],
        wp_ohr_verifier_mobile: json['wp_ohr_verifier_mobile'],
        wp_ohr_verifier_email: json['wp_ohr_verifier_email'],
      );

  Map<String, dynamic> toJson() => {
        "wp_ohr_name_of_person_met": wp_ohr_name_of_person_met,
        'wp_ohr_knows_applicant': wp_ohr_knows_applicant,
        'wp_ohr_employment_status': wp_ohr_employment_status,
        'wp_ohr_date_of_joining': wp_ohr_date_of_joining,
        'wp_ohr_applicant_designation': wp_ohr_applicant_designation,
        'wp_ohr_verifier_name': wp_ohr_verifier_name,
        'wp_ohr_verifier_designation': wp_ohr_verifier_designation,
        'wp_ohr_verifier_phone': wp_ohr_verifier_phone,
        'wp_ohr_verifier_mobile': wp_ohr_verifier_mobile,
        'wp_ohr_verifier_email': wp_ohr_verifier_email,
      };
}

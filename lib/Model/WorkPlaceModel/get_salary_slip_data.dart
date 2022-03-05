import 'dart:convert';


GetSalaryData welcomeFromJson(String str) => GetSalaryData.fromJson(json.decode(str));

String welcomeToJson(GetSalaryData data) => json.encode(data.toJson());

class GetSalaryData {
  GetSalaryData({
    this.status,
    this.error,
    this.data,
  });

  bool? status;
  String? error;
  List<Data>? data;

  factory GetSalaryData.fromJson(Map<String, dynamic> json) => GetSalaryData(
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
    this.wp_ss_is_provided,
    this.wp_ss_if_pic_taken,
    this.wp_ss_credentials_verified,
    this.wp_ss_slip_verified,
    this.wp_ss_slip_verified_from,
    this.wp_ss_gross_salary,
    this.wp_ss_net_salary,
    this.wp_ss_report_status,
    this.wp_ss_comments,
    this.wp_ss_image1,
    this.wp_ss_image2,
    this.wp_ss_image3,
  });

  String? wp_ss_is_provided;
  String? wp_ss_if_pic_taken;
  String? wp_ss_credentials_verified;
  String? wp_ss_slip_verified;
  String? wp_ss_slip_verified_from;
  String? wp_ss_gross_salary;
  String? wp_ss_net_salary;
  String? wp_ss_report_status;
  String? wp_ss_comments;
  String? wp_ss_image1;
  String? wp_ss_image2;
  String? wp_ss_image3;
  
  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        wp_ss_is_provided: json['wp_ss_is_provided'],
        wp_ss_if_pic_taken: json['wp_ss_if_pic_taken'],
        wp_ss_credentials_verified: json['wp_ss_credentials_verified'],
        wp_ss_slip_verified: json['wp_ss_slip_verified'],
        wp_ss_slip_verified_from: json['wp_ss_slip_verified_from'],
        wp_ss_gross_salary: json['wp_ss_gross_salary'],
        wp_ss_net_salary: json['wp_ss_net_salary'],
        wp_ss_report_status: json['wp_ss_report_status'],
        wp_ss_comments: json['wp_ss_comments'],
        wp_ss_image1: json['wp_ss_image1'],
        wp_ss_image2: json['wp_ss_image2'],
        wp_ss_image3: json['wp_ss_image3'],
      );

  Map<String, dynamic> toJson() => {
        "wp_ss_is_provided": wp_ss_is_provided,
        'wp_ss_if_pic_taken': wp_ss_if_pic_taken,
        'wp_ss_credentials_verified': wp_ss_credentials_verified,
        'wp_ss_slip_verified': wp_ss_slip_verified,
        'wp_ss_slip_verified_from': wp_ss_slip_verified_from,
        'wp_ss_gross_salary': wp_ss_gross_salary,
        'wp_ss_net_salary': wp_ss_net_salary,
        'wp_ss_report_status': wp_ss_report_status,
        'wp_ss_comments': wp_ss_comments,
        'wp_ss_image1': wp_ss_image1,
        'wp_ss_image2': wp_ss_image2,
        'wp_ss_image3': wp_ss_image3,
      };
}

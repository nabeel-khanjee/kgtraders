import 'dart:convert';

GetBankVerificationData welcomeFromJson(String str) =>
    GetBankVerificationData.fromJson(json.decode(str));

String welcomeToJson(GetBankVerificationData data) => json.encode(data.toJson());

class GetBankVerificationData {
  GetBankVerificationData({
    this.status,
    this.error,
    this.data,
  });

  bool? status;
  String? error;
  List<Data>? data;

  factory GetBankVerificationData.fromJson(Map<String, dynamic> json) =>
      GetBankVerificationData(
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
    this.bnkst_bank_name,
    this.bnkst_branch,
    this.bnkst_branch_address,
    this.bnkst_landmark,
    this.bnkst_officer_name,
    this.bnkst_officer_designation,
    this.bnkst_officer_mobile,
    this.bnkst_account_no,
    this.bnkst_account_title,
    this.bnkst_is_account_active,
    this.bnkst_operating_since,
    this.bnkst_document_stamped,
  });

  String? bnkst_bank_name;
  String? bnkst_branch;
  String? bnkst_branch_address;
  String? bnkst_landmark;
  String? bnkst_officer_name;
  String? bnkst_officer_designation;
  String? bnkst_officer_mobile;
  String? bnkst_account_no;
  String? bnkst_account_title;
  String? bnkst_is_account_active;
  String? bnkst_operating_since;
  String? bnkst_document_stamped;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bnkst_landmark: json["bnkst_landmark"],
        bnkst_bank_name: json["bnkst_bank_name"],
        bnkst_branch: json['bnkst_branch'],
        bnkst_branch_address: json['bnkst_branch_address'],
        bnkst_officer_name: json['bnkst_officer_name'],
        bnkst_officer_designation: json['bnkst_officer_designation'],
        bnkst_officer_mobile: json['bnkst_officer_mobile'],
        bnkst_account_no: json['bnkst_account_no'],
        bnkst_account_title: json['bnkst_account_title'],
        bnkst_is_account_active: json['bnkst_is_account_active'],
        bnkst_operating_since:json["bnkst_operating_since"],
        bnkst_document_stamped: json['bnkst_document_stamped'],
      );

  Map<String, dynamic> toJson() => {
        "bnkst_landmark": bnkst_landmark,
        "bnkst_bank_name": bnkst_bank_name,
        "bnkst_branch": bnkst_branch,
        'bnkst_branch_address': bnkst_branch_address,
        'bnkst_officer_name': bnkst_officer_name,
        'bnkst_officer_designation': bnkst_officer_designation,
        'bnkst_officer_mobile': bnkst_officer_mobile,
        'bnkst_account_no': bnkst_account_no,
        'bnkst_account_title': bnkst_account_title,
        'bnkst_is_account_active': bnkst_is_account_active,
        "bnkst_operating_since":bnkst_operating_since,
        'bnkst_document_stamped': bnkst_document_stamped,
        'bnkst_is_account_active': bnkst_is_account_active,
        "bnkst_operating_since":bnkst_operating_since,
        
      };
}

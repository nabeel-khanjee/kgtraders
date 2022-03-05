import 'dart:convert';

GetWorkplaceData welcomeFromJson(String str) =>
    GetWorkplaceData.fromJson(json.decode(str));

String welcomeToJson(GetWorkplaceData data) => json.encode(data.toJson());

class GetWorkplaceData {
  GetWorkplaceData({
    this.status,
    this.error,
    this.data,
  });

  bool? status;
  String? error;
  List<Data>? data;

  factory GetWorkplaceData.fromJson(Map<String, dynamic> json) =>
      GetWorkplaceData(
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
      {this.job_id,
      this.wp_is_applicant_available,
      this.wp_original_nic_seen,
      this.wp_cnic_of_applicant,
      this.wp_name_of_person_met,
      this.wp_nic_of_person_met,
      this.wp_res_phone,
      this.wp_work_phone,
      this.wp_reson_of_non_ava,
      this.wp_is_address_correct,
      this.wp_correct_address,
      this.wp_does_applicant_works_here,
      this.wp_new_address,
      this.wp_working_here_since,
      this.wp_name_plate_affixed,
      this.wp_business_type,
      this.wp_other_business_type,
      this.wp_permisses_is,
      this.wp_other_permisses_is,
      this.wp_business_nature,
      this.wp_other_business_nature,
      this.wp_business_legal_activity,
      this.wp_area_size,
      this.wp_area_unit,
      this.wp_area_details,
      this.wp_business_activity,
      this.wp_no_of_employees,
      this.wp_established_since,
      this.wp_business_line,
      this.wp_establish_time,
      this.wp_is_government_employee,
      this.wp_premissi_rent});

  int? job_id;
  String? wp_establish_time;
  String? wp_is_applicant_available;
  String? wp_original_nic_seen;
  String? wp_cnic_of_applicant;
  String? wp_name_of_person_met;
  String? wp_nic_of_person_met;
  String? wp_res_phone;
  String? wp_work_phone;
  String? wp_reson_of_non_ava;
  String? wp_is_address_correct;
  String? wp_correct_address;
  String? wp_does_applicant_works_here;
  String? wp_new_address;
  String? wp_working_here_since;
  String? wp_name_plate_affixed;
  String? wp_business_type;
  String? wp_other_business_type;
  String? wp_permisses_is;
  String? wp_other_permisses_is;

  String? wp_business_nature;
  String? wp_other_business_nature;
  String? wp_business_legal_activity;
  String? wp_area_size;
  String? wp_area_unit;
  String? wp_area_details;
  String? wp_business_activity;
  String? wp_no_of_employees;
  String? wp_established_since;
  String? wp_business_line;
  String? wp_is_government_employee;
  String? wp_premissi_rent;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wp_premissi_rent: json['wp_premissi_rent'],
        wp_is_government_employee: json['wp_is_government_employee'],
        wp_establish_time: json['wp_establish_time'],
        job_id: json["job_id"],
        wp_is_applicant_available: json['wp_is_applicant_available'],
        wp_original_nic_seen: json['wp_original_nic_seen'],
        wp_cnic_of_applicant: json['wp_cnic_of_applicant'],
        wp_name_of_person_met: json['wp_name_of_person_met'],
        wp_nic_of_person_met: json['wp_nic_of_person_met'],
        wp_res_phone: json['wp_res_phone'],
        wp_work_phone: json['wp_work_phone'],
        wp_reson_of_non_ava: json['wp_reson_of_non_ava'],
        wp_is_address_correct: json['wp_is_address_correct'],
        wp_correct_address: json['wp_correct_address'],
        wp_does_applicant_works_here: json['wp_does_applicant_works_here'],
        wp_new_address: json['wp_new_address'],
        wp_working_here_since: json['wp_working_here_since'],
        wp_name_plate_affixed: json['wp_name_plate_affixed'],
        wp_business_type: json['wp_business_type'],
        wp_other_business_type: json['wp_other_business_type'],
        wp_permisses_is: json['wp_permisses_is'],
        wp_other_permisses_is: json['wp_other_permisses_is'],
        wp_business_nature: json['wp_business_nature'],
        wp_other_business_nature: json['wp_other_business_nature'],
        wp_business_legal_activity: json['wp_business_legal_activity'],
        wp_area_size: json['wp_area_size'],
        wp_area_unit: json['wp_area_unit'],
        wp_area_details: json['wp_area_details'],
        wp_business_activity: json['wp_business_activity'],
        wp_no_of_employees: json['wp_no_of_employees'],
        wp_established_since: json['wp_established_since'],
        wp_business_line: json['wp_business_line'],
      );

  Map<String, dynamic> toJson() => {
        'wp_premissi_rent': wp_premissi_rent,
        'wp_is_government_employee': wp_is_government_employee,
        "job_id": job_id,
        'wp_establish_time': wp_establish_time,
        "wp_is_applicant_available": wp_is_applicant_available,
        'wp_original_nic_seen': wp_original_nic_seen,
        'wp_cnic_of_applicant': wp_cnic_of_applicant,
        'wp_name_of_person_met': wp_name_of_person_met,
        'wp_nic_of_person_met': wp_nic_of_person_met,
        'wp_res_phone': wp_res_phone,
        'wp_work_phone': wp_work_phone,
        'wp_reson_of_non_ava': wp_reson_of_non_ava,
        'wp_is_address_correct': wp_is_address_correct,
        'wp_correct_address': wp_correct_address,
        'wp_does_applicant_works_here': wp_does_applicant_works_here,
        'wp_new_address': wp_new_address,
        'wp_working_here_since': wp_working_here_since,
        'wp_name_plate_affixed': wp_name_plate_affixed,
        'wp_business_type': wp_business_type,
        'wp_other_business_type': wp_other_business_type,
        'wp_permisses_is': wp_permisses_is,
        'wp_other_permisses_is': wp_other_permisses_is,
        'wp_business_nature': wp_business_nature,
        'wp_other_business_nature': wp_other_business_nature,
        'wp_business_legal_activity': wp_business_legal_activity,
        'wp_area_size': wp_area_size,
        'wp_area_unit': wp_area_unit,
        'wp_area_details': wp_area_details,
        'wp_business_activity': wp_business_activity,
        'wp_no_of_employees': wp_no_of_employees,
        'wp_established_since': wp_established_since,
        'wp_business_line': wp_business_line,
      };
}

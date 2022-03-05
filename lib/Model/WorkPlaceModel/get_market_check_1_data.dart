import 'dart:convert';


GetMarketCheck1Data welcomeFromJson(String str) => GetMarketCheck1Data.fromJson(json.decode(str));

String welcomeToJson(GetMarketCheck1Data data) => json.encode(data.toJson());

class GetMarketCheck1Data {
  GetMarketCheck1Data({
    this.status,
    this.error,
    this.data,
  });

  bool? status;
  String? error;
  List<Data>? data;

  factory GetMarketCheck1Data.fromJson(Map<String, dynamic> json) => GetMarketCheck1Data(
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
    this.mc_one_person_met,
    this.mc_one_addrees,
    this.mc_one_knows_applicant,
    this.mc_one_knows_applicant_since,
    this.mc_one_neighbor_comments,
    this.mc_one_business_established_since,
    this.mc_one_designation_of_met_person,
    this.mc_one_applicant_emp_status,
    this.mc_one_applicant_designation,
    this.mc_one_applicant_nature_of_job,
    this.mc_one_applicant_salary,
  });

  String? mc_one_person_met;
  String? mc_one_addrees;
  String? mc_one_knows_applicant;
  String? mc_one_knows_applicant_since;
  String? mc_one_neighbor_comments;
  String? mc_one_business_established_since;
  String? mc_one_designation_of_met_person;
  String? mc_one_applicant_emp_status;
  String? mc_one_applicant_designation;
  String? mc_one_applicant_nature_of_job;
  String? mc_one_applicant_salary;
  
  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        mc_one_person_met: json['mc_one_person_met'],
        mc_one_addrees: json['mc_one_addrees'],
        mc_one_knows_applicant: json['mc_one_knows_applicant'],
        mc_one_knows_applicant_since: json['mc_one_knows_applicant_since'],
        mc_one_neighbor_comments: json['mc_one_neighbor_comments'],
        mc_one_business_established_since: json['mc_one_business_established_since'],
        mc_one_designation_of_met_person: json['mc_one_designation_of_met_person'],
        mc_one_applicant_emp_status: json['mc_one_applicant_emp_status'],
        mc_one_applicant_designation: json['mc_one_applicant_designation'],
        mc_one_applicant_nature_of_job: json['mc_one_applicant_nature_of_job'],
        mc_one_applicant_salary: json['mc_one_applicant_salary'],
      );

  Map<String, dynamic> toJson() => {
        "mc_one_person_met": mc_one_person_met,
        'mc_one_addrees': mc_one_addrees,
        'mc_one_knows_applicant': mc_one_knows_applicant,
        'mc_one_knows_applicant_since': mc_one_knows_applicant_since,
        'mc_one_neighbor_comments': mc_one_neighbor_comments,
        'mc_one_business_established_since': mc_one_business_established_since,
        'mc_one_designation_of_met_person': mc_one_designation_of_met_person,
        'mc_one_applicant_emp_status': mc_one_applicant_emp_status,
        'mc_one_applicant_designation': mc_one_applicant_designation,
        'mc_one_applicant_nature_of_job': mc_one_applicant_nature_of_job,
        'mc_one_applicant_salary': mc_one_applicant_salary,
      };
}

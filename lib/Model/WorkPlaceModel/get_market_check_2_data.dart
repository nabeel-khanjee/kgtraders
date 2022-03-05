import 'dart:convert';


GetMarketCheck2Data welcomeFromJson(String str) => GetMarketCheck2Data.fromJson(json.decode(str));

String welcomeToJson(GetMarketCheck2Data data) => json.encode(data.toJson());

class GetMarketCheck2Data {
  GetMarketCheck2Data({
    this.status,
    this.error,
    this.data,
  });

  bool? status;
  String? error;
  List<Data>? data;

  factory GetMarketCheck2Data.fromJson(Map<String, dynamic> json) => GetMarketCheck2Data(
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
    this.mc_two_person_met,
    this.mc_two_addrees,
    this.mc_two_knows_applicant,
    this.mc_two_knows_applicant_since,
    this.mc_two_neighbor_comments,
    this.mc_two_business_established_since,
    this.mc_two_designation_of_met_person,
    this.mc_two_applicant_emp_status,
    this.mc_two_applicant_designation,
    this.mc_two_applicant_nature_of_job,
    this.mc_two_applicant_salary,
  });

  String? mc_two_person_met;
  String? mc_two_addrees;
  String? mc_two_knows_applicant;
  String? mc_two_knows_applicant_since;
  String? mc_two_neighbor_comments;
  String? mc_two_business_established_since;
  String? mc_two_designation_of_met_person;
  String? mc_two_applicant_emp_status;
  String? mc_two_applicant_designation;
  String? mc_two_applicant_nature_of_job;
  String? mc_two_applicant_salary;
  
  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        mc_two_person_met: json['mc_two_person_met'],
        mc_two_addrees: json['mc_two_addrees'],
        mc_two_knows_applicant: json['mc_two_knows_applicant'],
        mc_two_knows_applicant_since: json['mc_two_knows_applicant_since'],
        mc_two_neighbor_comments: json['mc_two_neighbor_comments'],
        mc_two_business_established_since: json['mc_two_business_established_since'],
        mc_two_designation_of_met_person: json['mc_two_designation_of_met_person'],
        mc_two_applicant_emp_status: json['mc_two_applicant_emp_status'],
        mc_two_applicant_designation: json['mc_two_applicant_designation'],
        mc_two_applicant_nature_of_job: json['mc_two_applicant_nature_of_job'],
        mc_two_applicant_salary: json['mc_two_applicant_salary'],
      );

  Map<String, dynamic> toJson() => {
        "mc_two_person_met": mc_two_person_met,
        'mc_two_addrees': mc_two_addrees,
        'mc_two_knows_applicant': mc_two_knows_applicant,
        'mc_two_knows_applicant_since': mc_two_knows_applicant_since,
        'mc_two_neighbor_comments': mc_two_neighbor_comments,
        'mc_two_business_established_since': mc_two_business_established_since,
        'mc_two_designation_of_met_person': mc_two_designation_of_met_person,
        'mc_two_applicant_emp_status': mc_two_applicant_emp_status,
        'mc_two_applicant_designation': mc_two_applicant_designation,
        'mc_two_applicant_nature_of_job': mc_two_applicant_nature_of_job,
        'mc_two_applicant_salary': mc_two_applicant_salary,
      };
}

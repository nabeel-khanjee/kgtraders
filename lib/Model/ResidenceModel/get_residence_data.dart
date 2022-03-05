import 'dart:convert';


GetResidenceData welcomeFromJson(String str) => GetResidenceData.fromJson(json.decode(str));

String welcomeToJson(GetResidenceData data) => json.encode(data.toJson());

class GetResidenceData {
  GetResidenceData({
    this.status,
    this.error,
    this.data,
  });

  bool? status;
  String? error;
  List<Data>? data;

  factory GetResidenceData.fromJson(Map<String, dynamic> json) => GetResidenceData(
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
    this.applicant_is_avaliable,
    this.is_address_correct,
    this.does_applicant_live_here,
    this.living_since,
    this.is_name_plate,
    this.residence_type,
    this.residence_is,
    this.residence_utilization,
    this.residence_area,
    this.residence_area_unit,
    this.residence_area_details,
    this.residence_condition,
    this.area_condition,
    this.neighbourhood,
    this.area_accessbility,
    this.residents_belong_to,
    this.repossession,
    this.original_nic_seen,
    this.name_of_person_met,
    this.nic_of_person_met,
    this.relationship_with_applicant,
    this.rel_phone,
    this.rel_cell,
    this.cnic_of_applicant,
    this.correct_address,
    this.permanent_address,
    this.other_residence_type,
    this.residence_is_other,
    this.applicant_is,
    this.monthly_rent,
    this.rent_deed_verified,
  });

  String? applicant_is_avaliable;
  String? is_address_correct;
  String? does_applicant_live_here;
  String? living_since;
  String? is_name_plate;
  String? residence_type;
  String? residence_is;
  String? residence_utilization;
  String? residence_area;
  String? residence_area_unit;
  String? residence_area_details;
  String? residence_condition;
  String? area_condition;
  String? neighbourhood;
  String? area_accessbility;
  String? residents_belong_to;
  String? repossession;
  String? original_nic_seen;
  String? name_of_person_met;
  String? nic_of_person_met;
  String? relationship_with_applicant;
  String? rel_phone;
  String? rel_cell;
  String? cnic_of_applicant;
  String? correct_address;
  String? permanent_address;
  String? other_residence_type;
  String? residence_is_other;
  String? applicant_is;
  String? monthly_rent;
  String? rent_deed_verified;
  
  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        applicant_is_avaliable: json["applicant_is_avaliable"],
        is_address_correct: json['is_address_correct'],
        does_applicant_live_here: json['does_applicant_live_here'],
        living_since: json['living_since'],
        is_name_plate: json['is_name_plate'],
        residence_type: json['residence_type'],
        residence_is: json['residence_is'],
        residence_utilization: json['residence_utilization'],
        residence_area: json['residence_area'],
        residence_area_unit: json['residence_area_unit'],
        residence_area_details: json['residence_area_details'],
        residence_condition: json['residence_condition'],
        area_condition: json['area_condition'],
        neighbourhood: json['neighbourhood'],
        area_accessbility: json['area_accessbility'],
        residents_belong_to: json['residents_belong_to'],
        repossession:json['repossession'],
        original_nic_seen: json['original_nic_seen'],
        name_of_person_met: json['name_of_person_met'],
        nic_of_person_met: json['nic_of_person_met'],
        relationship_with_applicant: json['relationship_with_applicant'],
        rel_phone: json['rel_phone'],
        rel_cell: json['rel_cell'],
        cnic_of_applicant: json['cnic_of_applicant'],
        correct_address: json['correct_address'],
        permanent_address: json['permanent_address'],
        other_residence_type:json['other_residence_type'],
        residence_is_other: json['residence_is_other'],
        applicant_is: json['applicant_is'],
        monthly_rent: json['monthly_rent'],
        rent_deed_verified: json['rent_deed_verified'],
      );

  Map<String, dynamic> toJson() => {
        "applicant_is_avaliable": applicant_is_avaliable,
        "is_address_correct": is_address_correct,
        'does_applicant_live_here': does_applicant_live_here,
        'living_since': living_since,
        'is_name_plate': is_name_plate,
        'residence_type': residence_type,
        'residence_is': residence_is,
        'residence_utilization': residence_utilization,
        'residence_area': residence_area,
        'residence_area_unit': residence_area_unit,
        'residence_area_details': residence_area_details,
        'residence_condition': residence_condition,
        'area_condition': area_condition,
        'neighbourhood': neighbourhood,
        'area_accessbility': area_accessbility,
        'residents_belong_to': residents_belong_to,
        'repossession':repossession,
        'original_nic_seen': original_nic_seen,
        'name_of_person_met': name_of_person_met,
        'nic_of_person_met': nic_of_person_met,
        'relationship_with_applicant': relationship_with_applicant,
        'rel_phone': rel_phone,
        'rel_cell': rel_cell,
        'cnic_of_applicant': cnic_of_applicant,
        'correct_address': correct_address,
        'permanent_address': permanent_address,
        'other_residence_type':other_residence_type,
        'residence_is_other': residence_is_other,
        'applicant_is': applicant_is,
        'monthly_rent': monthly_rent,
        'rent_deed_verified': rent_deed_verified,
      };
}

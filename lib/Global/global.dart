import 'package:radium_tech/Model/WorkPlaceModel/get_workplace_data.dart';

var success;
var token;
var userid;
var username;
var imagepath1;

List<GetWorkplace_ListDetails> WorkPlace_list = [];
List<ApplicantDetail> ApplicantDetail_list = [];
List<ResidenceDetail> ResidenceDetail_list = [];
List<NeighborOneDetail> Neighborone_list = [];
List<NeighborTwoDetail> Neighbortwo_list = [];
List<SurveyorDetail> Surveyor_list = [];

class GetWorkplace_ListDetails {
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

  GetWorkplace_ListDetails({
    this.job_id,
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
  });
}

class ApplicantDetail {
  String? applicantName;
  String? applicantFather;
  String? dob;
  String? applicantCnic;
  String? resPhone;
  String? workPhone;
  String? cellPhone;
  String? residenceAddress;
  String? landmark;
  Null? longitude;
  Null? latitiude;

  ApplicantDetail(
      {this.applicantName,
      this.applicantFather,
      this.dob,
      this.applicantCnic,
      this.resPhone,
      this.workPhone,
      this.cellPhone,
      this.residenceAddress,
      this.landmark,
      this.longitude,
      this.latitiude});
}

class ResidenceDetail {
  String? applicantIsAvaliable;
  int? jobId;
  String? isAddressCorrect;
  String? doesApplicantLiveHere;
  String? livingSince;
  String? isNamePlate;
  String? residenceType;
  String? residenceIs;
  String? residenceUtilization;
  String? residenceArea;
  String? residenceAreaUnit;
  String? residenceAreaDetails;
  String? residenceCondition;
  String? areaCondition;
  String? neighbourhood;
  String? areaAccessbility;
  String? residentsBelongTo;
  String? repossession;

  ResidenceDetail(
      {this.applicantIsAvaliable,
      this.jobId,
      this.isAddressCorrect,
      this.doesApplicantLiveHere,
      this.livingSince,
      this.isNamePlate,
      this.residenceType,
      this.residenceIs,
      this.residenceUtilization,
      this.residenceArea,
      this.residenceAreaUnit,
      this.residenceAreaDetails,
      this.residenceCondition,
      this.areaCondition,
      this.neighbourhood,
      this.areaAccessbility,
      this.residentsBelongTo,
      this.repossession});
}

class NeighborOneDetail {
  String? name;
  String? address;
  String? knowsApplicant;
  String? knowsSince;
  String? comments;

  NeighborOneDetail(
      {this.name,
      this.address,
      this.knowsApplicant,
      this.knowsSince,
      this.comments});
}

class NeighborTwoDetail {
  String? name;
  String? address;
  String? knowsApplicant;
  String? knowsSince;
  String? comments;

  NeighborTwoDetail(
      {this.name,
      this.address,
      this.knowsApplicant,
      this.knowsSince,
      this.comments});
}

class SurveyorDetail {
  String? surveyor;
  String? reportStatus;
  String? comments;
  String? remarks;

  SurveyorDetail(
      {this.surveyor, this.reportStatus, this.comments, this.remarks});
}

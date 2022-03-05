import 'dart:convert';

GetVerificationOutcome welcomeFromJson(String str) =>
    GetVerificationOutcome.fromJson(json.decode(str));

String welcomeToJson(GetVerificationOutcome data) => json.encode(data.toJson());

class GetVerificationOutcome {
  GetVerificationOutcome({
    this.status,
    this.error,
    this.data,
  });

  bool? status;
  String? error;
  List<Data>? data;

  factory GetVerificationOutcome.fromJson(Map<String, dynamic> json) =>
      GetVerificationOutcome(
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
    this.negativeComments,
    this.surveyor,
    this.report_status,
    this.comments,
    this.remarks,
  });
  String? negativeComments;
  String? surveyor;
  String? report_status;
  String? comments;
  String? remarks;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        surveyor: json["surveyor"],
        report_status: json['report_status'],
        comments: json['comments'],
        remarks: json['remarks'],
        negativeComments: json['negative_comments']
      );

  Map<String, dynamic> toJson() => {
        "surveyor": surveyor,
        "report_status": report_status,
        'comments': comments,
        'remarks': remarks,
        'negative_comments':negativeComments
      };
}

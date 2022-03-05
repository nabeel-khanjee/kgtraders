import 'dart:convert';

GetNeighbour1Data welcomeFromJson(String str) =>
    GetNeighbour1Data.fromJson(json.decode(str));

String welcomeToJson(GetNeighbour1Data data) => json.encode(data.toJson());

class GetNeighbour1Data {
  GetNeighbour1Data({
    this.status,
    this.error,
    this.data,
  });

  bool? status;
  String? error;
  List<Data>? data;

  factory GetNeighbour1Data.fromJson(Map<String, dynamic> json) =>
      GetNeighbour1Data(
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
     this.name,
    this.address,
    this.knows_applicant,
    this.knows_since,
    this.comments,
 });

 String? name;
  String? address;
  String? knows_applicant;
  String? knows_since;
  String? comments;
  
  factory Data.fromJson(Map<String, dynamic> json) => Data(
         name: json["name"],
        address: json['address'],
        knows_applicant: json['knows_applicant'],
        knows_since: json["knows_since"],
        comments:json['comments'],
     );

  Map<String, dynamic> toJson() => {
       "name": name,
        "address": address,
        'knows_applicant': knows_applicant,
        'knows_since': knows_since,
        'comments':comments
       };
}

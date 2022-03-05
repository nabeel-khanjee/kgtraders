import 'dart:convert';

ImageResponse imagerResponseFromJson(String str) =>
    ImageResponse.fromJson(json.decode(str));

String imagerResponseToJson(ImageResponse data) => json.encode(data.toJson());

class ImageResponse {
  ImageResponse({
    this.status,
    this.error,
    this.data,
  });

  bool? status;
  String? error;
  List<ImageResponseDatum>? data;

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
        status: json["status"],
        error: json["error"],
        data: List<ImageResponseDatum>.from(
            json["data"].map((x) => ImageResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ImageResponseDatum {
  ImageResponseDatum({
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.image6,
    this.image7,
    this.image8,
    this.image9,
  });

  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? image6;
  String? image7;
  String? image8;
  String? image9;

  factory ImageResponseDatum.fromJson(Map<String, dynamic> json) =>
      ImageResponseDatum(
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        image4: json["image4"],
        image5: json["image5"],
        image6: json["image6"],
        image7: json["image7"],
        image8: json["image8"],
        image9: json["image9"],
        
      );

  Map<String, dynamic> toJson() => {
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "image4": image4,
        "image5": image5,
        "image6": image6,
        "image7": image7,
        "image8": image8,
        "image9": image9,
      };
}

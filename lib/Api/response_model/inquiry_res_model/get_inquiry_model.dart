// To parse this JSON data, do
//
//     final getInquiryModel = getInquiryModelFromJson(jsonString);

import 'dart:convert';

GetInquiryModel getInquiryModelFromJson(String str) =>
    GetInquiryModel.fromJson(json.decode(str));

String getInquiryModelToJson(GetInquiryModel data) =>
    json.encode(data.toJson());

class GetInquiryModel {
  bool success;
  String message;
  List<InquiryData> data;

  GetInquiryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetInquiryModel.fromJson(Map<String, dynamic> json) =>
      GetInquiryModel(
        success: json["success"],
        message: json["message"],
        data: List<InquiryData>.from(
            json["data"].map((x) => InquiryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class InquiryData {
  String id;
  List<String> courses;
  int inquiryNumber;
  String inquiryDate;
  String followUpDate;
  String mobileNumber;
  String name;
  String reference;
  String inquiryStatus;
  String note;
  int v;

  InquiryData({
    required this.id,
    required this.courses,
    required this.inquiryNumber,
    required this.inquiryDate,
    required this.followUpDate,
    required this.mobileNumber,
    required this.name,
    required this.reference,
    required this.inquiryStatus,
    required this.note,
    required this.v,
  });

  factory InquiryData.fromJson(Map<String, dynamic> json) => InquiryData(
        id: json["_id"],
        courses: List<String>.from(json["courses"].map((x) => x)),
        inquiryNumber: json["inquiry_number"],
        inquiryDate: json["inquiry_date"],
        followUpDate: json["follow_up_date"],
        mobileNumber: json["mobile_number"],
        name: json["name"],
        reference: json["reference"],
        inquiryStatus: json["inquiry_status"],
        note: json["note"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "courses": List<dynamic>.from(courses.map((x) => x)),
        "inquiry_number": inquiryNumber,
        "inquiry_date": inquiryDate,
        "follow_up_date": followUpDate,
        "mobile_number": mobileNumber,
        "name": name,
        "reference": reference,
        "inquiry_status": inquiryStatus,
        "note": note,
        "__v": v,
      };
}

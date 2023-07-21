// To parse this JSON data, do
//
//     final configDetailsModel = configDetailsModelFromJson(jsonString);

import 'dart:convert';

ConfigDetailsModel configDetailsModelFromJson(String str) =>
    ConfigDetailsModel.fromJson(json.decode(str));

String configDetailsModelToJson(ConfigDetailsModel data) =>
    json.encode(data.toJson());

class ConfigDetailsModel {
  bool success;
  String message;
  ConfigData data;

  ConfigDetailsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ConfigDetailsModel.fromJson(Map<String, dynamic> json) =>
      ConfigDetailsModel(
        success: json["success"],
        message: json["message"],
        data: ConfigData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class ConfigData {
  String id;
  List<String> courses;
  List<String> paymentModes;
  List<String> inquiryStatus;
  List<String> certificateType;
  int totalStudents;
  int totalCompleteStudents;
  int totalInquiries;
  int totalCurrentDemo;

  ConfigData({
    required this.id,
    required this.courses,
    required this.paymentModes,
    required this.inquiryStatus,
    required this.certificateType,
    required this.totalStudents,
    required this.totalCompleteStudents,
    required this.totalInquiries,
    required this.totalCurrentDemo,
  });

  factory ConfigData.fromJson(Map<String, dynamic> json) => ConfigData(
        id: json["_id"],
        courses: List<String>.from(json["courses"].map((x) => x)),
        paymentModes: List<String>.from(json["payment_modes"].map((x) => x)),
        inquiryStatus: List<String>.from(json["inquiry_status"].map((x) => x)),
        certificateType:
            List<String>.from(json["certificate_type"].map((x) => x)),
        totalStudents: json["total_students"],
        totalCompleteStudents: json["total_complete_students"],
        totalInquiries: json["total_inquiries"],
        totalCurrentDemo: json["total_current_demo"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "courses": List<dynamic>.from(courses.map((x) => x)),
        "payment_modes": List<dynamic>.from(paymentModes.map((x) => x)),
        "inquiry_status": List<dynamic>.from(inquiryStatus.map((x) => x)),
        "certificate_type": List<dynamic>.from(certificateType.map((x) => x)),
        "total_students": totalStudents,
        "total_complete_students": totalCompleteStudents,
        "total_inquiries": totalInquiries,
        "total_current_demo": totalCurrentDemo,
      };
}

// To parse this JSON data, do
//
//     final updateInquiryModel = updateInquiryModelFromJson(jsonString);

import 'dart:convert';

UpdateInquiryModel updateInquiryModelFromJson(String str) =>
    UpdateInquiryModel.fromJson(json.decode(str));

String updateInquiryModelToJson(UpdateInquiryModel data) =>
    json.encode(data.toJson());

class UpdateInquiryModel {
  bool success;
  String message;

  UpdateInquiryModel({
    required this.success,
    required this.message,
  });

  factory UpdateInquiryModel.fromJson(Map<String, dynamic> json) =>
      UpdateInquiryModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}

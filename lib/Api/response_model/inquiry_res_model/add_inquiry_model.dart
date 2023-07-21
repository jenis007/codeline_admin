// To parse this JSON data, do
//
//     final addInquiryModel = addInquiryModelFromJson(jsonString);

import 'dart:convert';

AddInquiryModel addInquiryModelFromJson(String str) =>
    AddInquiryModel.fromJson(json.decode(str));

String addInquiryModelToJson(AddInquiryModel data) =>
    json.encode(data.toJson());

class AddInquiryModel {
  bool success;
  String message;

  AddInquiryModel({
    required this.success,
    required this.message,
  });

  factory AddInquiryModel.fromJson(Map<String, dynamic> json) =>
      AddInquiryModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}

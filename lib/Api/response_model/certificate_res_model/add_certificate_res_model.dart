// To parse this JSON data, do
//
//     final addCertificateModel = addCertificateModelFromJson(jsonString);

import 'dart:convert';

AddCertificateModel addCertificateModelFromJson(String str) =>
    AddCertificateModel.fromJson(json.decode(str));

String addCertificateModelToJson(AddCertificateModel data) =>
    json.encode(data.toJson());

class AddCertificateModel {
  bool success;
  String message;

  AddCertificateModel({
    required this.success,
    required this.message,
  });

  factory AddCertificateModel.fromJson(Map<String, dynamic> json) =>
      AddCertificateModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}

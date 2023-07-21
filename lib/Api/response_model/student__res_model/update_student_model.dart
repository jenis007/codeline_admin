// To parse this JSON data, do
//
//     final updateStudentModel = updateStudentModelFromJson(jsonString);

import 'dart:convert';

UpdateStudentModel updateStudentModelFromJson(String str) =>
    UpdateStudentModel.fromJson(json.decode(str));

String updateStudentModelToJson(UpdateStudentModel data) =>
    json.encode(data.toJson());

class UpdateStudentModel {
  bool success;
  String message;

  UpdateStudentModel({
    required this.success,
    required this.message,
  });

  factory UpdateStudentModel.fromJson(Map<String, dynamic> json) =>
      UpdateStudentModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}

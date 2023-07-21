// To parse this JSON data, do
//
//     final addStudentModel = addStudentModelFromJson(jsonString);

import 'dart:convert';

AddStudentModel addStudentModelFromJson(String str) =>
    AddStudentModel.fromJson(json.decode(str));

String addStudentModelToJson(AddStudentModel data) =>
    json.encode(data.toJson());

class AddStudentModel {
  bool success;
  String message;

  AddStudentModel({
    required this.success,
    required this.message,
  });

  factory AddStudentModel.fromJson(Map<String, dynamic> json) =>
      AddStudentModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}

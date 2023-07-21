// To parse this JSON data, do
//
//     final getStudentModel = getStudentModelFromJson(jsonString);

import 'dart:convert';

GetStudentModel getStudentModelFromJson(String str) =>
    GetStudentModel.fromJson(json.decode(str));

String getStudentModelToJson(GetStudentModel data) =>
    json.encode(data.toJson());

class GetStudentModel {
  bool success;
  String message;
  List<GetStudentDetails> data;

  GetStudentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetStudentModel.fromJson(Map<String, dynamic> json) =>
      GetStudentModel(
        success: json["success"],
        message: json["message"],
        data: List<GetStudentDetails>.from(
            json["data"].map((x) => GetStudentDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetStudentDetails {
  String id;
  List<String> courses;
  int paidInstallments;
  List<dynamic> paidFees;
  bool isCourseComplete;
  String rollNumber;
  String name;
  String email;
  String joiningDate;
  String birthDate;
  String education;
  String mobileNumber;
  String parentMobileNumber;
  String address;
  String courseDuration;
  int totalInstallments;
  int totalFees;
  int pendingFees;
  int v;

  GetStudentDetails({
    required this.id,
    required this.courses,
    required this.paidInstallments,
    required this.paidFees,
    required this.isCourseComplete,
    required this.rollNumber,
    required this.name,
    required this.email,
    required this.joiningDate,
    required this.birthDate,
    required this.education,
    required this.mobileNumber,
    required this.parentMobileNumber,
    required this.address,
    required this.courseDuration,
    required this.totalInstallments,
    required this.totalFees,
    required this.pendingFees,
    required this.v,
  });

  factory GetStudentDetails.fromJson(Map<String, dynamic> json) =>
      GetStudentDetails(
        id: json["_id"],
        courses: List<String>.from(json["courses"].map((x) => x)),
        paidInstallments: json["paid_installments"],
        paidFees: List<dynamic>.from(json["paid_fees"].map((x) => x)),
        isCourseComplete: json["is_course_complete"],
        rollNumber: json["roll_number"],
        name: json["name"],
        email: json["email"],
        joiningDate: json["joining_date"],
        birthDate: json["birth_date"],
        education: json["education"],
        mobileNumber: json["mobile_number"],
        parentMobileNumber: json["parent_mobile_number"],
        address: json["address"],
        courseDuration: json["course_duration"],
        totalInstallments: json["total_installments"],
        totalFees: json["total_fees"],
        pendingFees: json["pending_fees"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "courses": List<dynamic>.from(courses.map((x) => x)),
        "paid_installments": paidInstallments,
        "paid_fees": List<dynamic>.from(paidFees.map((x) => x)),
        "is_course_complete": isCourseComplete,
        "roll_number": rollNumber,
        "name": name,
        "email": email,
        "joining_date": joiningDate,
        "birth_date": birthDate,
        "education": education,
        "mobile_number": mobileNumber,
        "parent_mobile_number": parentMobileNumber,
        "address": address,
        "course_duration": courseDuration,
        "total_installments": totalInstallments,
        "total_fees": totalFees,
        "pending_fees": pendingFees,
        "__v": v,
      };
}

// To parse this JSON data, do
//
//     final getParticularStudentModel = getParticularStudentModelFromJson(jsonString);

import 'dart:convert';

GetParticularStudentModel getParticularStudentModelFromJson(String str) =>
    GetParticularStudentModel.fromJson(json.decode(str));

String getParticularStudentModelToJson(GetParticularStudentModel data) =>
    json.encode(data.toJson());

class GetParticularStudentModel {
  bool success;
  String message;
  ParticularStudentData data;

  GetParticularStudentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetParticularStudentModel.fromJson(Map<String, dynamic> json) =>
      GetParticularStudentModel(
        success: json["success"],
        message: json["message"],
        data: ParticularStudentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class ParticularStudentData {
  String id;
  List<String> courses;
  int paidInstallments;
  List<PaidFee> paidFees;
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

  ParticularStudentData({
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

  factory ParticularStudentData.fromJson(Map<String, dynamic> json) =>
      ParticularStudentData(
        id: json["_id"],
        courses: List<String>.from(json["courses"].map((x) => x)),
        paidInstallments: json["paid_installments"],
        paidFees: List<PaidFee>.from(
            json["paid_fees"].map((x) => PaidFee.fromJson(x))),
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
        "paid_fees": List<dynamic>.from(paidFees.map((x) => x.toJson())),
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

class PaidFee {
  String id;
  String receiptNumber;
  String paymentDate;
  int amount;
  String amountInWords;
  String paymentMode;
  String studentId;
  String studentName;
  int installmentNumber;
  int v;

  PaidFee({
    required this.id,
    required this.receiptNumber,
    required this.paymentDate,
    required this.amount,
    required this.amountInWords,
    required this.paymentMode,
    required this.studentId,
    required this.studentName,
    required this.installmentNumber,
    required this.v,
  });

  factory PaidFee.fromJson(Map<String, dynamic> json) => PaidFee(
        id: json["_id"],
        receiptNumber: json["receipt_number"],
        paymentDate: json["payment_date"],
        amount: json["amount"],
        amountInWords: json["amount_in_words"],
        paymentMode: json["payment_mode"],
        studentId: json["student_id"],
        studentName: json["student_name"],
        installmentNumber: json["installment_number"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "receipt_number": receiptNumber,
        "payment_date": paymentDate,
        "amount": amount,
        "amount_in_words": amountInWords,
        "payment_mode": paymentMode,
        "student_id": studentId,
        "student_name": studentName,
        "installment_number": installmentNumber,
        "__v": v,
      };
}

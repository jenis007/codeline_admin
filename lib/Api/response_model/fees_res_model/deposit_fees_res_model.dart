// To parse this JSON data, do
//
//     final addFeesModel = addFeesModelFromJson(jsonString);

import 'dart:convert';

AddFeesModel addFeesModelFromJson(String str) =>
    AddFeesModel.fromJson(json.decode(str));

String addFeesModelToJson(AddFeesModel data) => json.encode(data.toJson());

class AddFeesModel {
  bool success;
  String message;
  AddInstallmentData data;

  AddFeesModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddFeesModel.fromJson(Map<String, dynamic> json) => AddFeesModel(
        success: json["success"],
        message: json["message"],
        data: AddInstallmentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class AddInstallmentData {
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

  AddInstallmentData({
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

  factory AddInstallmentData.fromJson(Map<String, dynamic> json) =>
      AddInstallmentData(
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

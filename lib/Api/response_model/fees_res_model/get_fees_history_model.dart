// To parse this JSON data, do
//
//     final getFeesHistoryModel = getFeesHistoryModelFromJson(jsonString);

import 'dart:convert';

GetFeesHistoryModel getFeesHistoryModelFromJson(String str) =>
    GetFeesHistoryModel.fromJson(json.decode(str));

String getFeesHistoryModelToJson(GetFeesHistoryModel data) =>
    json.encode(data.toJson());

class GetFeesHistoryModel {
  bool success;
  String message;
  List<FeesDetail> data;

  GetFeesHistoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetFeesHistoryModel.fromJson(Map<String, dynamic> json) =>
      GetFeesHistoryModel(
        success: json["success"],
        message: json["message"],
        data: List<FeesDetail>.from(
            json["data"].map((x) => FeesDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FeesDetail {
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

  FeesDetail({
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

  factory FeesDetail.fromJson(Map<String, dynamic> json) => FeesDetail(
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

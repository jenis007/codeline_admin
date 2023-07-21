// To parse this JSON data, do
//
//     final getCertificateDataModel = getCertificateDataModelFromJson(jsonString);

import 'dart:convert';

GetCertificateDataModel getCertificateDataModelFromJson(String str) =>
    GetCertificateDataModel.fromJson(json.decode(str));

String getCertificateDataModelToJson(GetCertificateDataModel data) =>
    json.encode(data.toJson());

class GetCertificateDataModel {
  bool? success;
  String? message;
  List<CertificateData>? data;

  GetCertificateDataModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetCertificateDataModel.fromJson(Map<String, dynamic> json) =>
      GetCertificateDataModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CertificateData>.from(
                json["data"]!.map((x) => CertificateData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CertificateData {
  String? id;
  String? certificateLink;
  String? studentId;
  String? studentName;
  String? type;
  int? v;

  CertificateData({
    this.id,
    this.certificateLink,
    this.studentId,
    this.studentName,
    this.type,
    this.v,
  });

  factory CertificateData.fromJson(Map<String, dynamic> json) =>
      CertificateData(
        id: json["_id"],
        certificateLink: json["certificate_link"],
        studentId: json["student_id"],
        studentName: json["student_name"],
        type: json["type"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "certificate_link": certificateLink,
        "student_id": studentId,
        "student_name": studentName,
        "type": type,
        "__v": v,
      };
}

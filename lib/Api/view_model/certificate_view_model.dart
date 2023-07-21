import 'package:codeline_admin/Api/repo/certificate_repo.dart';
import 'package:codeline_admin/Api/response_model/certificate_res_model/add_certificate_res_model.dart';
import 'package:codeline_admin/Api/response_model/certificate_res_model/get_certificate_es_model.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/certificates/course_completion_certificate.dart';
import '../../view/certificates/experience_certificate.dart';
import '../../view/certificates/internship_completion_certificate.dart';
import '../../view/certificates/internship_offer_later.dart';
import '../../widget/common_snackbar.dart';
import '../api_Model/api_response.dart';
import '../response_model/student__res_model/get_student_model.dart';

class CertificateApiController extends GetxController {
  List<CertificateData> certificateData = [];

  ApiResponse certificateResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get certificateApiResponse => certificateResponse;

  Future addCertificateDetails({String? url, d.FormData? body}) async {
    certificateResponse = ApiResponse.loading(message: 'Loading');

    try {
      AddCertificateModel addCertificateModel =
          await CertificateRepo().certificateUploadRepo(url: url, body: body);

      certificateResponse = ApiResponse.complete(addCertificateModel);
    } catch (e) {
      certificateResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }

  ApiResponse getCertificateResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getCertificateApiResponse => getCertificateResponse;

  Future getCertificateDetails({String? id}) async {
    getCertificateResponse = ApiResponse.loading(message: 'Loading');

    try {
      GetCertificateDataModel getCertificateDataModel =
          await CertificateRepo().getCertificate();
      certificateData.clear();
      for (var i = 0; i < getCertificateDataModel.data!.length; i++) {
        if (getCertificateDataModel.data![i].studentId == id) {
          certificateData.add(getCertificateDataModel.data![i]);
        }
      }
      getCertificateResponse = ApiResponse.complete(getCertificateDataModel);
    } catch (e) {
      getCertificateResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }

  DateTime? selectDate;
  DateTime? selectFirstDate;
  DateTime? selectLastDate;
  String selectStudentId = '';
  List<String> studentList = [];
  List<String> installmentList = [];
  List<String> fullName = [];

  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController projectTitleController = TextEditingController();

  /// update certificates type

  String certificateType = '';

  updateCertificateType(String value) {
    certificateType = value;
    update();
  }

  /// update gender type

  String genderType = '';

  updateGenderType(String value) {
    clearValue();
    genderType = value;
    update();
  }

  /// update gender pronounce

  String genderValue = '';
  String genderValue1 = '';
  String genderValue2 = '';

  updateGenderValue(String value) {
    if (value == 'Mr.') {
      genderValue = 'him';
      genderValue1 = 'his';
      genderValue2 = 'he';
    } else {
      genderValue = 'her';
      genderValue1 = 'her';
      genderValue2 = 'she';
    }
    update();
  }

  /// select certificate date

  selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime.now(),
        cancelText: selectDate = null);

    if (picked != null) {
      selectDate = picked;
    }
    update();
  }

  /// select first date

  selectedFirstDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime.now(),
        cancelText: selectFirstDate = null);
    if (picked != null) {
      selectFirstDate = picked;
    }

    update();
  }

  /// select last date

  selectedLastDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: selectFirstDate!,
        lastDate: DateTime.now(),
        cancelText: selectLastDate = null);
    if (picked != null) {
      selectLastDate = picked;
    }
    update();
  }

  ///Difference of firstdate and lastdate----------------------------------------------------------------------

  differenceDays(BuildContext context) {
    final difference = selectLastDate?.difference(selectFirstDate!).inDays;
    int months = difference! ~/ 30;
    return months;
  }

  /// add certificates data to firebase

  addCertificatesData(BuildContext context) async {
    selectDate ??= DateTime.now();

    if (certificateType == 'Flutter - Course Completion Certificates') {
      try {
        Get.to(() => CourseCompletionCertificate(
              certificatesType: certificateType,
              collegeName: educationController.text,
              description: descriptionController.text,
              firstName: firstNameController.text,
              middleName: middleNameController.text,
              lastName: lastNameController.text,
              gender: genderType,
              occupation: occupationController.text,
              selectDate: selectDate,
              firstDate: selectFirstDate,
              lastDate: selectLastDate,
              genderPronounce: genderValue,
              genderPronounce1: genderValue1,
              id: selectStudentId,
            ));
      } catch (e) {
        CommonSnackBar.getWarningSnackBar(context, 'Something went wrong');
      }
    } else if (certificateType == 'Experience certificate') {
      try {
        Get.to(() => ExperienceCertificate(
              certificatesType: certificateType,
              collegeName: educationController.text,
              description: descriptionController.text,
              firstName: firstNameController.text,
              middleName: middleNameController.text,
              lastName: lastNameController.text,
              gender: genderType,
              occupation: occupationController.text,
              selectDate: selectDate,
              firstDate: selectFirstDate,
              lastDate: selectLastDate,
              genderPronounce1: genderValue1,
              id: selectStudentId,
            ));
      } catch (e) {
        CommonSnackBar.getWarningSnackBar(context, 'Something went wrong');
      }
    } else if (certificateType == 'Internship Offer Letter') {
      try {
        Get.to(() => InternshipOfferLater(
              certificatesType: certificateType,
              collegeName: educationController.text,
              description: descriptionController.text,
              firstName: firstNameController.text,
              middleName: middleNameController.text,
              lastName: lastNameController.text,
              gender: genderType,
              occupation: occupationController.text,
              selectDate: selectDate,
              firstDate: selectFirstDate,
              lastDate: selectLastDate,
              id: selectStudentId,
              months: differenceDays(context),
            ));
      } catch (e) {
        CommonSnackBar.getWarningSnackBar(context, 'Something went wrong');
      }
    } else if (certificateType == 'Internship Completion  Certificate') {
      try {
        Get.to(() => InternshipCompletionCertificate(
              certificatesType: certificateType,
              collegeName: educationController.text,
              description: descriptionController.text,
              firstName: firstNameController.text,
              middleName: middleNameController.text,
              lastName: lastNameController.text,
              gender: genderType,
              occupation: occupationController.text,
              selectDate: selectDate,
              firstDate: selectFirstDate,
              lastDate: selectLastDate,
              months: differenceDays(context),
              genderPronounce: genderValue,
              genderPronounce1: genderValue1,
              genderPronounce2: genderValue2,
              projectTitle: projectTitleController.text,
              id: selectStudentId,
            ));
      } catch (e) {
        CommonSnackBar.getWarningSnackBar(context, 'Something went wrong');
      }
    }

    update();
  }

  ///Get Student--------------------------------------------------------
  Future getStudent({GetStudentModel? getStudentModel}) async {
    try {
      studentList.clear();

      /// For Certificate AUTO COMPLETE
      for (var i = 0; i < getStudentModel!.data.length; i++) {
        studentList.add(getStudentModel.data[i].name);
        installmentList.add(
            '${getStudentModel.data[i].name}..${getStudentModel.data[i].id}');
      }
    } catch (e) {}
    update();
  }

  getStudentId(String value) {
    for (int i = 0; i < studentList.length; i++) {
      String name = installmentList[i].toString().split('..').first;

      if (name.trim().toLowerCase().toString() ==
          value.trim().toLowerCase().toString()) {
        selectStudentId = installmentList[i].split('..').last;
        fullName = name.split(' ');
        for (var j = 0; j < fullName.length; j++) {
          if (j == 0) {
            firstNameController.text = fullName[j];
          } else if (j == 1) {
            middleNameController.text = fullName[j];
          } else if (j == 2) {
            lastNameController.text = fullName[j];
          }
        }
      }
    }
    update();
  }

  clearValue() {
    genderType = '';
    firstNameController.clear();
    lastNameController.clear();
    middleNameController.clear();
    certificateType = '';
    occupationController.clear();
    educationController.clear();
    descriptionController.clear();
    projectTitleController.clear();
    // selectDate = null;
    selectFirstDate = null;
    selectLastDate = null;
    update();
  }
}

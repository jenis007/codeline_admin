import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_Model/api_response.dart';
import '../repo/inquiry_repo.dart';
import '../response_model/inquiry_res_model/add_inquiry_model.dart';
import '../response_model/inquiry_res_model/get_inquiry_model.dart';
import '../response_model/inquiry_res_model/update_inquiry_model.dart';

class InquiryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<String> courseDetails = [];
  DateTime? followUpTime;
  RxString selectStatusType = ''.obs;
  List<InquiryData> threeDaysInquiryData = [];

  updateSelectStatusType(String value) {
    selectStatusType.value = value;
  }

  bool openDetails = false;
  InquiryData? inquiryData;
  String searchData = '';

  getSearchData(String value) {
    searchData = value;
    update();
  }

  updateOpenInquiry(bool value, {InquiryData? inquiryDataValue}) {
    openDetails = value;
    if (inquiryDataValue != null) {
      inquiryData = inquiryDataValue;
    }
    update();
  }

  void changeSelectedCourses(String value) {
    if (courseDetails.contains(value)) {
      courseDetails.remove(value);
      update();
    } else {
      courseDetails.add(value);
      update();
    }
  }

  ///Add Inquiry-------------------------------------------
  ApiResponse addInquiryResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addInquiryApiResponse => addInquiryResponse;

  Future addInquiry({Map<String, dynamic>? body}) async {
    addInquiryResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddInquiryModel addInquiryModel =
          await InquiryRepo().addInquiry(body: body);

      addInquiryResponse = ApiResponse.complete(addInquiryModel);
    } catch (e) {
      addInquiryResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }

  ///Get Inquiry_List-------------------------------------------
  int length = 0;
  GetInquiryModel? getInquiryModel;
  ApiResponse getInquiryResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getInquiryApiResponse => getInquiryResponse;

  Future getInquiry() async {
    print('----IN');
    getInquiryResponse = ApiResponse.loading(message: 'Loading');

    try {
      getInquiryModel = await InquiryRepo().getInquiry();

      getInquiryResponse = ApiResponse.complete(getInquiryModel);
      length = getInquiryModel!.data.length;

      threeDaysInquiryData.clear();
      for (var i = 0; i < getInquiryModel!.data.length; i++) {
        if (DateTime.parse(getInquiryModel!.data[i].inquiryDate)
            .isAfter(DateTime.now().subtract(const Duration(days: 3)))) {
          threeDaysInquiryData.add(getInquiryModel!.data[i]);
        } else {}
      }
    } catch (e) {
      getInquiryResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }

  ///Update Inquiry-------------------------------------------
  ApiResponse updateInquiryResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get updateInquiryApiResponse => updateInquiryResponse;

  Future updateInquiry({String? id, Map<String, dynamic>? body}) async {
    updateInquiryResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UpdateInquiryModel updateInquiryModel =
          await InquiryRepo().updateInquiry(body: body, id: id);

      updateInquiryResponse = ApiResponse.complete(updateInquiryModel);
    } catch (e) {
      updateInquiryResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }

  void resetValue() {
    nameController.clear();
    mobileController.clear();
    referenceController.clear();
    noteController.clear();
    selectStatusType.value = '';
    courseDetails.clear();
    update();
  }
}

class DropDownController extends GetxController {
  DateTime? followUpTime;

  updateFollowUpTime(
      BuildContext context, DateTime? firstDate, DateTime? lastDate) async {
    /// PICK DOB DATE

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: lastDate!,
        firstDate: firstDate!,
        lastDate: DateTime.now());
    if (picked != null) {
      followUpTime = picked;
    } else {
      print('------Done');
    }
    update();
  }

  RxString selectStatusType = ''.obs;

  updateSelectStatusType(String value) {
    selectStatusType.value = value;
  }

  clearValue() {
    selectStatusType.value = '';
  }
}

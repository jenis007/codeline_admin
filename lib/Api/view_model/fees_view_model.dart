import 'package:codeline_admin/Api/repo/fees_repo.dart';
import 'package:codeline_admin/Api/response_model/fees_res_model/deposit_fees_res_model.dart';
import 'package:codeline_admin/Api/response_model/fees_res_model/get_fees_history_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:number_to_words/number_to_words.dart';

import '../api_Model/api_response.dart';
import '../response_model/student__res_model/get_student_model.dart';

class FeesController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController amountNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController installmentController = TextEditingController();
  TextEditingController receiptNoController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  bool isCash = false;
  bool isBank = false;
  bool openFees = false;
  String selectMode = '';
  String selectStudentId = '';
  List<String> studentList = [];
  List<String> installmentList = [];
  DateTime? selectedDate;

  convertNumberToWord() {
    if (amountController.text.isNotEmpty) {
      amountNumberController.text =
          '${NumberToWord().convert('en-in', int.parse(amountController.text)).toUpperCase()}ONLY';
    } else {
      amountNumberController.text = '';
    }
    update();
  }

  String searchData = '';

  getSearchData(String value) {
    searchData = value;
    update();
  }

  FeesDetail? feesDetail;

  updateOpenFees(bool value, {FeesDetail? feesDataValue}) {
    openFees = value;
    if (feesDataValue != null) {
      feesDetail = feesDataValue;
    }
    update();
  }

  updateCash() {
    isCash = !isCash;
    if (isCash == true) {
      selectMode = 'CASH';
      isBank = false;
    }
    update();
  }

  updateBank() {
    isBank = !isBank;
    if (isBank == true) {
      selectMode = 'UPI';
      isCash = false;
    }
    update();
  }

  ///Get Student--------------------------------------------------------

  Future getStudent({GetStudentModel? getStudentModel}) async {
    try {
      studentList.clear();
      installmentList.clear();

      /// For Fees AUTO COMPLETE
      for (var i = 0; i < getStudentModel!.data.length; i++) {
        studentList.add(getStudentModel.data[i].name);
        installmentList.add(
            '${getStudentModel.data[i].name}..${getStudentModel.data[i].paidInstallments}..${getStudentModel.data[i].pendingFees}..${getStudentModel.data[i].id}');
      }
    } catch (e) {
      print('--->>>$e');
    }
    update();
  }

  getInstallmentNumber(String value) {
    for (int i = 0; i < studentList.length; i++) {
      String name = installmentList[i].toString().split('..').first;
      if (name.trim().toLowerCase().toString() ==
          value.trim().toLowerCase().toString()) {
        selectStudentId = installmentList[i].split('..').last;
        nameController.text = installmentList[i].split('..').first;
        amountController.text = installmentList[i].split('..')[2];
        int number = int.parse(installmentList[i].split('..')[1]);
        number++;
        installmentController.text = number.toString();
        amountNumberController.text =
            '${NumberToWord().convert('en-in', int.parse(amountController.text)).toUpperCase()}ONLY';
      }
    }
    update();
  }

  ///Add_Fees-------------------------------------------
  ApiResponse addFeesResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get addFeesApiResponse => addFeesResponse;

  Future addFees({Map<String, dynamic>? body}) async {
    addFeesResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddFeesModel addFeesModel = await FeesRepo().addFees(body: body);
      addFeesResponse = ApiResponse.complete(addFeesModel);
    } catch (e) {
      print('->>>${e}');
      addFeesResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }

  ///Get Fees-------------------------------------------
  int length = 0;
  GetFeesHistoryModel? getFeesHistoryModel;
  ApiResponse getFeesResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getFeesApiResponse => getFeesResponse;

  Future getFeesHistory() async {
    getFeesResponse = ApiResponse.loading(message: 'Loading');
    try {
      getFeesHistoryModel = await FeesRepo().getFeesHistory();
      getFeesResponse = ApiResponse.complete(getFeesHistoryModel);
      length = getFeesHistoryModel!.data.length;
    } catch (e) {
      getFeesResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }

  /// RESET VALUE
  resetAllValue() {
    nameController.clear();
    amountController.clear();
    amountNumberController.clear();
    installmentController.clear();
    receiptNoController.clear();
    isCash = false;
    isBank = false;
    selectMode = '';
    selectStudentId = '';
    update();
  }
}

import 'package:codeline_admin/Api/repo/student_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_Model/api_response.dart';
import '../response_model/student__res_model/add_student_model.dart';
import '../response_model/student__res_model/get_particular_student_model.dart';
import '../response_model/student__res_model/get_student_model.dart';
import '../response_model/student__res_model/update_student_model.dart';

class StudentController extends GetxController {
  List<String> courseDetails = [];
  String searchData = '';

  getSearchData(String value) {
    searchData = value;
    update();
  }

  void changeSelectedCourses(String value) {
    if (courseDetails.contains(value)) {
      courseDetails.remove(value);
    } else {
      courseDetails.add(value);
    }

    update();
  }

  bool openDetails = false;
  String studentId = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController parentMobileNumberController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  TextEditingController courseDurationController = TextEditingController();
  TextEditingController installmentController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  DateTime? selectedDate;
  DateTime? selectedBirthDate;
  String rollNumber = '';
  String joiningDate = '';
  String birthDate = '';

  updateOpenDetails(bool value) {
    openDetails = value;
    update();
  }

  updateStudentId(String value) {
    studentId = value;
    update();
  }

  List<PaidFee> paidFee = [];

  ///Add Student--------------------------------------------------------
  ApiResponse addStudentResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addStudentApiResponse => addStudentResponse;

  Future addStudent({Map<String, dynamic>? body}) async {
    addStudentResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddStudentModel addStudentModel =
          await StudentRepo().addStudent(body: body);

      addStudentResponse = ApiResponse.complete(addStudentModel);
    } catch (e) {
      addStudentResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }

  ///==========================================================================================

  ///Get Student--------------------------------------------------------

  GetStudentModel? getStudentModel;

  ApiResponse getStudentResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getStudentApiResponse => getStudentResponse;

  Future getStudent() async {
    getStudentResponse = ApiResponse.loading(message: 'Loading');

    try {
      getStudentModel = await StudentRepo().getStudent();
      getStudentResponse = ApiResponse.complete(getStudentModel);
    } catch (e) {
      getStudentResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }

  ///==========================================================================================

  ///Get Particular Student--------------------------------------------------------

  GetParticularStudentModel? getParticularStudentModel;

  ApiResponse getParticularStudentResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getParticularStudentApiResponse =>
      getParticularStudentResponse;

  Future getParticularStudent({String? id}) async {
    getParticularStudentResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      getParticularStudentModel =
          await StudentRepo().getParticularStudent(id: id);

      paidFee.clear();
      if (getParticularStudentModel!.data.paidFees != [] ||
          getParticularStudentModel!.data.paidFees.isNotEmpty) {
        for (var i = 0;
            i < getParticularStudentModel!.data.paidFees.length;
            i++) {
          paidFee.add(getParticularStudentModel!.data.paidFees[i]);
        }
      }
      getValueInController();
      getParticularStudentResponse =
          ApiResponse.complete(getParticularStudentModel);
    } catch (e) {
      getParticularStudentResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }

  Future getValueInController() async {
    if (getParticularStudentModel == null) {
    } else {
      nameController.text = getParticularStudentModel!.data.name;
      emailController.text = getParticularStudentModel!.data.email;
      educationController.text = getParticularStudentModel!.data.education;
      mobileNumberController.text =
          getParticularStudentModel!.data.mobileNumber;
      parentMobileNumberController.text =
          getParticularStudentModel!.data.parentMobileNumber;
      addressController.text = getParticularStudentModel!.data.address;
      courseDurationController.text =
          getParticularStudentModel!.data.courseDuration;
      installmentController.text =
          getParticularStudentModel!.data.totalInstallments.toString();
      feesController.text =
          getParticularStudentModel!.data.totalFees.toString();
      courseDetails = getParticularStudentModel!.data.courses;
      rollNumber = getParticularStudentModel!.data.rollNumber;
      joiningDate = getParticularStudentModel!.data.joiningDate;
      birthDate = getParticularStudentModel!.data.birthDate;
    }
    update();
  }

  ///==========================================================================================

  ///Update Student-------------------------------------------
  ApiResponse updateStudentResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get updateStudentApiResponse => updateStudentResponse;

  Future updateStudent({String? id, Map<String, dynamic>? body}) async {
    updateStudentResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UpdateStudentModel updateStudentModel =
          await StudentRepo().updateStudent(body: body, id: id);

      updateStudentResponse = ApiResponse.complete(updateStudentModel);
    } catch (e) {
      updateStudentResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }

  ///==========================================================================================

  void resetValue() {
    nameController.clear();
    emailController.clear();
    mobileNumberController.clear();
    parentMobileNumberController.clear();
    feesController.clear();
    courseDurationController.clear();
    installmentController.clear();
    addressController.clear();
    educationController.clear();
    selectedDate = null;
    selectedBirthDate = null;
    courseDetails.clear();
    update();
  }
}

///installment update in display screen (old)
// controllers.add(
//   [
//     TextEditingController(
//         text: getParticularStudentModel
//             .data.paidFees[i].installmentNumber
//             .toString()),
//     TextEditingController(
//         text:
//             getParticularStudentModel.data.paidFees[i].receiptNumber),
//     TextEditingController(
//         text: DateFormat('dd-MMMM-yyyy').format(DateTime.parse(
//             getParticularStudentModel.data.paidFees[i].paymentDate))),
//     TextEditingController(
//         text: getParticularStudentModel.data.paidFees[i].amount
//             .toString()),
//     TextEditingController(
//         text: getParticularStudentModel.data.paidFees[i].paymentMode),
//   ],
// );

// for (var element in controllers) {
//   paidFeesData.add({
//     "installment_no": element[0].text,
//     "receipt_no": element[1].text,
//     "installment_date": element[2].text,
//     "amount": element[3].text,
//     "paymenttype": element[4].text,
//   });
// }

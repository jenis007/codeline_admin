import 'package:codeline_admin/Api/api_Model/api_response.dart';
import 'package:codeline_admin/Api/view_model/certificate_view_model.dart';
import 'package:codeline_admin/Api/view_model/config_view_model.dart';
import 'package:codeline_admin/widget/common_button.dart';
import 'package:codeline_admin/widget/common_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Api/response_model/student__res_model/update_student_model.dart';
import '../../../Api/view_model/student_view_model.dart';
import '../../../widget/app_color.dart';
import '../../../widget/common_snackbar.dart';
import '../../../widget/common_textfield.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  StudentController studentController = Get.put(StudentController());
  ConfigController configController = Get.put(ConfigController());
  CertificateApiController certificateApiController =
      Get.put(CertificateApiController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      certificateApiController.getCertificateDetails(
          id: studentController.studentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StudentController>(
        builder: (controller) {
          if (controller.getParticularStudentModel == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            controller.updateOpenDetails(false);
                            controller.getStudent();
                            setState(() {});
                          },
                          child: const Icon(Icons.arrow_back_ios)),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Student Details',
                        style: TextStyle(
                            color: AppColor.mainColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: AppColor.grey400,
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1150),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child: InkWell(
                              //     onTap: () {
                              //       // controller.pickImage();
                              //     },
                              //     child: Container(
                              //       height: 150,
                              //       width: 150,
                              //       clipBehavior: Clip.antiAliasWithSaveLayer,
                              //       decoration: BoxDecoration(
                              //           color: AppColor.grey300,
                              //           borderRadius: BorderRadius.circular(10)),
                              //       child: Center(
                              //         child: Icon(
                              //           Icons.camera_alt_outlined,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(height: 60),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonContainer(
                                    child: Center(
                                      child: Text(
                                        'Roll  No : ${controller.rollNumber}',
                                        style: const TextStyle(
                                            letterSpacing: 3, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  CommonContainer(
                                    child: Center(
                                      child: Text(
                                        'Admission Date : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.joiningDate))}',
                                        style: const TextStyle(
                                            letterSpacing: 3, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      controller: controller.nameController,
                                      hintText: 'Name',
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: CommonTextField(
                                      validator: (value) {
                                        RegExp regex1 = RegExp(
                                            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                        if (value!.trim().isEmpty) {
                                          return '';
                                        } else if (!regex1.hasMatch(value)) {
                                          return 'please enter valid Email';
                                        }
                                        return null;
                                      },
                                      controller: controller.emailController,
                                      hintText: 'Email',
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  CommonContainer(
                                    child: Center(
                                      child: Text(
                                        'BirthDate : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.birthDate))}',
                                        style: const TextStyle(
                                            letterSpacing: 3, fontSize: 16),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 40),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      controller:
                                          controller.educationController,
                                      hintText: 'Education',
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: CommonTextField(
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'Please Enter Number';
                                        } else if (value.toString().length <
                                            10) {
                                          return 'Enter valid number';
                                        }
                                        return null;
                                      },
                                      formatter: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      controller:
                                          controller.mobileNumberController,
                                      hintText: 'Mobile No',
                                      maxLength: 10,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: CommonTextField(
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'Please Enter Number';
                                        } else if (value.toString().length <
                                            10) {
                                          return 'Enter valid number';
                                        }
                                        return null;
                                      },
                                      formatter: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      controller: controller
                                          .parentMobileNumberController,
                                      hintText: 'Parent Mobile No',
                                      maxLength: 10,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              CommonTextField(
                                controller: controller.addressController,
                                hintText: 'Address',
                                maxLines: 3,
                              ),
                              const SizedBox(height: 40),

                              Row(
                                children: List.generate(
                                  configController
                                      .configDetailsModel!.data.courses.length,
                                  (index) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                          activeColor: AppColor.mainColor,
                                          value: controller.courseDetails
                                              .contains(configController
                                                  .configDetailsModel!
                                                  .data
                                                  .courses[index]),
                                          onChanged: (value) {
                                            controller.changeSelectedCourses(
                                              configController
                                                  .configDetailsModel!
                                                  .data
                                                  .courses[index],
                                            );
                                          },
                                        ),
                                        Text(
                                          configController.configDetailsModel!
                                              .data.courses[index],
                                          style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                      ],
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 40),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      controller:
                                          controller.courseDurationController,
                                      hintText: 'Duration',
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: CommonTextField(
                                      controller:
                                          controller.installmentController,
                                      hintText: 'Installment',
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: CommonTextField(
                                      controller: controller.feesController,
                                      hintText: 'Total Fees',
                                      formatter: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 40,
                              ),

                              controller.updateStudentResponse.status
                                          .toString() ==
                                      Status.LOADING.toString()
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Center(
                                      child: CommonButton(
                                        onPressed: () async {
                                          await controller.updateStudent(
                                              id: controller
                                                  .getParticularStudentModel!
                                                  .data
                                                  .id,
                                              body: {
                                                "name": controller
                                                    .nameController.text,
                                                "email": controller
                                                    .emailController.text,
                                                "joining_date":
                                                    controller.joiningDate,
                                                "birth_date":
                                                    controller.birthDate,
                                                "education": controller
                                                    .educationController.text,
                                                "mobile_number": controller
                                                    .mobileNumberController
                                                    .text,
                                                "parent_mobile_number": controller
                                                    .parentMobileNumberController
                                                    .text,
                                                "address": controller
                                                    .addressController.text,
                                                "courses":
                                                    controller.courseDetails,
                                                "course_duration": controller
                                                    .courseDurationController
                                                    .text,
                                                "total_installments": controller
                                                    .installmentController.text,
                                                "total_fees": controller
                                                    .feesController.text,
                                                "is_course_complete": false,
                                              });
                                          if (controller
                                                  .updateStudentResponse.status
                                                  .toString() ==
                                              Status.COMPLETE.toString()) {
                                            UpdateStudentModel
                                                updateStudentModel = controller
                                                    .updateStudentResponse.data;
                                            if (updateStudentModel.success
                                                    .toString() ==
                                                'true') {
                                              controller.getStudent();
                                              // ignore: use_build_context_synchronously
                                              return CommonSnackBar
                                                  .getSuccessSnackBar(
                                                      context,
                                                      updateStudentModel
                                                          .message);
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              return CommonSnackBar
                                                  .getWarningSnackBar(
                                                      context,
                                                      updateStudentModel
                                                          .message);
                                            }
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            return CommonSnackBar
                                                .getWarningSnackBar(
                                                    context,
                                                    controller
                                                        .updateStudentResponse
                                                        .message!);
                                          }
                                        },
                                        child: const Text('Update'),
                                      ),
                                    ),

                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

import 'package:codeline_admin/Api/view_model/config_view_model.dart';
import 'package:codeline_admin/widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Api/api_Model/api_response.dart';
import '../../Api/response_model/student__res_model/add_student_model.dart';
import '../../Api/view_model/student_view_model.dart';
import '../../widget/app_color.dart';
import '../../widget/common_container.dart';
import '../../widget/common_snackbar.dart';
import '../../widget/common_textfield.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  ConfigController configController = Get.put(ConfigController());
  StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StudentController>(
        builder: (controller) {
          if (configController.configDetailsModel == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Add Student',
                    style: TextStyle(
                        color: AppColor.mainColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child: InkWell(
                              //     onTap: () {
                              //       controller.pickImage();
                              //     },
                              //     child: Container(
                              //       height: 150,
                              //       width: 150,
                              //       clipBehavior: Clip.antiAliasWithSaveLayer,
                              //       decoration: BoxDecoration(
                              //           color: AppColor.grey300,
                              //           borderRadius: BorderRadius.circular(10)),
                              //       child: controller.pickedFileBytes != null
                              //           ? Image.memory(
                              //               controller.pickedFileBytes!,
                              //               fit: BoxFit.cover,
                              //             )
                              //           : Center(
                              //               child: Icon(
                              //                 Icons.camera_alt_outlined,
                              //               ),
                              //             ),
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );
                                      if (picked != null) {
                                        controller.selectedDate = picked;
                                      }
                                      setState(() {});
                                    },
                                    child: CommonContainer(
                                      child: Center(
                                        child: Text(
                                          'Admission  Date : ${controller.selectedDate == null ? DateFormat('dd/MM/yyyy').format(DateTime.now()) : DateFormat('dd/MM/yyyy').format(controller.selectedDate!)}',
                                          style: const TextStyle(
                                              letterSpacing: 3, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      controller: controller.nameController,
                                      hintText: 'Name',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
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
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );
                                      if (picked != null) {
                                        controller.selectedBirthDate = picked;
                                      }
                                      setState(() {});
                                    },
                                    child: CommonContainer(
                                      child: Center(
                                        child: Text(
                                          ' ${controller.selectedBirthDate == null ? 'DOB ' : 'DOB : ${DateFormat('dd/MM/yyyy').format(controller.selectedBirthDate!)}'}',
                                          style: const TextStyle(
                                              letterSpacing: 3, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      controller:
                                          controller.educationController,
                                      hintText: 'Education',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: CommonTextField(
                                      formatter: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      controller:
                                          controller.mobileNumberController,
                                      hintText: 'Mobile No',
                                      maxLength: 10,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: CommonTextField(
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
                              const SizedBox(
                                height: 40,
                              ),

                              Row(
                                children: List.generate(
                                  configController
                                      .configDetailsModel!.data.courses.length,
                                  (index) => Row(
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
                                                  .courses[index]);
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
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      controller:
                                          controller.courseDurationController,
                                      hintText: 'Duration',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: CommonTextField(
                                      controller:
                                          controller.installmentController,
                                      hintText: 'Installment',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
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
                                height: 50,
                              ),
                              GetBuilder<StudentController>(
                                builder: (controller) {
                                  return Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    runSpacing: 30,
                                    spacing: 200,
                                    children: [
                                      CommonButton(
                                        onPressed: () {
                                          controller.resetValue();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      CommonButton(
                                        onPressed: () {
                                          controller.resetValue();
                                        },
                                        child: const Text('Reset'),
                                      ),
                                      controller.addStudentResponse.status
                                                  .toString() ==
                                              Status.LOADING.toString()
                                          ? const CircularProgressIndicator()
                                          : CommonButton(
                                              onPressed: () async {
                                                controller.selectedDate ??=
                                                    DateTime.now();

                                                await controller
                                                    .addStudent(body: {
                                                  "name": controller
                                                      .nameController.text,
                                                  "email": controller
                                                      .emailController.text,
                                                  "joining_date":
                                                      '${controller.selectedDate}',
                                                  "birth_date":
                                                      '${controller.selectedBirthDate}',
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
                                                  "total_installments":
                                                      controller
                                                          .installmentController
                                                          .text,
                                                  "total_fees": controller
                                                      .feesController.text,
                                                  "is_course_complete": false,
                                                });

                                                if (controller
                                                        .addStudentResponse
                                                        .status
                                                        .toString() ==
                                                    Status.COMPLETE
                                                        .toString()) {
                                                  AddStudentModel
                                                      addStudentModel =
                                                      controller
                                                          .addStudentResponse
                                                          .data;

                                                  if (addStudentModel.success
                                                          .toString() ==
                                                      'true') {
                                                    // ignore: use_build_context_synchronously
                                                    CommonSnackBar
                                                        .getSuccessSnackBar(
                                                            context,
                                                            addStudentModel
                                                                .message);

                                                    controller.resetValue();

                                                    ///for update student list
                                                    controller.getStudent();
                                                  } else {
                                                    // ignore: use_build_context_synchronously
                                                    CommonSnackBar
                                                        .getWarningSnackBar(
                                                            context,
                                                            addStudentModel
                                                                .message);
                                                  }
                                                } else {
                                                  // ignore: use_build_context_synchronously
                                                  CommonSnackBar
                                                      .getWarningSnackBar(
                                                          context,
                                                          controller
                                                              .addStudentResponse
                                                              .message!);
                                                }
                                              },
                                              child: const Text('Save'),
                                            ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

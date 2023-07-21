import 'package:codeline_admin/Api/view_model/certificate_view_model.dart';
import 'package:codeline_admin/Api/view_model/config_view_model.dart';
import 'package:codeline_admin/Api/view_model/student_view_model.dart';
import 'package:codeline_admin/widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widget/app_color.dart';
import '../../widget/common_button.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({Key? key}) : super(key: key);

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  CertificateApiController certificateApiController =
      Get.put(CertificateApiController());
  StudentController studentController = Get.put(StudentController());
  ConfigController configController = Get.put(ConfigController());

  @override
  void initState() {
    super.initState();
    certificateApiController.getStudent(
        getStudentModel: studentController.getStudentModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CertificateApiController>(
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
                    'Certificates',
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
                    child: GetBuilder<CertificateApiController>(
                      builder: (controller) {
                        return Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 900),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /// date picker
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        controller.selectedDate(context);
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: AppColor.grey400,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.selectDate == null
                                                ? DateFormat('dd/MM/yyyy')
                                                    .format(DateTime.now())
                                                : DateFormat('dd/MM/yyyy')
                                                    .format(
                                                        controller.selectDate!),
                                            style: const TextStyle(
                                                letterSpacing: 3, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),

                                  /// name and gender
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// gender
                                      Container(
                                        height: 50,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColor.grey400)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Theme(
                                          data: ThemeData(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              hint: Text(
                                                controller.genderType.isEmpty
                                                    ? "Select"
                                                    : controller.genderType,
                                                style: TextStyle(
                                                  color: AppColor.mainColor,
                                                ),
                                              ),
                                              onChanged: (val) {
                                                controller
                                                    .updateGenderType(val!);
                                                controller
                                                    .updateGenderValue(val);
                                              },
                                              items: [
                                                'Mr.',
                                                'Mrs.',
                                                'Ms.',
                                              ].map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    style: const TextStyle(),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),

                                      /// first name textField

                                      Expanded(
                                        child: Autocomplete<String>(
                                          optionsBuilder: (TextEditingValue
                                              textEditingValue) {
                                            return controller.studentList.where(
                                              (String option) {
                                                return option
                                                    .toString()
                                                    .toUpperCase()
                                                    .contains(textEditingValue
                                                        .text
                                                        .toUpperCase());
                                              },
                                            );
                                          },
                                          fieldViewBuilder: (context,
                                              textEditingController,
                                              focusNode,
                                              onFieldSubmitted) {
                                            controller.firstNameController =
                                                textEditingController;
                                            return TextField(
                                              onChanged: (val) {
                                                if (val.isEmpty) {
                                                  controller.firstNameController
                                                      .clear();
                                                  controller
                                                      .middleNameController
                                                      .clear();
                                                  controller.lastNameController
                                                      .clear();
                                                  controller.clearValue();
                                                  setState(() {});
                                                } else {}
                                              },
                                              controller: controller
                                                  .firstNameController,
                                              focusNode: focusNode,
                                              onEditingComplete:
                                                  onFieldSubmitted,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.grey400)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color: AppColor
                                                                .grey400)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color: AppColor
                                                                .grey400)),
                                                hintText: 'First Name',
                                              ),
                                            );
                                          },
                                          onSelected: (String selection) {
                                            controller.getStudentId(selection);
                                            setState(() {});
                                            debugPrint(
                                                'You just selected $selection');
                                            debugPrint(
                                                'You just selected Id ${controller.selectStudentId}');
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: CommonTextField(
                                            controller:
                                                controller.middleNameController,
                                            hintText: 'Middle Name'),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),

                                      /// last name textField

                                      Expanded(
                                        child: CommonTextField(
                                            controller:
                                                controller.lastNameController,
                                            hintText: 'Last Name'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),

                                  /// certificates type

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColor.grey400)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Theme(
                                            data: ThemeData(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                hint: Text(
                                                  controller.certificateType
                                                          .isEmpty
                                                      ? "Certificate Type"
                                                      : controller
                                                          .certificateType,
                                                  style: TextStyle(
                                                    color: AppColor.mainColor,
                                                  ),
                                                ),
                                                onChanged: (val) {
                                                  controller
                                                      .updateCertificateType(
                                                          val!);
                                                },
                                                items: configController
                                                    .configDetailsModel!
                                                    .data
                                                    .certificateType
                                                    .map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(
                                                      items,
                                                      style: const TextStyle(),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 30,
                                  ),

                                  /// other details

                                  controller.certificateType.isEmpty
                                      ? const SizedBox()
                                      : (controller.certificateType ==
                                                  'Flutter - Course Completion Certificates' ||
                                              controller.certificateType ==
                                                  'UI/UX - Course Completion Certificates' ||
                                              controller.certificateType ==
                                                  'Full Stack Web Development - Course Completion Certificates')
                                          ? Column(
                                              children: [
                                                selectDateMethods(
                                                    controller: controller),
                                                const SizedBox(
                                                  height: 30,
                                                )
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                selectDateMethods(
                                                    controller: controller),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                controller.certificateType ==
                                                        'Experience certificate'
                                                    ? CommonTextField(
                                                        controller: controller
                                                            .occupationController,
                                                        hintText: 'Occupation',
                                                      )
                                                    : controller.certificateType ==
                                                            'Internship Offer Letter'
                                                        ? Column(
                                                            children: [
                                                              CommonTextField(
                                                                controller:
                                                                    controller
                                                                        .educationController,
                                                                hintText:
                                                                    'School / College Name',
                                                              ),
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              CommonTextField(
                                                                controller:
                                                                    controller
                                                                        .descriptionController,
                                                                hintText:
                                                                    'Description',
                                                                maxLines: 2,
                                                              ),
                                                            ],
                                                          )
                                                        : Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        CommonTextField(
                                                                      controller:
                                                                          controller
                                                                              .educationController,
                                                                      hintText:
                                                                          'School / College Name',
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              50),
                                                                      child:
                                                                          CommonTextField(
                                                                        controller:
                                                                            controller.projectTitleController,
                                                                        hintText:
                                                                            'Project Title',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              CommonTextField(
                                                                controller:
                                                                    controller
                                                                        .descriptionController,
                                                                maxLines: 2,
                                                                hintText:
                                                                    'Description (optional)',
                                                              ),
                                                            ],
                                                          ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                              ],
                                            ),

                                  Center(
                                    child: CommonButton(
                                      onPressed: () {
                                        controller.addCertificatesData(context);
                                      },
                                      child: const Text('Generate'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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

  Column selectDateMethods({CertificateApiController? controller}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  controller.selectedFirstDate(context);
                },
                child: Container(
                  height: 55,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColor.grey400,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      controller!.selectFirstDate == null
                          ? controller.certificateType ==
                                  'Course Completion Certificates'
                              ? 'Select Join Date'
                              : 'Select First Date'
                          : DateFormat.yMd()
                              .format(controller.selectFirstDate!),
                      style: const TextStyle(letterSpacing: 3, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  controller.selectedLastDate(context);
                },
                child: Container(
                  height: 55,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColor.grey400,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      controller.selectLastDate == null
                          ? controller.certificateType ==
                                  'Course Completion Certificates'
                              ? 'Select Complete Date'
                              : 'Select Last Date'
                          : DateFormat.yMd().format(controller.selectLastDate!),
                      style: const TextStyle(letterSpacing: 3, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

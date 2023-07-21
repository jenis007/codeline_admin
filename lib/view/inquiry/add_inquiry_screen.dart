import 'package:codeline_admin/Api/api_Model/api_response.dart';
import 'package:codeline_admin/Api/response_model/inquiry_res_model/add_inquiry_model.dart';
import 'package:codeline_admin/Api/view_model/config_view_model.dart';
import 'package:codeline_admin/Api/view_model/inquiry_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widget/app_color.dart';
import '../../widget/common_button.dart';
import '../../widget/common_snackbar.dart';
import '../../widget/common_textfield.dart';

class AddInquiryScreen extends StatefulWidget {
  const AddInquiryScreen({Key? key}) : super(key: key);

  @override
  State<AddInquiryScreen> createState() => _AddInquiryScreenState();
}

class _AddInquiryScreenState extends State<AddInquiryScreen> {
  InquiryController inquiryController = Get.put(InquiryController());
  ConfigController configController = Get.put(ConfigController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InquiryController>(
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
                    'Add Inquiry',
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
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
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
                                      DateFormat('dd/MM/yyyy')
                                          .format(DateTime.now()),
                                      style: const TextStyle(
                                          letterSpacing: 3, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      controller: controller.nameController,
                                      hintText: 'Name',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 100,
                                  ),
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
                                      controller: controller.mobileController,
                                      hintText: 'Mobile No',
                                      maxLength: 10,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      controller:
                                          controller.referenceController,
                                      hintText: 'Reference',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
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
                                              controller.selectStatusType.value
                                                      .isEmpty
                                                  ? "Status"
                                                  : controller
                                                      .selectStatusType.value,
                                              style: TextStyle(
                                                color: AppColor.mainColor,
                                              ),
                                            ),
                                            onChanged: (val) {
                                              controller.selectStatusType
                                                  .value = val!;
                                              setState(() {});
                                            },
                                            items: configController
                                                .configDetailsModel!
                                                .data
                                                .inquiryStatus
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
                                height: 30,
                              ),
                              CommonTextField(
                                maxLines: 2,
                                controller: controller.noteController,
                                hintText: 'Note',
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
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
                                  controller.addInquiryResponse.status
                                              .toString() ==
                                          Status.LOADING.toString()
                                      ? const CircularProgressIndicator()
                                      : CommonButton(
                                          onPressed: () async {
                                            await controller.addInquiry(
                                              body: {
                                                "inquiry_date":
                                                    '${DateTime.now()}',
                                                "follow_up_date":
                                                    '${DateTime.now()}',
                                                "name": controller
                                                    .nameController.text,
                                                "mobile_number": controller
                                                    .mobileController.text,
                                                "reference": controller
                                                    .referenceController.text,
                                                "inquiry_status": controller
                                                    .selectStatusType.value,
                                                "courses":
                                                    controller.courseDetails,
                                                "note": controller
                                                    .noteController.text,
                                              },
                                            );

                                            if (controller
                                                    .addInquiryResponse.status
                                                    .toString() ==
                                                Status.COMPLETE.toString()) {
                                              AddInquiryModel addInquiryModel =
                                                  controller
                                                      .addInquiryResponse.data;

                                              if (addInquiryModel.success
                                                      .toString() ==
                                                  'true') {
                                                controller.getInquiry();
                                                // ignore: use_build_context_synchronously
                                                CommonSnackBar
                                                    .getSuccessSnackBar(
                                                        context,
                                                        addInquiryModel
                                                            .message);
                                                controller.resetValue();
                                              } else {
                                                // ignore: use_build_context_synchronously
                                                CommonSnackBar
                                                    .getWarningSnackBar(
                                                        context,
                                                        addInquiryModel
                                                            .message);
                                              }
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              CommonSnackBar.getFailedSnackBar(
                                                  context,
                                                  controller.addInquiryResponse
                                                      .message!);
                                            }
                                          },
                                          child: const Text('Save'),
                                        ),
                                ],
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

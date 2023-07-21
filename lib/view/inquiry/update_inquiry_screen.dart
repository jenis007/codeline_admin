import 'package:codeline_admin/Api/api_Model/api_response.dart';
import 'package:codeline_admin/Api/view_model/config_view_model.dart';
import 'package:codeline_admin/Api/view_model/inquiry_view_model.dart';
import 'package:codeline_admin/widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Api/response_model/inquiry_res_model/get_inquiry_model.dart';
import '../../Api/response_model/inquiry_res_model/update_inquiry_model.dart';
import '../../widget/app_color.dart';
import '../../widget/common_snackbar.dart';
import '../../widget/common_textfield.dart';

class UpdateInquiryScreen extends StatefulWidget {
  final InquiryData? inquiryData;

  const UpdateInquiryScreen({Key? key, this.inquiryData}) : super(key: key);

  @override
  State<UpdateInquiryScreen> createState() => _UpdateInquiryScreenState();
}

class _UpdateInquiryScreenState extends State<UpdateInquiryScreen> {
  InquiryController inquiryController = Get.put(InquiryController());
  DropDownController dropDownController = Get.put(DropDownController());
  ConfigController configController = Get.put(ConfigController());

  Future assignDataToController() async {
    inquiryController.nameController.text = widget.inquiryData!.name;
    inquiryController.mobileController.text = widget.inquiryData!.mobileNumber;
    inquiryController.referenceController.text = widget.inquiryData!.reference;
    inquiryController.noteController.text = widget.inquiryData!.note;
    dropDownController.followUpTime =
        DateTime.parse(widget.inquiryData!.followUpDate);
    inquiryController.courseDetails = widget.inquiryData!.courses;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    assignDataToController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InquiryController>(
        builder: (controller) {
          if (widget.inquiryData == null) {
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            controller.updateOpenInquiry(false);
                            setState(() {});
                          },
                          child: const Icon(Icons.arrow_back_ios_new)),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Edit Inquiry',
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
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 50,
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
                                            'No :  ${widget.inquiryData!.inquiryNumber}',
                                            style: const TextStyle(
                                                letterSpacing: 3, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Follow Up Date',
                                        style: TextStyle(
                                            letterSpacing: 3, fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GetBuilder<DropDownController>(
                                        builder: (controller) => InkWell(
                                          onTap: () async {
                                            await controller.updateFollowUpTime(
                                              context,
                                              DateTime.parse(widget
                                                  .inquiryData!.inquiryDate),
                                              DateTime.parse(widget
                                                  .inquiryData!.followUpDate),
                                            );
                                          },
                                          child: Container(
                                            height: 50,
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
                                                widget.inquiryData!.followUpDate
                                                        .isEmpty
                                                    ? "Select Follow Date"
                                                    : controller.followUpTime ==
                                                            null
                                                        ? DateFormat(
                                                                'dd/MM/yyyy')
                                                            .format(DateTime
                                                                .parse(widget
                                                                    .inquiryData!
                                                                    .followUpDate))
                                                        : DateFormat(
                                                                'dd/MM/yyyy')
                                                            .format(DateTime.parse(
                                                                '${controller.followUpTime}')),
                                                style: const TextStyle(
                                                    letterSpacing: 3,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Inquiry Date',
                                        style: TextStyle(
                                            letterSpacing: 3, fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 50,
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
                                            DateFormat('dd/MM/yyyy').format(
                                                DateTime.parse(widget
                                                    .inquiryData!.inquiryDate)),
                                            style: const TextStyle(
                                                letterSpacing: 3, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Obx(
                                    () => Container(
                                      height: 55,
                                      width: 600,
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
                                                  ? widget.inquiryData!
                                                      .inquiryStatus
                                                  : controller
                                                      .selectStatusType.value,
                                              style: TextStyle(
                                                color: AppColor.mainColor,
                                              ),
                                            ),
                                            onChanged: (val) {
                                              controller
                                                  .updateSelectStatusType(val!);
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
                                height: 40,
                              ),
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
                                    );
                                  },
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
                              controller.updateInquiryResponse.status
                                          .toString() ==
                                      Status.LOADING.toString()
                                  ? const CircularProgressIndicator()
                                  : CommonButton(
                                      onPressed: () async {
                                        if (controller
                                            .selectStatusType.value.isEmpty) {
                                          controller.selectStatusType.value =
                                              widget.inquiryData!.inquiryStatus;
                                        }
                                        controller.followUpTime ??=
                                            DateTime.parse(widget
                                                .inquiryData!.followUpDate);

                                        await controller.updateInquiry(
                                          id: widget.inquiryData!.id,
                                          body: {
                                            "inquiry_date": controller
                                                .inquiryData!.inquiryDate,
                                            "follow_up_date":
                                                '${dropDownController.followUpTime}',
                                            "name":
                                                controller.nameController.text,
                                            "mobile_number": controller
                                                .mobileController.text,
                                            "reference": controller
                                                .referenceController.text,
                                            "inquiry_status": controller
                                                .selectStatusType.value,
                                            "courses": controller.courseDetails,
                                            "note":
                                                controller.noteController.text,
                                          },
                                        );
                                        if (controller
                                                .updateInquiryResponse.status
                                                .toString() ==
                                            Status.COMPLETE.toString()) {
                                          UpdateInquiryModel
                                              updateInquiryModel = controller
                                                  .updateInquiryResponse.data;

                                          if (updateInquiryModel.success
                                                  .toString() ==
                                              'true') {
                                            controller.getInquiry();
                                            // ignore: use_build_context_synchronously
                                            return CommonSnackBar
                                                .getSuccessSnackBar(context,
                                                    updateInquiryModel.message);
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            return CommonSnackBar
                                                .getWarningSnackBar(context,
                                                    updateInquiryModel.message);
                                          }
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          return CommonSnackBar
                                              .getWarningSnackBar(
                                                  context,
                                                  controller
                                                      .updateInquiryResponse
                                                      .message!);
                                        }
                                      },
                                      child: const Text('Update'),
                                    ),
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

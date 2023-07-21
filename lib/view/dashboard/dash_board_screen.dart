import 'package:codeline_admin/Api/view_model/config_view_model.dart';
import 'package:codeline_admin/Api/view_model/inquiry_view_model.dart';
import 'package:codeline_admin/view/inquiry/update_inquiry_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/app_color.dart';
import '../../widget/common_textStyle.dart';
import '../../widget/header_value.dart';
import '../../widget/images_path.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ConfigController configController = Get.put(ConfigController());
  InquiryController inquiryController = Get.put(InquiryController());

  @override
  void initState() {
    super.initState();
    configController.configDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InquiryController>(
        builder: (controller) {
          if (controller.getInquiryModel == null ||
              configController.configDetailsModel == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (controller.openDetails == true) {
              return UpdateInquiryScreen(
                inquiryData: controller.inquiryData,
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<ConfigController>(
                      builder: (controller) {
                        if (controller.configDetailsModel == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Welcome Admin',
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
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  /// STUDENT
                                  Column(
                                    children: [
                                      buildDashboardImage(
                                          image: AppImages.student, index: 0),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${controller.configDetailsModel!.data.totalStudents}',
                                              style: FormTextStyle()
                                                  .k20blackWBold),
                                          Text('Total Student',
                                              style:
                                                  FormTextStyle().k18greyW400),
                                        ],
                                      ),
                                    ],
                                  ),

                                  /// INQUIRY

                                  Column(
                                    children: [
                                      buildDashboardImage(
                                          image: AppImages.work, index: 1),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${controller.configDetailsModel!.data.totalInquiries}',
                                            style:
                                                FormTextStyle().k20blackWBold,
                                          ),
                                          Text('Total Inquiry',
                                              style:
                                                  FormTextStyle().k18greyW400),
                                        ],
                                      ),
                                    ],
                                  ),

                                  /// CURRENT DEMO

                                  Column(
                                    children: [
                                      buildDashboardImage(
                                          image: AppImages.chart, index: 2),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${controller.configDetailsModel!.data.totalCurrentDemo}',
                                              style: FormTextStyle()
                                                  .k20blackWBold),
                                          Text('Current Demo',
                                              style:
                                                  FormTextStyle().k18greyW400),
                                        ],
                                      ),
                                    ],
                                  ),

                                  /// COMPLETE STUDENT
                                  Column(
                                    children: [
                                      buildDashboardImage(
                                          image: AppImages.badge, index: 3),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${controller.configDetailsModel!.data.totalCompleteStudents}',
                                              style: FormTextStyle()
                                                  .k20blackWBold),
                                          Text('Complete Student',
                                              style:
                                                  FormTextStyle().k18greyW400)
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          );
                        }
                      },
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Inquiry',
                              style: TextStyle(
                                  color: AppColor.mainColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 50,
                            color: AppColor.grey100,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'No',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                headingTitle(name: 'Name'),
                                headingTitle(name: 'Mobile No'),
                                headingTitle(name: 'Status'),
                                headingTitle(name: 'Note'),
                                headingTitle(name: 'Follow Up'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemBuilder: (context, index) {
                                if (controller.getInquiryModel!.success
                                        .toString() ==
                                    'true') {
                                  if (controller.threeDaysInquiryData.isEmpty) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${index + 1} ',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          valueData(
                                              name: controller
                                                  .threeDaysInquiryData[index]
                                                  .name),
                                          valueData(
                                              name: controller
                                                  .threeDaysInquiryData[index]
                                                  .mobileNumber),
                                          valueData(
                                              name: controller
                                                  .threeDaysInquiryData[index]
                                                  .inquiryStatus),
                                          valueData(
                                              name: controller
                                                  .threeDaysInquiryData[index]
                                                  .note),
                                          Expanded(
                                            child: Container(
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColor.mainColor),
                                                onPressed: () {
                                                  controller.updateOpenInquiry(
                                                      true,
                                                      inquiryDataValue: controller
                                                              .threeDaysInquiryData[
                                                          index]);
                                                },
                                                child: const Text('Follow Up'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  return const Text('No Inquiry');
                                }
                              },
                              itemCount: controller.threeDaysInquiryData.length,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }

  Container buildDashboardImage({String? image, int? index}) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.mainColor, width: 7),
      ),
      child: Center(
        child: Image.asset(
          image!,
          height: index == 0 ? 90 : 70,
          width: index == 0 ? 90 : 70,
        ),
      ),
    );
  }
}

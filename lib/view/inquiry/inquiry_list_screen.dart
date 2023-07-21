import 'package:codeline_admin/Api/view_model/inquiry_view_model.dart';
import 'package:codeline_admin/Api/view_model/student_view_model.dart';
import 'package:codeline_admin/view/inquiry/update_inquiry_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/app_color.dart';
import '../../widget/header_value.dart';

class InquiryScreen extends StatefulWidget {
  const InquiryScreen({Key? key}) : super(key: key);

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  InquiryController inquiryController = Get.put(InquiryController());
  StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InquiryController>(
        builder: (controller) {
          if (controller.getInquiryModel == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (controller.getInquiryModel!.data.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 250, right: 50),
                child: Center(
                  child: Text(
                    'No Inquiry Yet',
                    style: TextStyle(
                        color: AppColor.mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              );
            } else {
              if (controller.openDetails == false) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Inquiry',
                            style: TextStyle(
                                color: AppColor.mainColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Transform.rotate(
                            angle: 1.555,
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: Divider(
                                color: AppColor.blackColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: controller.searchController,
                                onChanged: (val) {
                                  controller.getSearchData(val);
                                },
                                cursorColor: AppColor.mainColor,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search,
                                      color: AppColor.grey400),
                                  hintText: 'Search here....',
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: AppColor.grey400,
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
                            return controller.getInquiryModel!.data[index].name
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                      controller.searchData.toLowerCase(),
                                    )
                                ? const Divider()
                                : const SizedBox();
                          },
                          itemBuilder: (context, index) {
                            return controller.getInquiryModel!.data[index].name
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                      controller.searchData.toLowerCase(),
                                    )
                                ? Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${controller.getInquiryModel!.data.length - index} ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        valueData(
                                            name: controller.getInquiryModel!
                                                .data[index].name),
                                        valueData(
                                            name: controller.getInquiryModel!
                                                .data[index].mobileNumber),
                                        valueData(
                                            name: controller.getInquiryModel!
                                                .data[index].inquiryStatus),
                                        valueData(
                                            name: controller.getInquiryModel!
                                                .data[index].note),
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
                                                        .getInquiryModel!
                                                        .data[index]);
                                              },
                                              child: const Text('Follow Up'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox();
                          },
                          itemCount: controller.length,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return UpdateInquiryScreen(
                  inquiryData: controller.inquiryData,
                );
              }
            }
          }
        },
      ),
    );
  }
}

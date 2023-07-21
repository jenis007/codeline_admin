import 'package:codeline_admin/Api/view_model/fees_view_model.dart';
import 'package:codeline_admin/widget/header_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/app_color.dart';
import 'installment_details_screen.dart';

class FeesHistoryScreen extends StatefulWidget {
  const FeesHistoryScreen({Key? key}) : super(key: key);

  @override
  State<FeesHistoryScreen> createState() => _FeesHistoryScreenState();
}

class _FeesHistoryScreenState extends State<FeesHistoryScreen> {
  FeesController feesController = Get.put(FeesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FeesController>(
        builder: (controller) {
          if (controller.getFeesHistoryModel == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (controller.getFeesHistoryModel!.data.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 250, right: 50),
                child: Center(
                  child: Text(
                    'No Installment Yet',
                    style: TextStyle(
                        color: AppColor.mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              );
            } else {
              if (controller.openFees == false) {
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
                            'Fees History',
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
                          ),
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
                            headingTitle(name: 'Receipt No'),
                            headingTitle(name: 'Name'),
                            headingTitle(name: 'Instalment No'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return controller.getFeesHistoryModel!.data[index]
                                    .studentName
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                      controller.searchData.toLowerCase(),
                                    )
                                ? const Divider()
                                : const SizedBox();
                          },
                          itemBuilder: (context, index) {
                            return controller.getFeesHistoryModel!.data[index]
                                    .studentName
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                      controller.searchData.toLowerCase(),
                                    )
                                ? InkWell(
                                    onTap: () {
                                      controller.updateOpenFees(true,
                                          feesDataValue: controller
                                              .getFeesHistoryModel!
                                              .data[index]);
                                    },
                                    child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${controller.getFeesHistoryModel!.data.length - index} ',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          valueData(
                                              name: controller
                                                  .getFeesHistoryModel!
                                                  .data[index]
                                                  .receiptNumber),
                                          valueData(
                                              name: controller
                                                  .getFeesHistoryModel!
                                                  .data[index]
                                                  .studentName),
                                          valueData(
                                              name:
                                                  '${controller.getFeesHistoryModel!.data[index].installmentNumber}'),
                                        ],
                                      ),
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
                return DisplayFees(
                  feesDetail: controller.feesDetail,
                );
              }
            }
          }
        },
      ),
    );
  }
}

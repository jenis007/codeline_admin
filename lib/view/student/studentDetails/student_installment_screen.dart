import 'package:codeline_admin/Api/view_model/student_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widget/app_color.dart';
import '../../../widget/header_value.dart';

class StudentInstallmentScreen extends StatefulWidget {
  const StudentInstallmentScreen({Key? key}) : super(key: key);

  @override
  State<StudentInstallmentScreen> createState() =>
      _StudentInstallmentScreenState();
}

class _StudentInstallmentScreenState extends State<StudentInstallmentScreen> {
  StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StudentController>(
        builder: (controller) {
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
                      onTap: () {},
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Installment Details',
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
                Container(
                  height: 50,
                  color: AppColor.grey100,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      headingTitle(name: 'InstallmentNo'),
                      headingTitle(name: 'ReceiptNo'),
                      headingTitle(name: 'Date'),
                      headingTitle(name: 'Amount'),
                      headingTitle(name: 'Mode'),
                    ],
                  ),
                ),
                controller.paidFee.isEmpty
                    ? Padding(
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
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                valueData(
                                    name:
                                        '${controller.paidFee[index].installmentNumber}'),
                                valueData(
                                    name: controller
                                        .paidFee[index].receiptNumber),
                                valueData(
                                  name: DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(
                                        controller.paidFee[index].paymentDate),
                                  ),
                                ),
                                valueData(
                                    name:
                                        '${controller.paidFee[index].amount}'),
                                valueData(
                                    name:
                                        controller.paidFee[index].paymentMode),
                              ],
                            ),
                          );
                        },
                        itemCount: controller.paidFee.length,
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:codeline_admin/Api/api_Model/api_response.dart';
import 'package:codeline_admin/Api/response_model/fees_res_model/deposit_fees_res_model.dart';
import 'package:codeline_admin/Api/view_model/fees_view_model.dart';
import 'package:codeline_admin/Api/view_model/student_view_model.dart';
import 'package:codeline_admin/widget/app_color.dart';
import 'package:codeline_admin/widget/common_snackbar.dart';
import 'package:codeline_admin/widget/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widget/common_textfield.dart';

class PayInstallment extends StatefulWidget {
  const PayInstallment({Key? key}) : super(key: key);

  @override
  State<PayInstallment> createState() => _PayInstallmentState();
}

class _PayInstallmentState extends State<PayInstallment> {
  FeesController feesController = Get.put(FeesController());
  StudentController studentController = Get.put(StudentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FeesController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Add Installment',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
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
                                child: Container(
                                  height: 53,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColor.grey400,
                                    ),
                                  ),
                                  child: Center(
                                    child: controller.selectedDate == null
                                        ? Text(
                                            DateFormat('dd/MM/yyyy')
                                                .format(DateTime.now()),
                                            style: const TextStyle(
                                                letterSpacing: 3, fontSize: 16),
                                          )
                                        : Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                controller.selectedDate!),
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
                            Row(
                              children: [
                                Expanded(
                                  child: CommonTextField(
                                    controller: controller.receiptNoController,
                                    hintText: 'Receipt No',
                                  ),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                Expanded(
                                  child: CommonTextField(
                                    formatter: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: controller.amountController,
                                    onChanged: (val) {
                                      controller.convertNumberToWord();
                                    },
                                    hintText: 'Amount',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CommonTextField(
                              enabled: false,
                              controller: controller.amountNumberController,
                              hintText: 'Amount in words',
                              hintTextColor: Colors.black,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Responsive.isMobile(context)
                                ? Column(
                                    children: [
                                      Expanded(
                                        child: CommonTextField(
                                          controller:
                                              controller.installmentController,
                                          hintText: 'Instalment No',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Payment Method',
                                            style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          Checkbox(
                                            activeColor: AppColor.mainColor,
                                            value: controller.isCash,
                                            onChanged: (value) {
                                              controller.updateCash();
                                            },
                                          ),
                                          Text(
                                            'Cash',
                                            style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(width: 40),
                                          Checkbox(
                                            activeColor: AppColor.mainColor,
                                            value: controller.isBank,
                                            onChanged: (value) {
                                              controller.updateBank();
                                            },
                                          ),
                                          Text(
                                            'Bank',
                                            style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        child: CommonTextField(
                                          controller:
                                              controller.installmentController,
                                          hintText: 'Instalment No',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Payment Method',
                                            style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          Checkbox(
                                            activeColor: AppColor.mainColor,
                                            value: controller.isCash,
                                            onChanged: (value) {
                                              controller.updateCash();
                                            },
                                          ),
                                          Text(
                                            'Cash',
                                            style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(width: 40),
                                          Checkbox(
                                            activeColor: AppColor.mainColor,
                                            value: controller.isBank,
                                            onChanged: (value) {
                                              controller.updateBank();
                                            },
                                          ),
                                          Text(
                                            'Bank',
                                            style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                            const SizedBox(
                              height: 70,
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runSpacing: 30,
                              spacing: 200,
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: 150,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      controller.resetAllValue();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  width: 150,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      controller.resetAllValue();
                                    },
                                    child: const Text('Reset'),
                                  ),
                                ),
                                GetBuilder<FeesController>(
                                  builder: (controller) {
                                    if (controller.addFeesResponse.status
                                            .toString() ==
                                        Status.LOADING.toString()) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return SizedBox(
                                        height: 45,
                                        width: 150,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.mainColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () async {
                                            print('---->>>>>${{
                                              "payment_date":
                                                  '${controller.selectedDate}',
                                              "amount": controller
                                                  .amountController.text,
                                              "amount_in_word": controller
                                                  .amountNumberController.text,
                                              "payment_mode":
                                                  controller.selectMode,
                                              "student_id":
                                                  studentController.studentId,
                                              "receipt_number": controller
                                                  .receiptNoController.text
                                            }}');

                                            controller.selectedDate ??=
                                                DateTime.now();
                                            await controller.addFees(body: {
                                              "payment_date":
                                                  '${controller.selectedDate}',
                                              "amount": controller
                                                  .amountController.text,
                                              "amount_in_word": controller
                                                  .amountNumberController.text,
                                              "payment_mode":
                                                  controller.selectMode,
                                              "student_id":
                                                  studentController.studentId,
                                              "receipt_number": controller
                                                  .receiptNoController.text
                                            });

                                            if (controller
                                                    .addFeesResponse.status
                                                    .toString() ==
                                                Status.COMPLETE.toString()) {
                                              AddFeesModel addFeesModel =
                                                  controller
                                                      .addFeesResponse.data;

                                              if (addFeesModel.success
                                                      .toString() ==
                                                  'true') {
                                                controller.getFeesHistory();
                                                studentController
                                                    .getParticularStudent(
                                                        id: studentController
                                                            .studentId);
                                                // ignore: use_build_context_synchronously
                                                CommonSnackBar
                                                    .getSuccessSnackBar(context,
                                                        addFeesModel.message);
                                                controller.resetAllValue();
                                              } else {
                                                // ignore: use_build_context_synchronously
                                                CommonSnackBar
                                                    .getWarningSnackBar(context,
                                                        addFeesModel.message);
                                              }
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              CommonSnackBar.getWarningSnackBar(
                                                  context,
                                                  controller.addFeesResponse
                                                      .message!);
                                            }
                                          },
                                          child: const Text('Save & Print'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

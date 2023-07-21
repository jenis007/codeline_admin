import 'package:codeline_admin/Api/api_Model/api_response.dart';
import 'package:codeline_admin/Api/view_model/fees_view_model.dart';
import 'package:codeline_admin/Api/view_model/student_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Api/response_model/fees_res_model/deposit_fees_res_model.dart';
import '../../widget/app_color.dart';
import '../../widget/common_button.dart';
import '../../widget/common_snackbar.dart';
import '../../widget/common_textfield.dart';
import '../../widget/responsive.dart';
import 'fees_print_receipt.dart';

class FeesScreen extends StatefulWidget {
  const FeesScreen({Key? key}) : super(key: key);

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  FeesController feesController = Get.put(FeesController());
  StudentController studentController = Get.put(StudentController());

  @override
  void initState() {
    feesController.getStudent(
        getStudentModel: studentController.getStudentModel);
    // TODO: implement initState
    super.initState();
  }

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
                  'Add Fees',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Container(
                                //   height: 50,
                                //   width: 250,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(10),
                                //     border: Border.all(
                                //       color: AppColor.grey400,
                                //     ),
                                //   ),
                                //   child: const Center(
                                //     child: Text(
                                //       'Receipt No : ',
                                //       style: TextStyle(
                                //           letterSpacing: 3, fontSize: 16),
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  height: 50,
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
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Autocomplete<String>(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      // if (textEditingValue.text == '') {
                                      //   return const Iterable<String>.empty();
                                      // }
                                      return controller.studentList.where(
                                        (String option) {
                                          return option
                                              .toString()
                                              .toUpperCase()
                                              .contains(textEditingValue.text
                                                  .toUpperCase());
                                        },
                                      );
                                    },
                                    fieldViewBuilder: (context,
                                        textEditingController,
                                        focusNode,
                                        onFieldSubmitted) {
                                      return TextField(
                                        onChanged: (val) {
                                          if (val.isEmpty) {
                                            controller.installmentController
                                                .clear();
                                            controller.amountNumberController
                                                .clear();
                                            controller.amountController.clear();
                                            controller.nameController.clear();
                                            // controller.nameController.text =
                                            //     val;

                                            setState(() {});
                                          } else {
                                            controller.nameController.text =
                                                val;
                                          }
                                        },
                                        onSubmitted: (val) {
                                          controller.nameController.text = val;
                                        },
                                        controller: textEditingController,
                                        focusNode: focusNode,
                                        onEditingComplete: onFieldSubmitted,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: AppColor.grey400)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: AppColor.grey400)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: AppColor.grey400)),
                                          hintText: 'Name',
                                        ),
                                      );
                                    },
                                    onSelected: (String selection) {
                                      controller
                                          .getInstallmentNumber(selection);
                                      setState(() {});
                                      debugPrint(
                                          'You just selected $selection');
                                    },
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
                                CommonButton(
                                  onPressed: () {
                                    controller.resetAllValue();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                CommonButton(
                                  onPressed: () {
                                    controller.resetAllValue();
                                  },
                                  child: const Text('Reset'),
                                ),
                                controller.addFeesResponse.status.toString() ==
                                        Status.LOADING.toString()
                                    ? const CircularProgressIndicator()
                                    : CommonButton(
                                        onPressed: () async {
                                          await controller.addFees(body: {
                                            "payment_date": '${DateTime.now()}',
                                            "amount": controller
                                                .amountController.text,
                                            "amount_in_word": controller
                                                .amountNumberController.text,
                                            "payment_mode":
                                                controller.selectMode,
                                            "student_id":
                                                controller.selectStudentId,
                                          });

                                          if (controller.addFeesResponse.status
                                                  .toString() ==
                                              Status.COMPLETE.toString()) {
                                            AddFeesModel addFeesModel =
                                                controller.addFeesResponse.data;

                                            if (addFeesModel.success
                                                    .toString() ==
                                                'true') {
                                              // ignore: use_build_context_synchronously
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PrintReceiptScreen(
                                                    name: addFeesModel
                                                        .data.studentName
                                                        .toUpperCase(),
                                                    mode: addFeesModel
                                                        .data.paymentMode,
                                                    date: addFeesModel
                                                        .data.paymentDate,
                                                    number:
                                                        '${addFeesModel.data.installmentNumber}',
                                                    receipt: addFeesModel
                                                        .data.receiptNumber,
                                                    rs: '${addFeesModel.data.amount}',
                                                    word: addFeesModel
                                                        .data.amountInWords,
                                                  ),
                                                ),
                                              );
                                              controller.getStudent();
                                              controller.getFeesHistory();
                                              controller.resetAllValue();
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              CommonSnackBar.getWarningSnackBar(
                                                  context,
                                                  addFeesModel.message);
                                            }
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            CommonSnackBar.getWarningSnackBar(
                                                context,
                                                controller
                                                    .addFeesResponse.message!);
                                          }
                                        },
                                        child: const Text('Save & Print'),
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

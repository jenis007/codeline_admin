import 'package:codeline_admin/Api/response_model/fees_res_model/get_fees_history_model.dart';
import 'package:codeline_admin/Api/view_model/fees_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widget/app_color.dart';

class DisplayFees extends StatefulWidget {
  final FeesDetail? feesDetail;
  const DisplayFees({Key? key, this.feesDetail}) : super(key: key);

  @override
  State<DisplayFees> createState() => _DisplayFeesState();
}

class _DisplayFeesState extends State<DisplayFees> {
  FeesController feesController = Get.put(FeesController());
  bool isCash = false;
  bool isBank = false;

  Future getData() async {
    if (widget.feesDetail!.paymentMode == 'CASH') {
      isCash = true;
      isBank = false;
    } else {
      isCash = false;
      isBank = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  onTap: () {
                    feesController.updateOpenFees(false);
                    setState(() {});
                  },
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Fees Details',
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
            const SizedBox(
              height: 60,
            ),
            Expanded(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 350,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColor.grey400,
                                  width: 1,
                                  style: BorderStyle.solid),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Receipt no : ${widget.feesDetail!.receiptNumber}',
                                style: const TextStyle(
                                    letterSpacing: 3, fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            height: 50,
                            width: 370,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColor.grey400,
                              ),
                            ),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Installment Date : ${DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.feesDetail!.paymentDate))}',
                                  style: const TextStyle(
                                      letterSpacing: 3, fontSize: 16),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              height: 50,
                              width: 480,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColor.grey400,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Name : ${widget.feesDetail!.studentName}',
                                  style: const TextStyle(
                                      letterSpacing: 3, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            height: 50,
                            width: 480,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColor.grey400,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Amount : ${widget.feesDetail!.amount}',
                                style: const TextStyle(
                                    letterSpacing: 3, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColor.grey400,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Words : ${widget.feesDetail!.amountInWords}',
                            style:
                                const TextStyle(letterSpacing: 3, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            height: 50,
                            width: 570,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColor.grey400,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Installment No : ${widget.feesDetail!.installmentNumber}',
                                style: const TextStyle(
                                    letterSpacing: 3, fontSize: 16),
                              ),
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
                                value: isCash,
                                onChanged: (bool? value) {},
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
                                value: isBank,
                                onChanged: (bool? value) {},
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

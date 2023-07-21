import 'dart:io';
import 'package:codeline_admin/Api/view_model/certificate_view_model.dart';
import 'package:codeline_admin/widget/app_color.dart';
import 'package:codeline_admin/widget/common_snackbar.dart';
import 'package:codeline_admin/widget/header_value.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class StudentCertificate extends StatefulWidget {
  const StudentCertificate({Key? key}) : super(key: key);

  @override
  State<StudentCertificate> createState() => _StudentCertificateState();
}

class _StudentCertificateState extends State<StudentCertificate> {
  CertificateApiController certificateApiController =
      Get.put(CertificateApiController());

  late String localPath;
  late TargetPlatform? platform;

  Future<void> prepareSaveDir() async {
    var directory = await getApplicationDocumentsDirectory();
    localPath = '${directory.path}${Platform.pathSeparator}Certificates';
    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CertificateApiController>(builder: (controller) {
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
                      onTap: () {}, child: const Icon(Icons.arrow_back_ios)),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Certificate Details',
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
                    headingTitle(name: 'No'),
                    headingTitle(name: 'CertificateType'),
                    headingTitle(name: 'Download'),
                  ],
                ),
              ),
              controller.certificateData.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 250, right: 50),
                      child: Center(
                        child: Text(
                          'No Certificate Yet',
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
                              valueData(name: '${index + 1}'),
                              valueData(
                                  name:
                                      '${controller.certificateData[index].type}'),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.mainColor),
                                    onPressed: () async {
                                      await prepareSaveDir();
                                      try {
                                        await Dio().download(
                                            "${controller.certificateData[index].certificateLink}",
                                            "$localPath/${controller.certificateData[index].studentName}_${controller.certificateData[index].type}.pdf");
                                        // ignore: use_build_context_synchronously
                                        return CommonSnackBar
                                            .getSuccessSnackBar(context,
                                                'File Downloaded Successfully');
                                      } catch (e) {
                                        // ignore: use_build_context_synchronously
                                        return CommonSnackBar.getFailedSnackBar(
                                            context, 'Download Failed');
                                      }
                                    },
                                    child: const Text('Download'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: controller.certificateData.length,
                    )
            ],
          ),
        );
      }),
    );
  }
}

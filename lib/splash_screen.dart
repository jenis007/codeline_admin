import 'dart:async';

import 'package:codeline_admin/Api/view_model/student_view_model.dart';
import 'package:codeline_admin/dashboard_panel/drawer_dashboard_panel.dart';
import 'package:codeline_admin/widget/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Api/view_model/config_view_model.dart';
import 'Api/view_model/fees_view_model.dart';
import 'Api/view_model/inquiry_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();
  ConfigController configController = Get.put(ConfigController());
  InquiryController inquiryController = Get.put(InquiryController());
  StudentController studentController = Get.put(StudentController());
  FeesController feesController = Get.put(FeesController());

  @override
  void initState() {
    super.initState();
    configController.configDetails();
    inquiryController.getInquiry();
    studentController.getStudent();
    feesController.getFeesHistory();

    Timer(const Duration(seconds: 3), () {
      Get.to(
        () => const HomePage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.logo,
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}

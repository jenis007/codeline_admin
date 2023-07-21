import 'package:codeline_admin/Api/view_model/certificate_view_model.dart';
import 'package:codeline_admin/Api/view_model/fees_view_model.dart';
import 'package:codeline_admin/Api/view_model/inquiry_view_model.dart';
import 'package:codeline_admin/Api/view_model/student_view_model.dart';
import 'package:codeline_admin/dashboard_panel/dashboard_pannel.dart';
import 'package:codeline_admin/view/student/add_student_screen.dart';
import 'package:codeline_admin/view/student/student_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/certificates/certificates_screen.dart';
import '../view/dashboard/dash_board_screen.dart';
import '../view/fees/add_fees_Screen.dart';
import '../view/fees/fees_list_screen.dart';
import '../view/inquiry/add_inquiry_screen.dart';
import '../view/inquiry/inquiry_list_screen.dart';
import '../widget/app_bar.dart';
import '../widget/app_color.dart';
import '../widget/responsive.dart';
import 'dashboard_controller.dart';
import 'dashboard_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DashBoardController dashBoardController = Get.put(DashBoardController());
  StudentController studentController = Get.put(StudentController());
  InquiryController inquiryController = Get.put(InquiryController());
  FeesController feesController = Get.put(FeesController());
  CertificateApiController certificateApiController =
      Get.put(CertificateApiController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.bgColor,
      appBar: customAppBar(
          context: context,
          onPress: () {
            _scaffoldKey.currentState!.openDrawer();
          }),
      drawer: Responsive.isMobile(context)
          ? DashBoardPanel(
              drawerKey: _scaffoldKey,
              studentController: studentController,
              inquiryController: inquiryController,
              feesController: feesController,
              certificateApiController: certificateApiController,
            )
          : const SizedBox(),
      body: Row(
        children: [
          Responsive.isMobile(context)
              ? const SizedBox()
              : DashBoardPanel(
                  drawerKey: _scaffoldKey,
                  studentController: studentController,
                  inquiryController: inquiryController,
                  feesController: feesController,
                  certificateApiController: certificateApiController,
                ),
          Obx(
            () {
              return Expanded(
                child: dashBoardController.currentScreen.value ==
                        DashBoardPanelScreens.dashboard
                    ? const DashboardScreen()
                    : dashBoardController.currentScreen.value ==
                            DashBoardPanelScreens.studentList
                        ? const StudentListScreen()
                        : dashBoardController.currentScreen.value ==
                                DashBoardPanelScreens.inquiryList
                            ? const InquiryScreen()
                            : dashBoardController.currentScreen.value ==
                                    DashBoardPanelScreens.addStudent
                                ? const AddStudentScreen()
                                : dashBoardController.currentScreen.value ==
                                        DashBoardPanelScreens.fees
                                    ? const FeesScreen()
                                    : dashBoardController.currentScreen.value ==
                                            DashBoardPanelScreens.addInquiry
                                        ? const AddInquiryScreen()
                                        : dashBoardController
                                                    .currentScreen.value ==
                                                DashBoardPanelScreens
                                                    .feesHistory
                                            ? const FeesHistoryScreen()
                                            : const CertificateScreen(),
              );
            },
          )
        ],
      ),
    );
  }
}

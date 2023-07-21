import 'package:codeline_admin/Api/view_model/student_view_model.dart';
import 'package:codeline_admin/view/student/studentDetails/pay_installment_screen.dart';
import 'package:codeline_admin/view/student/studentDetails/student_certificate_screen.dart';
import 'package:codeline_admin/view/student/studentDetails/update_student_screen.dart';
import 'package:codeline_admin/view/student/student_panel/stud_dashboard_controller.dart';
import 'package:codeline_admin/view/student/student_panel/stud_dashboard_pannel.dart';
import 'package:codeline_admin/view/student/student_panel/student_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/app_color.dart';
import '../../../widget/responsive.dart';
import '../studentDetails/student_installment_screen.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({Key? key}) : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StudentDashboardController studentDashboardController =
      Get.put(StudentDashboardController());
  StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.bgColor,
      // drawer: Responsive.isMobile(context)
      //     ? DashBoardPanel(
      //   drawerKey: _scaffoldKey,
      //   studentController: studentController,
      //   inquiryController: inquiryController,
      //   feesController: feesController,
      // )
      //     : const SizedBox(),
      body: Row(
        children: [
          Responsive.isMobile(context)
              ? const SizedBox()
              : StudentDashboardPanel(
                  drawerKey: _scaffoldKey,
                  studentController: studentController,
                ),
          Obx(
            () {
              return Expanded(
                child: studentDashboardController.currentScreen.value ==
                        StudentDashBoardPanelScreens.studentDetails
                    ? const StudentDetailsScreen()
                    : studentDashboardController.currentScreen.value ==
                            StudentDashBoardPanelScreens.certificateDetails
                        ? const StudentCertificate()
                        : studentDashboardController.currentScreen.value ==
                                StudentDashBoardPanelScreens.installmentDetails
                            ? const StudentInstallmentScreen()
                            : const PayInstallment(),
              );
            },
          )
        ],
      ),
    );
  }
}

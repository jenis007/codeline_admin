import 'package:codeline_admin/view/student/student_panel/stud_dashboard_controller.dart';
import 'package:codeline_admin/view/student/student_panel/student_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Api/view_model/student_view_model.dart';
import '../../../widget/app_color.dart';
import '../../../widget/tiles.dart';

class StudentDashboardPanel extends StatelessWidget {
  final drawerKey;
  final StudentController studentController;

  const StudentDashboardPanel(
      {Key? key, this.drawerKey, required this.studentController})
      : super(key: key);

  /// update __icon__ and __text__ color when button is pressed in
  /// dashboard panel
  ///
  /// default color white
  Color _updateColor(Rx<StudentDashBoardPanelScreens> currentScreen,
      StudentDashBoardPanelScreens studentDashBoardPanelScreens, bool hover,
      {required BuildContext context}) {
    if (currentScreen.value == studentDashBoardPanelScreens || hover == true) {
      return AppColor.whiteColor;
    }
    return AppColor.mainColor;
  }

  final double iconHeight = 22;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: Get.height,
      color: AppColor.whiteColor,
      child: GetX<StudentDashboardController>(
        init: StudentDashboardController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),

              /// 0 Student Details
              MouseRegion(
                onEnter: (e) {
                  controller.updateHover(true);
                },
                onExit: (e) {
                  controller.updateHover(false);
                },
                child: Container(
                  width: 180,
                  height: 45,
                  margin: const EdgeInsets.only(right: 20, bottom: 5),
                  decoration: BoxDecoration(
                    color: controller.currentScreen.value ==
                            StudentDashBoardPanelScreens.studentDetails
                        ? AppColor.mainColor.withOpacity(0.9)
                        : controller.hover.value == true
                            ? AppColor.mainColor.withAlpha(100)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: CustomTile(
                    textColor: _updateColor(
                        controller.currentScreen,
                        StudentDashBoardPanelScreens.studentDetails,
                        controller.hover.value,
                        context: context),
                    titleMessage: "Student Details",
                    onTap: () {
                      controller.currentScreen.value =
                          StudentDashBoardPanelScreens.studentDetails;
                      drawerKey.currentState!.closeDrawer();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              /// 1 Certificate Details
              MouseRegion(
                onEnter: (e) {
                  controller.updateHover1(true);
                },
                onExit: (e) {
                  controller.updateHover1(false);
                },
                child: Container(
                  width: 180,
                  height: 45,
                  margin: const EdgeInsets.only(right: 20, bottom: 5),
                  decoration: BoxDecoration(
                    color: controller.currentScreen.value ==
                            StudentDashBoardPanelScreens.certificateDetails
                        ? AppColor.mainColor.withOpacity(0.9)
                        : controller.hover1.value == true
                            ? AppColor.mainColor.withAlpha(100)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: CustomTile(
                    textColor: _updateColor(
                        controller.currentScreen,
                        StudentDashBoardPanelScreens.certificateDetails,
                        controller.hover1.value,
                        context: context),
                    titleMessage: "Certificate Details",
                    onTap: () {
                      controller.currentScreen.value =
                          StudentDashBoardPanelScreens.certificateDetails;

                      drawerKey.currentState!.closeDrawer();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              /// 2 Installment Details
              MouseRegion(
                onEnter: (e) {
                  controller.updateHover2(true);
                },
                onExit: (e) {
                  controller.updateHover2(false);
                },
                child: Container(
                  width: 180,
                  height: 45,
                  margin: const EdgeInsets.only(right: 20, bottom: 5),
                  decoration: BoxDecoration(
                    color: controller.currentScreen.value ==
                            StudentDashBoardPanelScreens.installmentDetails
                        ? AppColor.mainColor.withOpacity(0.9)
                        : controller.hover2.value == true
                            ? AppColor.mainColor.withAlpha(100)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: CustomTile(
                    textColor: _updateColor(
                        controller.currentScreen,
                        StudentDashBoardPanelScreens.installmentDetails,
                        controller.hover2.value,
                        context: context),
                    titleMessage: "Installment Details",
                    onTap: () {
                      controller.currentScreen.value =
                          StudentDashBoardPanelScreens.installmentDetails;
                      drawerKey.currentState!.closeDrawer();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              /// 3  Add Installment
              MouseRegion(
                onEnter: (e) {
                  controller.updateHover3(true);
                },
                onExit: (e) {
                  controller.updateHover3(false);
                },
                child: Container(
                  width: 180,
                  height: 45,
                  margin: const EdgeInsets.only(right: 20, bottom: 5),
                  decoration: BoxDecoration(
                    color: controller.currentScreen.value ==
                            StudentDashBoardPanelScreens.addInstallment
                        ? AppColor.mainColor.withOpacity(0.9)
                        : controller.hover3.value == true
                            ? AppColor.mainColor.withAlpha(100)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: CustomTile(
                    textColor: _updateColor(
                        controller.currentScreen,
                        StudentDashBoardPanelScreens.addInstallment,
                        controller.hover3.value,
                        context: context),
                    titleMessage: "Add Installment",
                    onTap: () {
                      controller.currentScreen.value =
                          StudentDashBoardPanelScreens.addInstallment;
                      drawerKey.currentState!.closeDrawer();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}

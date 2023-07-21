// ignore_for_file: library_prefixes
import 'package:codeline_admin/view/student/student_panel/student_dashboard_screen.dart';
import 'package:get/get.dart';

class StudentDashboardController extends GetxController {
  Rx<StudentDashBoardPanelScreens> currentScreen =
      StudentDashBoardPanelScreens.studentDetails.obs;

  var hover = false.obs;
  var hover1 = false.obs;
  var hover2 = false.obs;
  var hover3 = false.obs;

  updateHover(bool val) {
    hover.value = val;
    update();
  }

  updateHover1(bool val) {
    hover1.value = val;
    update();
  }

  updateHover2(bool val) {
    hover2.value = val;
    update();
  }

  updateHover3(bool val) {
    hover3.value = val;
    update();
  }
}

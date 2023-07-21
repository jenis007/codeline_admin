import 'package:codeline_admin/view/student/student_panel/stud_dashboard_controller.dart';
import 'package:codeline_admin/view/student/student_panel/student_dashboard_panel.dart';
import 'package:codeline_admin/view/student/student_panel/student_dashboard_screen.dart';
import 'package:codeline_admin/widget/app_color.dart';
import 'package:codeline_admin/widget/header_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api/view_model/student_view_model.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  TextEditingController searchController = TextEditingController();
  StudentController studentController = Get.put(StudentController());
  StudentDashboardController studentDashboardController =
      Get.put(StudentDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StudentController>(
        builder: (controller) {
          if (controller.getStudentModel == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (controller.getStudentModel!.data.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 250, right: 50),
                child: Center(
                  child: Text(
                    'No Student Yet',
                    style: TextStyle(
                        color: AppColor.mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              );
            } else {
              if (controller.openDetails == false) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Students',
                            style: TextStyle(
                                color: AppColor.mainColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Transform.rotate(
                            angle: 1.555,
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: Divider(
                                color: AppColor.blackColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: searchController,
                                onChanged: (val) {
                                  controller.getSearchData(val);
                                },
                                cursorColor: AppColor.mainColor,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search,
                                      color: AppColor.grey400),
                                  hintText: 'Search here....',
                                ),
                              ),
                            ),
                          )
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
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'No',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            headingTitle(name: 'Roll No'),
                            headingTitle(name: 'Name'),
                            headingTitle(name: 'Instalment No'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return controller.getStudentModel!.data[index].name
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                      controller.searchData.toLowerCase(),
                                    )
                                ? const Divider()
                                : const SizedBox();
                          },
                          itemBuilder: (context, index) {
                            return controller.getStudentModel!.data[index].name
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                      controller.searchData.toLowerCase(),
                                    )
                                ? InkWell(
                                    onTap: () {
                                      controller.updateStudentId(controller
                                          .getStudentModel!.data[index].id);

                                      ///particular function call-----
                                      controller.getParticularStudent(
                                          id: controller
                                              .getStudentModel!.data[index].id);

                                      controller.updateOpenDetails(true);
                                      studentDashboardController
                                              .currentScreen.value =
                                          StudentDashBoardPanelScreens
                                              .studentDetails;
                                    },
                                    child: SizedBox(
                                      height: 50,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${controller.getStudentModel!.data.length - index} ',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          valueData(
                                              name: controller.getStudentModel!
                                                  .data[index].rollNumber),
                                          valueData(
                                              name: controller.getStudentModel!
                                                  .data[index].name),
                                          valueData(
                                              name:
                                                  '${int.parse('${controller.getStudentModel!.data[index].totalInstallments}')}'),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox();
                          },
                          itemCount: controller.getStudentModel!.data.length,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const StudentDetails();
              }
            }
          }
        },
      ),
    );
  }
}

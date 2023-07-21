// import 'package:firedart/firedart.dart';
// import 'package:flutter/material.dart';
//
// import '../../../controller/inquiry_controller.dart';
// import '../../../widget/app_color.dart';
// import 'header_value.dart';
//
// class StudentData extends StatelessWidget {
//   final InquiryController controller;
//   const StudentData({
//     super.key,
//     required this.controller,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: FutureBuilder(
//         future: controller.getStudentList(),
//         builder:
//             (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             DateTime todayDate = DateTime.now();
//             DateTime threeDayAgoTime = todayDate.subtract(Duration(days: 3));
//             var inquiryListData = snapshot.data;
//
//             return ListView.builder(
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           '${index + 1}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                         value(name: '${inquiryListData![index]['name']}'),
//                         value(name: ' ${inquiryListData[index]['emailId']}'),
//                         value(
//                           name: ' ${inquiryListData[index]['dob']}',
//                         ),
//                         value(name: '${inquiryListData[index]['mobile']}'),
//                       ],
//                     ),
//                     Divider()
//                   ],
//                 );
//               },
//               itemCount: snapshot.data!.length,
//             );
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: AppColor.mainColor,
//               ),
//             );
//           } else {
//             return Text(
//               'Try Again',
//               style: TextStyle(
//                   color: AppColor.mainColor,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
// class InquiryData extends StatelessWidget {
//   final InquiryController controller;
//   final List data;
//
//   const InquiryData({Key? key, required this.controller, required this.data})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: FutureBuilder(
//         future: controller.getInquiryList(),
//         builder:
//             (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             DateTime todayDate = DateTime.now();
//             DateTime threeDayAgoTime = todayDate.subtract(Duration(days: 3));
//             var inquiryListData = snapshot.data;
//
//             return ListView.builder(
//               itemBuilder: (context, index) {
//                 if (threeDayAgoTime
//                     .isBefore(inquiryListData![index]['followUpdate'])) {
//                   if (!data.contains(inquiryListData[index]['name'])) {
//                     data.add(inquiryListData[index]['name']);
//                   }
//                 }
//                 var status =
//                     inquiryListData[index]['status'].toString().toLowerCase();
//                 return threeDayAgoTime
//                         .isBefore(inquiryListData[index]['followUpdate'])
//                     ? Column(
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 '${data.indexOf(inquiryListData[index]['name']) + 1}',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                               value(name: '${inquiryListData[index]['name']}'),
//                               value(
//                                   name: ' ${inquiryListData[index]['mobile']}'),
//                               value(
//                                 name: ' ${inquiryListData[index]['status']}',
//                                 color: status == 'Follow Up'.toLowerCase()
//                                     ? AppColor.blueColor
//                                     : status == 'Demo Started'.toLowerCase()
//                                         ? AppColor.yellowColor
//                                         : status == 'Joined'.toLowerCase()
//                                             ? AppColor.greenColor
//                                             : AppColor.redColor,
//                               ),
//                               value(name: '${inquiryListData[index]['note']}'),
//                               Container(
//                                 height: 50,
//                                 width: 200,
//                                 alignment: Alignment.center,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                       backgroundColor: AppColor.mainColor),
//                                   onPressed: () {
//                                     controller.updateStudentId(
//                                         inquiryListData[index].id);
//
//                                     controller.updateOpenInquiry(true);
//                                   },
//                                   child: Text('Follow Up'),
//                                 ),
//                               ),
//                               Container(width: 50, color: AppColor.grey100)
//                             ],
//                           ),
//                           Divider()
//                         ],
//                       )
//                     : SizedBox();
//               },
//               itemCount: snapshot.data!.length,
//             );
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: AppColor.mainColor,
//               ),
//             );
//           } else {
//             return Text(
//               'Try Again',
//               style: TextStyle(
//                   color: AppColor.mainColor,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

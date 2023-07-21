// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
//
// import '../../widget/app_color.dart';
//
// class PrintCertificatesScreen extends StatefulWidget {
//   const PrintCertificatesScreen({
//     Key? key,
//     this.gender,
//     this.firstName,
//     this.lastName,
//     this.certificatesType,
//     this.occupation,
//     this.collegeName,
//     this.description,
//     this.selectDate,
//     this.firstDate,
//     this.lastDate,
//     this.middleName,
//   }) : super(key: key);
//
//   final String? gender;
//   final String? firstName;
//   final String? middleName;
//   final String? lastName;
//   final String? certificatesType;
//   final DateTime? selectDate;
//   final DateTime? firstDate;
//   final DateTime? lastDate;
//   final String? occupation;
//   final String? collegeName;
//   final String? description;
//
//   @override
//   State<PrintCertificatesScreen> createState() =>
//       _PrintCertificatesScreenState();
// }
//
// class _PrintCertificatesScreenState extends State<PrintCertificatesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColor.mainColor,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: const Text('Certificates'),
//       ),
//       body: PdfPreview(
//         build: (format) => generatePdf('Certificates'),
//       ),
//     );
//   }
//
//   Future<Uint8List> generatePdf(String title) async {
//     final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
//
//     final font = await PdfGoogleFonts.calligraffittiRegular();
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (context) {
//           return pw.Column(
//             children: [
//               pw.Expanded(child: certificateContent(font)),
//             ],
//           );
//         },
//       ),
//     );
//     return pdf.save();
//   }
//
//   pw.Container certificateContent(pw.Font font) {
//     print('${Get.height}');
//     return pw.Container(
//       child:
//
//           ///'Experience certificate'---------------------------------------------------------------------
//           widget.certificatesType == 'Experience certificate'
//               ? pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.SizedBox(
//                       height: 40,
//                     ),
//                     pw.Align(
//                       alignment: pw.Alignment.topRight,
//                       child: pw.RichText(
//                         text: pw.TextSpan(
//                           text: 'Date: ',
//                           style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                           children: [
//                             pw.TextSpan(
//                               text: DateFormat('dd/MM/yyyy')
//                                   .format(widget.selectDate!),
//                               style: pw.TextStyle(
//                                   fontWeight: pw.FontWeight.normal,
//                                   fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     pw.SizedBox(
//                       height: 50,
//                     ),
//                     pw.Align(
//                       alignment: pw.Alignment.center,
//                       child: pw.Text('${widget.certificatesType}',
//                           style: pw.TextStyle(
//                             fontSize: 22,
//                             fontWeight: pw.FontWeight.bold,
//                           )),
//                     ),
//                     pw.SizedBox(
//                       height: 40,
//                     ),
//                     pw.Text(
//                       'TO WHOM IT MAY CONCERN,',
//                       textAlign: pw.TextAlign.justify,
//                       style: pw.TextStyle(
//                         fontSize: 12,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                     pw.SizedBox(height: 10),
//                     pw.RichText(
//                       textAlign: pw.TextAlign.justify,
//                       text: pw.TextSpan(
//                         text: 'This is to certify that ',
//                         style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.normal, fontSize: 12),
//                         children: [
//                           pw.TextSpan(
//                             text:
//                                 '${widget.gender} ${widget.firstName.toString().capitalizeFirst} ${widget.lastName.toString().capitalizeFirst} ',
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold, fontSize: 12),
//                           ),
//                           pw.TextSpan(
//                             text:
//                                 'was an employee of Codeline Infotech from ${DateFormat('d MMMM y').format(widget.firstDate!)} to ${DateFormat('d MMMM y').format(widget.lastDate!)} as a Flutter developer.',
//                             style: const pw.TextStyle(fontSize: 11.5),
//                           ),
//                         ],
//                       ),
//                     ),
//                     pw.SizedBox(height: 10),
//                     pw.Text(
//                       textAlign: pw.TextAlign.justify,
//                       '${widget.gender} ${widget.firstName} ${widget.lastName} was appointed on a full-time (40 hrs. per week) paid basis in Technology Department at Surat. ${widget.gender} ${widget.firstName} ${widget.lastName} has performed the following duties during his employment with us.',
//                       style: const pw.TextStyle(fontSize: 11.5),
//                     ),
//                     pw.SizedBox(height: 10),
//                     pw.Padding(
//                       padding: const pw.EdgeInsets.only(left: 20, right: 30),
//                       child: pw.Container(
//                         child: pw.Column(
//                           children: [
//                             pw.Row(
//                               children: [
//                                 pw.Container(
//                                   height: 5,
//                                   width: 5,
//                                   decoration: const pw.BoxDecoration(
//                                     color: PdfColors.black,
//                                     shape: pw.BoxShape.circle,
//                                   ),
//                                 ),
//                                 pw.SizedBox(width: 10),
//                                 pw.Text(
//                                     'Develop Mobile Application Software using Flutter and related Mobile technologies.',
//                                     textAlign: pw.TextAlign.justify,
//                                     style: const pw.TextStyle(fontSize: 11.5))
//                               ],
//                             ),
//                             pw.SizedBox(height: 3),
//                             pw.Row(
//                               mainAxisAlignment: pw.MainAxisAlignment.start,
//                               children: [
//                                 pw.Container(
//                                   height: 5,
//                                   width: 5,
//                                   decoration: const pw.BoxDecoration(
//                                     color: PdfColors.black,
//                                     shape: pw.BoxShape.circle,
//                                   ),
//                                 ),
//                                 pw.SizedBox(width: 10),
//                                 pw.Text(
//                                     'Responsible for maintaining and handling the Firebase database.',
//                                     textAlign: pw.TextAlign.justify,
//                                     style: const pw.TextStyle(fontSize: 11.5))
//                               ],
//                             ),
//                             pw.SizedBox(height: 5),
//                             pw.Row(
//                               children: [
//                                 pw.Padding(
//                                   padding: const pw.EdgeInsets.only(bottom: 15),
//                                   child: pw.Container(
//                                     height: 5,
//                                     width: 5,
//                                     decoration: const pw.BoxDecoration(
//                                       color: PdfColors.black,
//                                       shape: pw.BoxShape.circle,
//                                     ),
//                                   ),
//                                 ),
//                                 pw.SizedBox(width: 10),
//                                 pw.Text(
//                                     'Responsible for documentation of code, processes, and other feature specification\ndocuments. ',
//                                     textAlign: pw.TextAlign.justify,
//                                     style: const pw.TextStyle(fontSize: 11.5))
//                               ],
//                             ),
//                             pw.SizedBox(height: 5),
//                             pw.Row(
//                               children: [
//                                 pw.Container(
//                                   height: 5,
//                                   width: 5,
//                                   decoration: const pw.BoxDecoration(
//                                     color: PdfColors.black,
//                                     shape: pw.BoxShape.circle,
//                                   ),
//                                 ),
//                                 pw.SizedBox(width: 10),
//                                 pw.Text(
//                                     'Analyzing & resolving technical problems to ensure business continuity',
//                                     textAlign: pw.TextAlign.justify,
//                                     style: const pw.TextStyle(fontSize: 11.5))
//                               ],
//                             ),
//                             pw.SizedBox(height: 5),
//                             pw.Row(
//                               children: [
//                                 pw.Padding(
//                                   padding: const pw.EdgeInsets.only(bottom: 15),
//                                   child: pw.Container(
//                                     height: 5,
//                                     width: 5,
//                                     decoration: const pw.BoxDecoration(
//                                       color: PdfColors.black,
//                                       shape: pw.BoxShape.circle,
//                                     ),
//                                   ),
//                                 ),
//                                 pw.SizedBox(width: 10),
//                                 pw.Text(
//                                     'Responsible for communicating with team and support staff regarding programming \nneeds and performance',
//                                     textAlign: pw.TextAlign.justify,
//                                     style: const pw.TextStyle(fontSize: 11.5))
//                               ],
//                             ),
//                             pw.SizedBox(height: 5),
//                             pw.Row(
//                               children: [
//                                 pw.Padding(
//                                   padding: const pw.EdgeInsets.only(bottom: 15),
//                                   child: pw.Container(
//                                     height: 5,
//                                     width: 5,
//                                     decoration: const pw.BoxDecoration(
//                                       color: PdfColors.black,
//                                       shape: pw.BoxShape.circle,
//                                     ),
//                                   ),
//                                 ),
//                                 pw.SizedBox(width: 10),
//                                 pw.Text(
//                                     'Testing new programs to ensure that logic and syntax are correct, and that program\nresults are accurate',
//                                     textAlign: pw.TextAlign.justify,
//                                     style: const pw.TextStyle(fontSize: 11.5))
//                               ],
//                             ),
//                             pw.SizedBox(height: 5),
//                             pw.Row(
//                               children: [
//                                 pw.Container(
//                                   height: 5,
//                                   width: 5,
//                                   decoration: const pw.BoxDecoration(
//                                     color: PdfColors.black,
//                                     shape: pw.BoxShape.circle,
//                                   ),
//                                 ),
//                                 pw.SizedBox(width: 10),
//                                 pw.Text(
//                                     'Assist junior-level programmers with programming assignments and mentoring them.',
//                                     textAlign: pw.TextAlign.justify,
//                                     style: const pw.TextStyle(fontSize: 11.5))
//                               ],
//                             ),
//                             pw.SizedBox(height: 5),
//                             pw.Row(
//                               children: [
//                                 pw.Padding(
//                                   padding: const pw.EdgeInsets.only(bottom: 15),
//                                   child: pw.Container(
//                                     height: 5,
//                                     width: 5,
//                                     decoration: const pw.BoxDecoration(
//                                       color: PdfColors.black,
//                                       shape: pw.BoxShape.circle,
//                                     ),
//                                   ),
//                                 ),
//                                 pw.SizedBox(width: 10),
//                                 pw.Text(
//                                     'Deal with offshore customers to resolve technical problems and understand their\nrequirements.',
//                                     textAlign: pw.TextAlign.justify,
//                                     style: const pw.TextStyle(fontSize: 11.5))
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     pw.SizedBox(height: 10),
//                     pw.Text(
//                       '${widget.firstName} has been sincere, hardworking, and punctual about meeting the project schedule and deadlines.',
//                       textAlign: pw.TextAlign.justify,
//                       style: const pw.TextStyle(fontSize: 11.5),
//                     ),
//                     pw.SizedBox(height: 10),
//                     pw.Text(
//                       'Please feel free to contact me if you have any questions regarding ${widget.gender} ${widget.firstName} ${widget.lastName} employment with us.',
//                       textAlign: pw.TextAlign.justify,
//                       style: const pw.TextStyle(fontSize: 11.5),
//                     ),
//                     pw.SizedBox(height: 20),
//                     pw.Text(
//                       'CODELINE INFOTECH LLP',
//                       textAlign: pw.TextAlign.justify,
//                       style: pw.TextStyle(
//                           fontSize: 11.5, fontWeight: pw.FontWeight.bold),
//                     ),
//                     pw.SizedBox(height: 60),
//                     pw.Text(
//                       'Authorized Signature',
//                       textAlign: pw.TextAlign.justify,
//                       style: const pw.TextStyle(fontSize: 11.5),
//                     )
//                   ],
//                 )
//               : widget.certificatesType == 'Course Completion Certificates'
//                   ?
//
//                   ///'Course Completion Certificates'---------------------------------------------------------------------
//                   pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.SizedBox(
//                           height: 50,
//                         ),
//                         pw.Align(
//                           alignment: pw.Alignment.topRight,
//                           child: pw.RichText(
//                             text: pw.TextSpan(
//                               text: 'Date: ',
//                               style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                               children: [
//                                 pw.TextSpan(
//                                   text: DateFormat('dd/MM/yyyy')
//                                       .format(widget.selectDate!),
//                                   style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.normal,
//                                       fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         pw.SizedBox(
//                           height: 80,
//                         ),
//                         pw.Align(
//                           alignment: pw.Alignment.center,
//                           child: pw.Text('${widget.certificatesType}',
//                               style: pw.TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: pw.FontWeight.bold,
//                               )),
//                         ),
//                         pw.SizedBox(
//                           height: 50,
//                         ),
//                         pw.Text(
//                           'TO WHOM IT MAY CONCERN,',
//                           textAlign: pw.TextAlign.justify,
//                           style: pw.TextStyle(
//                             fontSize: 12,
//                             fontWeight: pw.FontWeight.bold,
//                           ),
//                         ),
//                         pw.SizedBox(height: 40),
//                         pw.RichText(
//                           textAlign: pw.TextAlign.justify,
//                           text: pw.TextSpan(
//                             text: 'This is to certify that ',
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.normal,
//                                 fontSize: 12.5),
//                             children: [
//                               pw.TextSpan(
//                                 text:
//                                     '${widget.gender} ${widget.firstName.toString().capitalizeFirst} ${widget.middleName.toString().capitalizeFirst} ${widget.lastName.toString().capitalizeFirst} ',
//                                 style: pw.TextStyle(
//                                     fontWeight: pw.FontWeight.bold,
//                                     fontSize: 12.5),
//                               ),
//                               const pw.TextSpan(
//                                 text: 'has successfully completed his ',
//                                 style: pw.TextStyle(fontSize: 12),
//                               ),
//                               pw.TextSpan(
//                                 text: 'FLUTTER APP DEVELOPMENT',
//                                 style: pw.TextStyle(
//                                   fontSize: 12.5,
//                                   fontWeight: pw.FontWeight.bold,
//                                 ),
//                               ),
//                               const pw.TextSpan(
//                                 text: ' course from ',
//                                 style: pw.TextStyle(
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               pw.TextSpan(
//                                 text: 'August 2022 ',
//                                 style: pw.TextStyle(
//                                   fontSize: 12.5,
//                                   fontWeight: pw.FontWeight.bold,
//                                 ),
//                               ),
//                               const pw.TextSpan(
//                                 text: 'to ',
//                                 style: pw.TextStyle(
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               pw.TextSpan(
//                                 text: 'April 2023.',
//                                 style: pw.TextStyle(
//                                     fontWeight: pw.FontWeight.bold,
//                                     fontSize: 12.5),
//                               ),
//                             ],
//                           ),
//                         ),
//                         pw.SizedBox(height: 30),
//                         pw.Text(
//                           '${widget.firstName.toString().capitalizeFirst} has been sincere, hardworking, and punctual about the course lectures and task deadlines.',
//                           textAlign: pw.TextAlign.justify,
//                           style: const pw.TextStyle(fontSize: 12.5),
//                         ),
//                         pw.SizedBox(height: 30),
//                         pw.Text(
//                           'We wish him all the best for his upcoming career.',
//                           textAlign: pw.TextAlign.justify,
//                           style: const pw.TextStyle(fontSize: 12.5),
//                         ),
//                         pw.SizedBox(height: 30),
//                         pw.Text(
//                           'Nevil Vaghasiya',
//                           textAlign: pw.TextAlign.justify,
//                           style: pw.TextStyle(
//                               fontSize: 12.5, fontWeight: pw.FontWeight.bold),
//                         ),
//                         pw.SizedBox(height: 5),
//                         pw.Text(
//                           'CODELINE INFOTECH LLP',
//                           textAlign: pw.TextAlign.justify,
//                           style: pw.TextStyle(
//                               fontSize: 12.5, fontWeight: pw.FontWeight.bold),
//                         ),
//                         pw.SizedBox(height: 70),
//                         pw.Text(
//                           'Authorized Signature',
//                           textAlign: pw.TextAlign.justify,
//                           style: const pw.TextStyle(fontSize: 12),
//                         )
//                       ],
//                     )
//                   :
//
//                   ///'Internship Completion Certificates'---------------------------------------------------------------------
//                   pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.SizedBox(
//                           height: 40,
//                         ),
//                         pw.Align(
//                           alignment: pw.Alignment.topRight,
//                           child: pw.RichText(
//                             text: pw.TextSpan(
//                               text: 'Date: ',
//                               style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                               children: [
//                                 pw.TextSpan(
//                                   text: DateFormat('dd/MM/yyyy')
//                                       .format(widget.selectDate!),
//                                   style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.normal,
//                                       fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         pw.SizedBox(
//                           height: 65,
//                         ),
//                         pw.Align(
//                           alignment: pw.Alignment.center,
//                           child: pw.Text('${widget.certificatesType}',
//                               style: pw.TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: pw.FontWeight.bold,
//                               )),
//                         ),
//                         pw.SizedBox(
//                           height: 45,
//                         ),
//                         pw.Text(
//                           '${widget.gender} ${widget.firstName.toString().capitalizeFirst} ${widget.lastName.toString().capitalizeFirst}',
//                           textAlign: pw.TextAlign.justify,
//                           style: pw.TextStyle(
//                             fontSize: 12.5,
//                             fontWeight: pw.FontWeight.bold,
//                           ),
//                         ),
//                         pw.SizedBox(height: 15),
//                         pw.Text(
//                           '${widget.collegeName}',
//                           textAlign: pw.TextAlign.justify,
//                           style: pw.TextStyle(
//                             fontSize: 12.5,
//                             fontWeight: pw.FontWeight.bold,
//                           ),
//                         ),
//                         pw.SizedBox(height: 15),
//                         pw.Row(children: [
//                           pw.Text(
//                             'Dear ',
//                             textAlign: pw.TextAlign.justify,
//                             style: const pw.TextStyle(fontSize: 12.5),
//                           ),
//                           pw.Text(
//                             '${widget.firstName.toString().capitalizeFirst}',
//                             textAlign: pw.TextAlign.justify,
//                             style: pw.TextStyle(
//                               fontSize: 12.5,
//                               fontWeight: pw.FontWeight.bold,
//                             ),
//                           ),
//                         ]),
//                         pw.SizedBox(height: 15),
//                         pw.RichText(
//                           textAlign: pw.TextAlign.justify,
//                           text: pw.TextSpan(
//                             text:
//                                 'In Reference to your application, we would like to congratulate you on being selected for an internship with',
//                             children: [
//                               pw.TextSpan(
//                                 text: ' Codeline Infotech',
//                                 style: pw.TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: pw.FontWeight.bold),
//                               ),
//                               const pw.TextSpan(
//                                 text: ' from',
//                                 style: pw.TextStyle(
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               pw.TextSpan(
//                                 text: ' Surat.',
//                                 style: pw.TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: pw.FontWeight.bold),
//                               ),
//                               const pw.TextSpan(
//                                 text:
//                                     ' Your training is scheduled to start on ',
//                                 style: pw.TextStyle(
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               pw.TextSpan(
//                                 text:
//                                     '${DateFormat('d MMMM').format(widget.firstDate!)} ',
//                                 style: pw.TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: pw.FontWeight.bold),
//                               ),
//                               const pw.TextSpan(
//                                 text: 'for a period of',
//                                 style: pw.TextStyle(
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               pw.TextSpan(
//                                 text: ' 6 Months.',
//                                 style: pw.TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: pw.FontWeight.bold),
//                               ),
//                               const pw.TextSpan(
//                                 text: ' All of us at',
//                                 style: pw.TextStyle(
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               pw.TextSpan(
//                                 text: ' Codeline Infotech',
//                                 style: pw.TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: pw.FontWeight.bold),
//                               ),
//                               const pw.TextSpan(
//                                 text:
//                                     ' are excited that you will be joining our team.',
//                                 style: pw.TextStyle(
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         pw.SizedBox(height: 15),
//                         pw.Text(
//                           'In your internship, we will include training and focus on learning Web development and new skills and gaining a deeper understanding of concepts through hands-on Web application of the knowledge you learned',
//                           textAlign: pw.TextAlign.justify,
//                           style: const pw.TextStyle(
//                             fontSize: 12,
//                           ),
//                         ),
//                         pw.SizedBox(height: 15),
//                         pw.Text(
//                           'Information about the project and technical platform will be shared with you before the commencement of your training Congratulations to you and we are excited to work with you',
//                           textAlign: pw.TextAlign.justify,
//                           style: const pw.TextStyle(
//                             fontSize: 12,
//                           ),
//                         ),
//                         pw.SizedBox(height: 50),
//                         pw.RichText(
//                           text: pw.TextSpan(
//                               text: 'Duration: ',
//                               style: const pw.TextStyle(
//                                 fontSize: 12,
//                               ),
//                               children: [
//                                 pw.TextSpan(
//                                   text: '6 Months',
//                                   style: pw.TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: pw.FontWeight.bold,
//                                   ),
//                                 )
//                               ]),
//                         ),
//                         pw.SizedBox(height: 40),
//                         pw.Text(
//                           'Nevil Vaghasiya',
//                           textAlign: pw.TextAlign.justify,
//                           style: pw.TextStyle(
//                               fontSize: 12.5, fontWeight: pw.FontWeight.bold),
//                         ),
//                         pw.SizedBox(height: 5),
//                         pw.Text(
//                           'CODELINE INFOTECH LLP',
//                           textAlign: pw.TextAlign.justify,
//                           style: pw.TextStyle(
//                               fontSize: 12.5, fontWeight: pw.FontWeight.bold),
//                         ),
//                         pw.SizedBox(height: 70),
//                         pw.Text(
//                           'Authorized Signature',
//                           textAlign: pw.TextAlign.justify,
//                           style: const pw.TextStyle(fontSize: 12),
//                         )
//                       ],
//                     ),
//     );
//   }
// }

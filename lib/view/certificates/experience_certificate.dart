import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../Api/view_model/certificate_view_model.dart';
import '../../widget/app_color.dart';

class ExperienceCertificate extends StatefulWidget {
  const ExperienceCertificate({
    Key? key,
    this.gender,
    this.firstName,
    this.lastName,
    this.certificatesType,
    this.occupation,
    this.collegeName,
    this.description,
    this.selectDate,
    this.firstDate,
    this.lastDate,
    this.middleName,
    this.genderPronounce1,
    this.id,
  }) : super(key: key);

  final String? gender;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? certificatesType;
  final DateTime? selectDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? occupation;
  final String? collegeName;
  final String? description;
  final String? genderPronounce1;
  final String? id;

  @override
  State<ExperienceCertificate> createState() => _ExperienceCertificateState();
}

class _ExperienceCertificateState extends State<ExperienceCertificate> {
  CertificateApiController certificateApiController =
      Get.put(CertificateApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.mainColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Certificates'),
      ),
      body: PdfPreview(
        build: (format) => generatePdf('Certificates'),
      ),
    );
  }

  Future<Uint8List> generatePdf(String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.calligraffittiRegular();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
              pw.Expanded(child: certificateContent(font)),
            ],
          );
        },
      ),
    );

    final output = await getDownloadsDirectory();
    final file = File('${output!.path}/certificate.pdf');
    var filepath = await file.writeAsBytes(await pdf.save());

    final formData = d.FormData.fromMap({
      "type": "${widget.certificatesType}",
      "certificate_document": await d.MultipartFile.fromFile(filepath.path,
          filename: 'certificate.pdf')
    });

    certificateApiController.addCertificateDetails(
        url:
            'https://codelineinfotechapis.vercel.app/api/v1/certificate/upload_certificate/${widget.id}',
        body: formData);
    setState(() {});

    return pdf.save();
  }

  pw.Container certificateContent(pw.Font font) {
    return pw.Container(
        child: pw.Padding(
      padding: const pw.EdgeInsets.only(left: 15),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            height: 50,
          ),
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.RichText(
              text: pw.TextSpan(
                text: 'Date: ',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 11,
                ),
                children: [
                  pw.TextSpan(
                    text: DateFormat('dd/MM/yyyy').format(widget.selectDate!),
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.normal, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          pw.SizedBox(
            height: 50,
          ),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text('${widget.certificatesType}',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                )),
          ),
          pw.SizedBox(
            height: 50,
          ),
          pw.Text(
            'TO WHOM IT MAY CONCERN,',
            textAlign: pw.TextAlign.justify,
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.RichText(
            textAlign: pw.TextAlign.justify,
            text: pw.TextSpan(
              text: 'This is to certify that ',
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 11),
              children: [
                pw.TextSpan(
                  text:
                      '${widget.gender} ${widget.firstName.toString().capitalizeFirst} ${widget.lastName.toString().capitalizeFirst} ',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 11),
                ),
                pw.TextSpan(
                  text:
                      'was an employee of Codeline Infotech from ${DateFormat('d MMMM y').format(widget.firstDate!)} to ${DateFormat('d MMMM y').format(widget.lastDate!)} as a Flutter developer.',
                  style: const pw.TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            textAlign: pw.TextAlign.justify,
            '${widget.gender} ${widget.firstName} ${widget.lastName} was appointed on a full-time (40 hrs. per week) paid basis in Technology Department at Surat. ${widget.gender} ${widget.firstName} ${widget.lastName} has performed the following duties during ${widget.genderPronounce1} employment with us.',
            style: const pw.TextStyle(fontSize: 11),
          ),
          pw.SizedBox(height: 10),
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 20, right: 30),
            child: pw.Container(
              child: pw.Column(
                children: [
                  pw.Row(
                    children: [
                      pw.Container(
                        height: 5,
                        width: 5,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.black,
                          shape: pw.BoxShape.circle,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                          'Develop Mobile Application Software using Flutter and related Mobile technologies.',
                          textAlign: pw.TextAlign.justify,
                          style: const pw.TextStyle(fontSize: 11))
                    ],
                  ),
                  pw.SizedBox(height: 3),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Container(
                        height: 5,
                        width: 5,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.black,
                          shape: pw.BoxShape.circle,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                          'Responsible for maintaining and handling the Firebase database.',
                          textAlign: pw.TextAlign.justify,
                          style: const pw.TextStyle(fontSize: 11))
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 15),
                        child: pw.Container(
                          height: 5,
                          width: 5,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.black,
                            shape: pw.BoxShape.circle,
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                          'Responsible for documentation of code, processes, and other feature specification\ndocuments. ',
                          textAlign: pw.TextAlign.justify,
                          style: const pw.TextStyle(fontSize: 11))
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    children: [
                      pw.Container(
                        height: 5,
                        width: 5,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.black,
                          shape: pw.BoxShape.circle,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                          'Analyzing & resolving technical problems to ensure business continuity',
                          textAlign: pw.TextAlign.justify,
                          style: const pw.TextStyle(fontSize: 11))
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 15),
                        child: pw.Container(
                          height: 5,
                          width: 5,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.black,
                            shape: pw.BoxShape.circle,
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                          'Responsible for communicating with team and support staff regarding programming \nneeds and performance',
                          textAlign: pw.TextAlign.justify,
                          style: const pw.TextStyle(fontSize: 11))
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 15),
                        child: pw.Container(
                          height: 5,
                          width: 5,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.black,
                            shape: pw.BoxShape.circle,
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                          'Testing new programs to ensure that logic and syntax are correct, and that program\nresults are accurate',
                          textAlign: pw.TextAlign.justify,
                          style: const pw.TextStyle(fontSize: 11))
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    children: [
                      pw.Container(
                        height: 5,
                        width: 5,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.black,
                          shape: pw.BoxShape.circle,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                          'Assist junior-level programmers with programming assignments and mentoring them.',
                          textAlign: pw.TextAlign.justify,
                          style: const pw.TextStyle(fontSize: 11))
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 15),
                        child: pw.Container(
                          height: 5,
                          width: 5,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.black,
                            shape: pw.BoxShape.circle,
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                          'Deal with offshore customers to resolve technical problems and understand their\nrequirements.',
                          textAlign: pw.TextAlign.justify,
                          style: const pw.TextStyle(fontSize: 11))
                    ],
                  ),
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            '${widget.firstName} has been sincere, hardworking, and punctual about meeting the project schedule and deadlines.',
            textAlign: pw.TextAlign.justify,
            style: const pw.TextStyle(fontSize: 11),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'Please feel free to contact me if you have any questions regarding ${widget.gender} ${widget.firstName} ${widget.lastName} employment with us.',
            textAlign: pw.TextAlign.justify,
            style: const pw.TextStyle(fontSize: 11),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'CODELINE INFOTECH LLP',
            textAlign: pw.TextAlign.justify,
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 60),
          pw.Text(
            'Authorized Signature',
            textAlign: pw.TextAlign.justify,
            style: const pw.TextStyle(fontSize: 11),
          )
        ],
      ),
    ));
  }
}

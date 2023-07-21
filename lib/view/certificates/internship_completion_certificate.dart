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

class InternshipCompletionCertificate extends StatefulWidget {
  const InternshipCompletionCertificate({
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
    this.months,
    this.genderPronounce,
    this.genderPronounce1,
    this.genderPronounce2,
    this.projectTitle,
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
  final int? months;
  final String? genderPronounce;
  final String? genderPronounce1;
  final String? genderPronounce2;
  final String? projectTitle;
  final String? id;

  @override
  State<InternshipCompletionCertificate> createState() =>
      _InternshipCompletionCertificateState();
}

class _InternshipCompletionCertificateState
    extends State<InternshipCompletionCertificate> {
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
        'https://codelineinfotechapis.vercel.app/api/v1/certificate/upload_certificate/${widget
            .id}',
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
                height: 60,
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
                        text:
                        DateFormat('dd/MM/yyyy').format(widget.selectDate!),
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(
                height: 60,
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
                height: 60,
              ),
              pw.Text(
                'TO WHOM IT MAY CONCERN,',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 30),
              pw.RichText(
                textAlign: pw.TextAlign.justify,
                text: pw.TextSpan(
                  text: 'This is to certify that ',
                  children: [
                    pw.TextSpan(
                      text:
                      '${widget.gender} ${widget.firstName} ${widget
                          .middleName} ${widget.lastName}, ',
                      style: pw.TextStyle(
                          fontSize: 11, fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(
                      text: 'student of ',
                      style: pw.TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    pw.TextSpan(
                      text: '${widget.collegeName} ',
                      style: pw.TextStyle(
                          fontSize: 11, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.TextSpan(
                      text:
                      'has successfully completed ${widget
                          .genderPronounce1} internship from ${DateFormat(
                          'd MMMM yyyy').format(
                          widget.firstDate!)} to ${DateFormat('d MMMM yyyy')
                          .format(widget.lastDate!)}. ',
                      style: const pw.TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    pw.TextSpan(
                      text:
                      "During this period, ${widget
                          .genderPronounce2} undertook a project titled ${widget
                          .projectTitle}, This project aimed to buy sell and buy Stationary items. As a part of this project, ${widget
                          .genderPronounce2} has worked on front end of the App.",
                      style: const pw.TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'During ${widget
                    .genderPronounce1} internship period, we have found ${widget
                    .genderPronounce} to be dedicated and knowledgeable about the subject and ${widget
                    .genderPronounce1} performance toward the completion of the project has been satisfactory.',
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 11,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                '${widget
                    .firstName} has been sincere, hardworking, and punctual about meeting the project schedule and deadlines',
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 11,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'We wish ${widget.genderPronounce} all the best for ${widget
                    .genderPronounce1} upcoming career.',
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 11,
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                'Nevil Vaghasiya',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                    fontSize: 11, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                'CODELINE INFOTECH LLP',
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                    fontSize: 11, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 70),
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

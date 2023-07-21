import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../widget/app_color.dart';

class PrintReceiptScreen extends StatefulWidget {
  final String? receipt;
  final String? name;
  final String? date;
  final String? word;
  final String? rs;
  final String? number;
  final String? mode;

  const PrintReceiptScreen(
      {super.key,
      this.receipt,
      this.name,
      this.date,
      this.word,
      this.rs,
      this.number,
      this.mode});

  @override
  State<PrintReceiptScreen> createState() => _PrintReceiptScreenState();
}

class _PrintReceiptScreenState extends State<PrintReceiptScreen> {
  Size? size;

  var image;

  @override
  initState() {
    loadImage();
    super.initState();
  }

  Future<void> loadImage() async {
    image = await imageFromAssetBundle('assets/images/CODELINE.svg');
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

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
        title: const Text('Receipt'),
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format, 'Receipt'),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        margin: const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        build: (context) {
          return pw.Column(
            children: [
              pw.Expanded(child: buildReceipt(font)),
              pw.Divider(
                color: const PdfColor.fromInt(0xff808080),
                thickness: 1,
              ),
              pw.Expanded(child: buildReceipt(font)),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Container buildReceipt(pw.Font font) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
      ),
      width: double.infinity,
      decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: const PdfColor.fromInt(0xff808080),
          ),
          borderRadius: pw.BorderRadius.circular(8)),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            'CODELINE INFOTECH',
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(vertical: 5),
                height: 0.5,
                width: 100,
                color: const PdfColor.fromInt(0xff808080),
              ),
              pw.Container(
                height: 1,
                width: 120,
                color: const PdfColor.fromInt(0xff000000),
              ),
              pw.Container(
                height: 0.5,
                width: 100,
                color: const PdfColor.fromInt(0xff808080),
              ),
            ],
          ),
          pw.Text(
            'THE IT KNOWLEDGE HUB',
            style: const pw.TextStyle(
              fontSize: 18,
              wordSpacing: 2,
              letterSpacing: 4,
            ),
          ),
          pw.SizedBox(height: 15),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                width: 120,
                child: pw.Stack(
                  overflow: pw.Overflow.visible,
                  children: [
                    pw.Text(
                      'RECEIPT NO :',
                      style: pw.TextStyle(
                        fontNormal: pw.Font.helvetica(),
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                    pw.Positioned(
                      left: 85,
                      child: pw.Text(' ${widget.receipt}'),
                    ),
                    pw.Positioned(
                      left: 85,
                      bottom: -2,
                      child: pw.Container(
                        height: 1,
                        width: 50,
                        color: const PdfColor.fromInt(
                          0xff000000,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                width: 120,
                child: pw.Stack(
                  overflow: pw.Overflow.visible,
                  children: [
                    pw.Text(
                      'DATE :',
                      style: pw.TextStyle(
                        fontNormal: pw.Font.helvetica(),
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                    pw.Positioned(
                      right: 10,
                      child: pw.Text(DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(widget.date!))),
                    ),
                    pw.Positioned(
                      right: 0,
                      bottom: -2,
                      child: pw.Container(
                        height: 1,
                        width: 75,
                        color: const PdfColor.fromInt(
                          0xff000000,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(
            height: 20,
          ),
          pw.Text(
            'FEE RECEIPT',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                ///name
                pw.Container(
                  width: 120,
                  child: pw.Stack(
                    overflow: pw.Overflow.visible,
                    children: [
                      pw.Text(
                        'FULL NAME :',
                        style: pw.TextStyle(
                          fontNormal: pw.Font.helvetica(),
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                      pw.Positioned(
                        left: 80,
                        child: pw.Text('${widget.name}'),
                      ),
                      pw.Positioned(
                        left: 80,
                        bottom: -2,
                        child: pw.Container(
                          height: 1,
                          width: 350,
                          color: const PdfColor.fromInt(
                            0xff000000,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///date
                pw.SizedBox(
                  height: 25,
                ),
                pw.Container(
                  width: 120,
                  child: pw.Stack(
                    overflow: pw.Overflow.visible,
                    children: [
                      pw.Text(
                        'IN WORD :',
                        style: pw.TextStyle(
                          fontNormal: pw.Font.helvetica(),
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                      pw.Positioned(
                        left: 80,
                        child: pw.Text('${widget.word}'),
                      ),
                      pw.Positioned(
                        left: 80,
                        bottom: -2,
                        child: pw.Container(
                          height: 1,
                          width: 350,
                          color: const PdfColor.fromInt(
                            0xff000000,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///rs
                pw.SizedBox(height: 25),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 120,
                      child: pw.Stack(
                        overflow: pw.Overflow.visible,
                        children: [
                          pw.Text(
                            'INSTALLMENT NO :',
                            style: pw.TextStyle(
                              fontNormal: pw.Font.helvetica(),
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                          pw.Positioned(
                            left: 120,
                            child: pw.Text(' ${widget.number}'),
                          ),
                          pw.Positioned(
                            left: 120,
                            bottom: -2,
                            child: pw.Container(
                              height: 1,
                              width: 50,
                              color: const PdfColor.fromInt(
                                0xff000000,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      width: 140,
                      height: 30,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.grey,
                          width: 1,
                        ),
                        borderRadius: pw.BorderRadius.circular(5),
                      ),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 10),
                          pw.Text(
                            "Rs.",
                            style: const pw.TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          pw.SizedBox(width: 10),
                          pw.Text(
                            "${widget.rs}" + "/-",
                            style: const pw.TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 45),

                ///signature
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 120,
                      child: pw.Stack(
                        overflow: pw.Overflow.visible,
                        children: [
                          pw.Text(
                            'Student Sign :',
                            style: pw.TextStyle(
                              fontNormal: pw.Font.helvetica(),
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                          pw.Positioned(
                            left: 120,
                            child: pw.Text(''),
                          ),
                          pw.Positioned(
                            left: 85,
                            bottom: -2,
                            child: pw.Container(
                              height: 1,
                              width: 100,
                              color: const PdfColor.fromInt(
                                0xff000000,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      width: 200,
                      child: pw.Stack(
                        overflow: pw.Overflow.visible,
                        children: [
                          pw.Text(
                            'Admin Sign :',
                            style: pw.TextStyle(
                              fontNormal: pw.Font.helvetica(),
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                          pw.Positioned(
                            right: 10,
                            child: pw.Text(''),
                          ),
                          pw.Positioned(
                            right: 0,
                            bottom: -2,
                            child: pw.Container(
                              height: 1,
                              width: 120,
                              color: const PdfColor.fromInt(
                                0xff000000,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

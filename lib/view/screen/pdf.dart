import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';

class pdf extends StatefulWidget {
  const pdf({super.key});

  @override
  State<pdf> createState() => _pdfState();
}

class _pdfState extends State<pdf> {
  Future<String?> createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text("Hello, World!"),
        ),
      ),
    );

    try {
      final output = await getTemporaryDirectory();
      final filePath = "${output.path}/example.pdf";

      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      return filePath;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> sharePdfToWhatsApp(String filePath, String phoneNumber) async {
    final Uri fileUri = Uri.file(filePath);
    const String message = "Please check the attached PDF file.";

    String url() {
      if (Platform.isAndroid) {
        //https://wa.me/9647847261016
        return "https://wa.me/9647847261016/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send? &text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  Future<void> sharePdf(String filePath) async {
    try {
      await FlutterShare.shareFile(
        title: 'Share PDF',
        filePath: filePath,
        chooserTitle: 'Send via WhatsApp',
      );
    } catch (e) {
      print('Error sharing file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send PDF via WhatsApp'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String? filePath = await createPdf();
            await sharePdfToWhatsApp(filePath!, '+9647724128461');
          },
          child: const Text('Create and Share PDF'),
        ),
      ),
    );
  }
}

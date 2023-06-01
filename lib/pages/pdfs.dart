import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfs extends StatefulWidget {
  String link;
  Pdfs({required this.link});

  @override
  State<Pdfs> createState() => _PdfsState(link: link);
}

class _PdfsState extends State<Pdfs> {
  String link;

  _PdfsState({required this.link});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: SfPdfViewer.network(link),
      );
  }
}

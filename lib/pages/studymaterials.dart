import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class Study extends StatefulWidget {
  String link;
  Study({required this.link});
  @override
  State<Study> createState() => _StudyState(link: link);
}

class _StudyState extends State<Study> {
  String link;
  _StudyState({required this.link});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfPdfViewer.network(link),
    ); 
  }
}

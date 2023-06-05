import 'package:flutter/material.dart';
class Links extends StatefulWidget {
  String? subject;
  List<String>? links;
  Links({required this.subject,required this.links});

  @override
  State<Links> createState() => _LinksState(subject: subject,links: links);
}

class _LinksState extends State<Links> {
  final String? subject;
  final List<String>? links;
  _LinksState({required this.subject,required this.links});
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

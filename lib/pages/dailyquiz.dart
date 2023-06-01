import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class Quiz extends StatefulWidget {
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final auth = FirebaseAuth.instance;
  final fs = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Quiz',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
        ),
      ),
    );
  }
}

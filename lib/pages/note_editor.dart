import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practice/pages/App_Style.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);


  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    int color_id = Random().nextInt(AppStyle.cardsColor.length);
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Add a new Note'),
        backgroundColor: AppStyle.cardsColor[color_id],
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 8.0),
            Text(DateFormat('yyyy-MM-dd KK:mm:ss a').format(DateTime.now()),style: AppStyle.dateTitle,),
            SizedBox(height:20.0),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note content',

              ),
              style: AppStyle.mainContent,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          FirebaseFirestore.instance.collection('Notes').add({
            "note_title":_titleController.text,
            "creation_date":DateFormat('yyyy-MM-dd KK:mm a').format(DateTime.now()),
            "note_content":_mainController.text,
            "color_id":color_id,
          }).then((value){
            print(value.id);
            Navigator.pop(context);
          }).catchError(
          (error)=>print("Failed to add new Note due to $error")
          );
        },
      child:Icon(Icons.save),
      ),
    );
  }
}

import 'package:flutter/material.dart';
class Question{
  final String question;
  final List<Answer> answerList;
  Question(this.question,this.answerList);
}
class Answer{
final String answer;
final bool isCorrect;
Answer(this.answer,this.isCorrect);
}

List<Question> getQuestions(){
  List<Question> list = [];
  list.add(Question("Who developed the Flutter Framework and continues to maintain it today?",[Answer("Facebook", false),
    Answer("Microsoft", false),
    Answer("Google", true),
    Answer(" Oracle", false),] ,));
  list.add(Question("Which programming language is used to build Flutter applications?",[Answer(" Kotlin", false),
    Answer("Dart", true),
    Answer("Java", false),
    Answer(" Go", false),] ,));
  list.add(Question(" Go",[Answer("2", true),
    Answer("4", false),
    Answer("6", false),
    Answer("8", false),] ,));
  list.add(Question("When building for iOS, Flutter is restricted to an __ compilation strategy",[Answer("AOT (ahead-of-time)", false),
    Answer("JIT (Just-in-time)", false),
    Answer("Transcompilation", true),
    Answer(" Recompilation", false),] ,));
  list.add(Question("A sequence of asynchronous Flutter events is known as a:",[Answer("FLOW", false),
    Answer("Current", false),
    Answer("Stream", true),
    Answer("Series", false),] ,));
  list.add(Question("Access to a cloud database through Flutter is available through which service?",[Answer("SQLite", false),
    Answer("Firebase Database", true),
    Answer("NOSQL", false),
    Answer("MYSQL", false),] ,));
  list.add(Question("What are some key advantages of Flutter over alternate frameworks?",[Answer(" Rapid cross-platform application development and debugging tools", false),
    Answer(" Future-proofed technologies and UI resources", false),
    Answer("Strong supporting tools for application development and launch", false),
    Answer(" All of the above", true),] ,));
  list.add(Question("What element is used as an identifier for components when programming in Flutter?",[Answer("Widgets", false),
    Answer("Keys", true),
    Answer("Elements", false),
    Answer("Serial", false),] ,));
  return list;
}
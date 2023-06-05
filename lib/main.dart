import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice/pages/login_page.dart';
import 'package:practice/pages/signup-page.dart';
import 'package:practice/pages/profile-page.dart';
import 'package:practice/pages/home-page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var email;
  bool isLogin = false;
  
  checkLogin() async{
    auth.authStateChanges().listen((User? user) {
      if(user!=null && mounted){
        setState(() {
          isLogin=true;
          email=auth.currentUser?.email;
        });
      }
     });
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isLogin? Home(email: email): Homes();
  }
}
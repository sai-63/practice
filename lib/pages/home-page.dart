import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:practice/pages/chat-type.dart';
import 'package:practice/pages/materials.dart';
import 'package:practice/pages/notes_homepage.dart';
import 'package:practice/reusable_widgets.dart';
import 'package:practice/pages/syllabus-page.dart';
import 'package:practice/pages/YoutubeLink.dart';
import 'package:practice/pages/dailyquiz.dart';
import 'package:practice/pages/ai-chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/main.dart';

class Home extends StatefulWidget {
  String email;
  Home({required this.email});

  @override
  State<Home> createState() => _HomeState(email: email);
}

class _HomeState extends State<Home> {
  String email;
  _HomeState({required this.email});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text(
          'Eduflex',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black
              ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person),
                          radius: 25.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text('Welcome, ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,color: Colors.white)),
                        Text(email.replaceAll("@gmail.com", ""),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,color: Colors.white),),
                        // Text('Welcome, ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.white)),
                      ],
                    ),
                      ],
                    ),
                    SizedBox(height: 55.0,),
                    Row(
                      children: [
                        Icon(Icons.mail_rounded,color: Colors.grey,),
                        SizedBox(width: 5.0,),
                        Text(':-',style: TextStyle(color: Colors.white),),
                        SizedBox(width: 5.0,),
                        Text(email,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white)),
                      ],
                    ),
                  ],
                )
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 30.0),
              leading: Icon(Icons.person),
              title: Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.black)),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 30.0),
              leading: Icon(Icons.logout_sharp),
              title: Text('LogOut',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.black)),
              onTap: ()async{
                await _auth.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));},
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300]
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(child: Text("Let's Learn Together",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                  const SizedBox(height: 40.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      box('Schedules', Icons.schedule,(){}),
                      const SizedBox(
                        width: 35.0,
                      ),
                      box('Notes', Icons.note_alt_sharp,(){Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesHomePage()));}),
                      const SizedBox(width: 35.0,),
                      box('Syllabus', Icons.assignment_sharp,(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Syllabus()));})
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      box('Chat', Icons.chat,(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Chatype(email: email)));}),
                      const SizedBox(
                        width: 35.0,
                      ),
                      box('Study Materials', Icons.menu_book,(){Navigator.push(context, MaterialPageRoute(builder: (context)=>StudyMaterials()));}),
                      const SizedBox(width: 35.0,),
                      box('YouTube', Icons.play_circle_fill_rounded,(){Navigator.push(context, MaterialPageRoute(builder: (context)=>YoutubeLink()));})
                    ],
                  ),
                  SizedBox(height: 70.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      box('Quiz', Icons.quiz_outlined,(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Quiz()));}),
                      const SizedBox(
                        width: 35.0,
                      ),
                      box('Ai-Chat', Icons.chat,(){Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatGPTScreen()));}),
                      ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:practice/pages/chat-type.dart';
import 'package:practice/reusable_widgets.dart';
import 'package:practice/pages/syllabus-page.dart';
import 'package:practice/pages/YoutubeLink.dart';

class Home extends StatefulWidget {
  String email;
  Home({required this.email});

  @override
  State<Home> createState() => _HomeState(email: email);
}

class _HomeState extends State<Home> {
  String email;
  _HomeState({required this.email});

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
                          radius: 20.0,
                        ),
                        SizedBox(width: 10.0,),
                        Text('Welcome, ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.white)),
                        Text(email.replaceAll("@gmail.com", ""),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.white),),
                        // Text('Welcome, ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 70.0,),
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
              onTap: (){Navigator.pushReplacementNamed(context, '/');},
            )
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300]
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                box('Schedules', Icons.schedule,(){}),
                const SizedBox(
                  width: 35.0,
                ),
                box('Notes', Icons.note_alt_sharp,(){}),
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
                box('Study Materials', Icons.menu_book,(){}),
                const SizedBox(width: 35.0,),
                box('YouTube', Icons.play_circle_fill_rounded,(){Navigator.push(context, MaterialPageRoute(builder: (context)=>YoutubeLink()));})
              ],
            ),
          ],
        ),
      ),
    );
  }
}

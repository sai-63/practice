import 'package:flutter/material.dart';
import 'package:practice/pages/chat-page.dart';
import 'package:practice/pages/homepage.dart';
class Chatype extends StatefulWidget {
  String email;
  Chatype({required this.email});

  @override
  State<Chatype> createState() => _ChatypeState(email: email);
}

class _ChatypeState extends State<Chatype> {
  String email;
  _ChatypeState({required this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Chat',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(colors: [Colors.blue,Colors.purpleAccent,Colors.purple])
                ),
                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                width: MediaQuery.of(context).size.width - 60.0,
                height: MediaQuery.of(context).size.height - 60.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      'Chat Room',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                    SizedBox(height: 10.0,),
                    Wrap(alignment: WrapAlignment.center, children: [
                      Text(
                          'A public chat room where you can chat with all other users about various topics and have fun through learning concepts 😊')
                    ]),
                    SizedBox(height: 5.0,),
                    ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> chatpage(email: email)));},child: Text('Click Here'))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(colors: [Colors.blue,Colors.purpleAccent,Colors.purple])
                ),
                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                width: MediaQuery.of(context).size.width - 60.0,
                height: MediaQuery.of(context).size.height - 60.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      'Chat with Friends',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                    SizedBox(height: 10.0,),
                    Wrap(alignment: WrapAlignment.center, children: [
                      Text(
                          'Your personalized chat page where you can chat with all other users about various topics and have fun through learning concepts 😊')
                    ]),
                    SizedBox(height: 5.0,),
                    ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));}, child: Text('Click Here'))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}

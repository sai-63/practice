import 'package:flutter/material.dart';
import 'package:practice/reusable_widgets.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40.0,),
            Container(
              height: 100.0,
              width: MediaQuery.devicePixelRatioOf(context),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                      Icons.person,
                    color: Colors.blue,
                  ),
                  radius: 50.0,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Text('Username: ',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                SizedBox(width: 8.0,),
                reUsableTextField("Username", Icons.person, true, textController),
              ],
            )
            ,SizedBox(height: 100.0,),
            Text('Hi'),
          ],
        ),
      ),
    );
  }
}

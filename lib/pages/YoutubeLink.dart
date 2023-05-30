import 'package:flutter/material.dart';
import 'package:practice/reusable_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class YoutubeLink extends StatefulWidget {
  const YoutubeLink({Key? key}) : super(key: key);

  @override
  State<YoutubeLink> createState() => _YoutubeLinkState();
}

class _YoutubeLinkState extends State<YoutubeLink> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube',style: TextStyle(fontWeight: FontWeight.bold,fontSize:
        20.0),),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              YoutubeLinks("PSQT","https://www.youtube.com/playlist?list=PLU6SqdYcYsfLRq3tu-g_hvkHDcorrtcBK",Icons.ondemand_video),
              SizedBox(height: 10.0,),
              YoutubeLinks("FLAT","https://www.youtube.com/playlist?list=PLBhIctyfOJgApxx_FzhwxJoZsCl8AUk0t",Icons.ondemand_video),
              SizedBox(height: 10.0,),
              YoutubeLinks("JAVA","https://www.youtube.com/playlist?list=PLBlnK6fEyqRjKA_NuK9mHmlk0dZzuP1P5",Icons.ondemand_video),
              SizedBox(height: 10.0,),
              YoutubeLinks("CO","https://www.youtube.com/playlist?list=PLBlnK6fEyqRgLLlzdgiTUKULKJPYc0A4q",Icons.ondemand_video),
              SizedBox(height: 10.0,),
              YoutubeLinks("EEA","https://www.youtube.com/playlist?list=PLJ0PDUtEYgayoyxD6IXOPYDAzr1havLFz",Icons.ondemand_video),
              SizedBox(height: 10.0,),
              YoutubeLinks("SE","https://www.youtube.com/playlist?list=PLXILvWEqvR6UlLI0Wgs4Y0nbGctU2ArDJ",Icons.ondemand_video),
            ],
          ),
        ),
      ),
    );
  }
}
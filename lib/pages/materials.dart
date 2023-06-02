// import 'package:flutter/material.dart';
// import 'package:practice/pages/studymaterials.dart';
// import 'package:practice/reusable_widgets.dart';
// class StudyMaterials extends StatefulWidget {
//   const StudyMaterials({Key? key}) : super(key: key);
//
//   @override
//   State<StudyMaterials> createState() => _StudyMaterialsState();
// }
//
// class _StudyMaterialsState extends State<StudyMaterials> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: Text('Syllabus',style: TextStyle(fontWeight: FontWeight.bold,fontSize:
//         20.0),),
//         centerTitle: true,
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Container(
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(height: 40.0,),
//               material("SOFTWARE ENGINEERING",(){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> Study(link: '')));
//               }),
//               SizedBox(height: 40.0,),
//               material("COMPUTER ORGANISATION",(){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> Study(link: '')));
//               }),
//               SizedBox(height: 40.0,),
//               material("FORMAL LANGUAGE AND AUTOMATA THEORY",(){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> Study(link: '')));
//               }),
//               SizedBox(height: 40.0,),
//               material("PSQT",(){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> Study(link: '')));
//               }),
//               SizedBox(height: 40.0,),
//               material("JAVA",(){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> Study(link: '')));
//               }),
//               SizedBox(height: 40.0,),
//               material("ECONOMICS",(){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> Study(link: '')));
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

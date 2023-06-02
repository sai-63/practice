

import 'package:flutter/material.dart';
import 'package:practice/pages/question_page.dart';

class Quiz extends StatefulWidget {
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  List<Question> questionList = getQuestions();
  int currentQuestionIndex=0;
  int score=0;
  Answer?selectedAnswer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Quiz',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly
          ,children: [
          Text(
            'QUIZ',
            style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 26,
            ),
          ),
          _questionWidget(),
          _answerList(),
          _nextButton(),
        ],
        ),
      ),
    );
  }
  _questionWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Question ${currentQuestionIndex+1}/${questionList.length.toString()}',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 25),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            questionList[currentQuestionIndex].question,

            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
  _answerList(){
    return Column(
      children:
        questionList[currentQuestionIndex].answerList.map((e) =>_answerButton(e),).toList(),
    );
  }
  Widget _answerButton(Answer answer){
    bool isSelected= answer==selectedAnswer;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 50,
      child: ElevatedButton(
        child: Text(answer.answer,
        style: TextStyle(color: Colors.green),),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: isSelected?Colors.pinkAccent[150]:Colors.amber[100],
          onPrimary:isSelected?Colors.pinkAccent[160]:Colors.amber[100],
        ),
        onPressed: () {
         if(selectedAnswer==null)
           {
             if(answer.isCorrect){
               score++;
             }
             setState(() {
               selectedAnswer=answer;
             });
           }
        },
      ),
    );
  }
  _nextButton(){
    bool isLastQuestion=false;
    return Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: 50,
      child: ElevatedButton(
        child: Text(isLastQuestion?'Submit':'Next Question'),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: Colors.orangeAccent,
          onPrimary:Colors.red,
        ),
        onPressed: () {
              if(currentQuestionIndex==questionList.length-1){

                showDialog(context: context, builder:(_)=>_showScoreDialog());

             }
              else
               {
                  setState(() {
                    selectedAnswer=null;
                    currentQuestionIndex++;
                  });
                }
          },
      ),
    );
  }
   _showScoreDialog(){
    bool isPassed=false;
    if(score>= questionList.length *0.6){
      isPassed=true;
    }
    String title =isPassed? "Passed": "Failed";
    return AlertDialog(
      title: Text(title+" | Score is $score",style:TextStyle(color: isPassed? Colors.green : Colors.red)),
      content: ElevatedButton(child: Text("ReTake Quiz"),onPressed: (){
        Navigator.pop(context);
        setState(() {
          currentQuestionIndex=0;
          score=0;
          selectedAnswer=null;
        });
      },),
    );
  }
}

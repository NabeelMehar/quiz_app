import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/Model/Question.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  List<Question> documents = [];
  var _isLoading=true;
  var index=0;
  var btnNextText="Next";
  var btnAclr=Colors.blue;
  var btnBclr=Colors.blue;
  var btnCclr=Colors.blue;
  var btnDclr=Colors.blue;
  int flag=0;
  int score=0;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Quiz'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme
                  .of(context)
                  .primaryIconTheme
                  .color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8,),
                      Text('Logout')
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),

      body: _isLoading?
      Center(
        child: CircularProgressIndicator(),
      ):Container(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Your Score",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Text(score.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                  ),)
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(documents[index].ques,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 28,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    RaisedButton(
                      color: btnAclr,
                        onPressed: (){

                        if(flag==0) {
                          flag=1;
                          btnAclr = checkAnswer(documents[index].opA);
                          setState(() {});
                        }
                        },
                        child: Text(documents[index].opA,
                    )
                    ),
                    RaisedButton(
                        color: btnBclr,
                        onPressed: (){
                          if(flag==0) {
                            flag=1;
                            btnBclr = checkAnswer(documents[index].opB);
                            setState(() {});
                          }
                        },
                        child: Text(documents[index].opB)

                    ),
                      ],
                    ),
                    SizedBox(height: 28,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      RaisedButton(
                          color: btnCclr,
                          onPressed: (){
                            if(flag==0) {
                              flag=1;
                              btnCclr = checkAnswer(documents[index].opC);
                              setState(() {

                              });
                            }
                          },
                          child: Text(documents[index].opC)

                      ),
                      RaisedButton(
                          color: btnDclr,
                          onPressed: () {
                            if (flag == 0) {
                              flag=1;
                              btnDclr = checkAnswer(documents[index].opD);
                              setState(() {});
                            }
                          },
                          child: Text(documents[index].opD)

                      )

                    ],
                    ), Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      RaisedButton(onPressed: (){
                        if(index<documents.length-1) {
                          flag=0;
                          clearAllClrs();
                          index++;
                          setState(() {

                          });
                        }else{
                            flag=1;
                          setState(() {
                            btnNextText="Thank You Thats all";
                          });

                        }
                      },
                        child: Text(btnNextText),
                        color: Colors.purple,
                      )
                    ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  Future<void> getQuestions() async {
    var tempdocuments = await Firestore.instance
        .collection('questions')
        .getDocuments();

    for (var item in tempdocuments.documents) {


      documents.add(Question.name(item["ques"],
          item["answer"],
          item["opA"],
          item["opB"],
          item["opC"],
        item["opD"]));

      setState(() {
        _isLoading=false;
      });

    }



  }

  checkAnswer(String s) {

    var btnclr;

    if(documents[index].answer==s){
      btnclr=Colors.green;
      log("Correct");
      score=score+10;
    }else{
      btnclr=Colors.red;
      if(score>0)
      score=score-10;
      log("Wrong");
    }
    return btnclr;
  }

  void clearAllClrs() {
    btnAclr=Colors.blue;
    btnBclr=Colors.blue;
    btnCclr=Colors.blue;
    btnDclr=Colors.blue;

  }

}

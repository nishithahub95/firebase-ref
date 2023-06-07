
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final int indexAction;
  final int totalQuestion;

  QuestionWidget({ required this.indexAction,required this.question, required this.totalQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Question ${indexAction+1}/$totalQuestion:$question',style: TextStyle(fontSize: 24),),
    );
  }
}

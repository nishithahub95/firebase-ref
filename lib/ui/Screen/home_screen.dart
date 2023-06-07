import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/constraints.dart';
import 'package:quizz_app/model/question_model.dart';
import 'package:quizz_app/ui/Screen/Widget/next_button.dart';
import 'package:quizz_app/ui/Screen/Widget/option_card.dart';
import 'package:quizz_app/ui/Screen/Widget/question_widget.dart';
import 'package:quizz_app/ui/Screen/Widget/round_button.dart';
import 'package:quizz_app/ui/auth/login_screen.dart';
import 'package:quizz_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Questions> _question = [
    Questions(
        id: '3',
        title: 'What is 2+2',
        options: {'2': false, '1': false, '3': false, '4': true}),
    Questions(
        id: '3',
        title: 'What is 2+3',
        options: {'2': false, '1': false, '3': false, '4': true})
  ];
  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected=false;
  void nextQuestion(){
    if (index == _question.length - 1) {
    } else {
      if(isPressed){
        setState(() {
          index++;
          isPressed=false;
          isAlreadySelected=false;
        });
      }else{
        Utils().toastMessage('please select an option');
      }

    }
  }
  void updateScore(bool value){
    if(isAlreadySelected){
     return;
    }else{
      if(value==true){
        score++;
        setState(() {
          isPressed=true;
          isAlreadySelected=true;
        });
      }
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
         backgroundColor: baseColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score: $score',
                  style: const TextStyle(fontSize: 18.0),
                ),
                  IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout))
              ],
            ),
          )

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            QuestionWidget(
                indexAction: index,
                question: _question[index].title,
                totalQuestion: _question.length),
            Divider(
              color: nutral,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            for (int i = 0; i < _question[index].options.length; i++)
              InkWell(
               onTap:()=> updateScore(_question[index].options.values.toList()[i]),
                child: OptionCard(
                  option: _question[index].options.keys.toList()[i],
                  color: isPressed
                      ? _question[index].options.values.toList()[i] == true
                          ? correct
                          : inCorrect
                     : nutral, onTap: () {

                      setState(() {
                        isPressed=true;
                       // score++;
                      });
                },

                ),
              ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Align(
                alignment: Alignment.bottomRight,
                child: NextButton(
                  title: 'Next',
                  onTap: () {
                    nextQuestion();

                  },
                ))
          ],
        ),
      ),
    );
  }


}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/constraints.dart';
import 'package:quizz_app/ui/Screen/Widget/round_button.dart';
import 'package:quizz_app/ui/auth/verify_code.dart';
import 'package:quizz_app/utils/utils.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading=false;
  TextEditingController poneNumberController=TextEditingController();
  var auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Login'),
        backgroundColor: baseColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            TextFormField(
              controller: poneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                helperText: 'Enter your phone number ',
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16)
              )),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            RoundButton(title: 'Login',loading:loading, onTap: (){
              setState(() {
                loading=true;
              });

                    auth.verifyPhoneNumber(
                      phoneNumber: poneNumberController.text,
                        verificationCompleted: (_){
                          setState(() {
                            loading=false;
                          });

                        }, verificationFailed: (e){
                      setState(() {
                        loading=false;
                      });

                      Utils().toastMessage(e.toString());
                    },
                        codeSent: (String verificationId,int? token){
                          setState(() {
                            loading=false;
                          });

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCode(verificationId: verificationId,)));

                        },
                        codeAutoRetrievalTimeout:(e){
                          setState(() {
                            loading=false;
                          });

                          Utils().toastMessage(e.toString());
                        });
            })
          ],
        ),
      ),
    );
  }
}

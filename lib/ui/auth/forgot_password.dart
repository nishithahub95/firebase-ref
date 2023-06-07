

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/constraints.dart';
import 'package:quizz_app/ui/Screen/Widget/round_button.dart';
import 'package:quizz_app/utils/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController=TextEditingController();
  final newPasswordController=TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Forgot Password'),
        backgroundColor:baseColor,
      ),
       body: Padding(
         padding: const EdgeInsets.all(15.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             TextFormField(
               controller: emailController,
               decoration: InputDecoration(
                   hintText: 'Email',
                   fillColor: Color(0xffF8F9FA),
                   filled: true,
                   prefixIcon: Icon(
                     Icons.lock_outline,
                     color: Color(0xff323F4B),
                   ),
                   suffixIcon: Icon(
                     Icons.visibility_outlined,
                     color: Color(0xff323F4B),
                   ),
                   focusedBorder: OutlineInputBorder(
                       borderSide:
                       BorderSide(color: Color(0xffE4E7EB)),
                       borderRadius: BorderRadius.circular(10)),
                   enabledBorder: OutlineInputBorder(
                       borderSide:
                       BorderSide(color: Color(0xffE4E7EB)),
                       borderRadius: BorderRadius.circular(10))),
               validator: (value) {
                 if (value!.isEmpty) {
                   return 'Enter email';
                 }
                 return null;
               },
             ),

             SizedBox(
                 height: MediaQuery.of(context).size.height * 0.03),
             RoundButton(title: 'Submit', onTap: (){
               _auth.sendPasswordResetEmail(
                   email: emailController.text
               ).then((value) {
                 Utils().toastMessage('Check email for recover password');
               }).onError((error, stackTrace) {
                 Utils().toastMessage(error.toString());
               });

             })
           ],
         ),
       ),
    );
  }
}

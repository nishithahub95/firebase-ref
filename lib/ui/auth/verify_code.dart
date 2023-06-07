import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/constraints.dart';
import 'package:quizz_app/ui/Screen/Widget/round_button.dart';
import 'package:quizz_app/ui/Screen/home_screen.dart';
import 'package:quizz_app/utils/utils.dart';
class VerifyCode extends StatefulWidget {
  final String verificationId;

  const VerifyCode({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool loading=false;
  TextEditingController verificationCodeController=TextEditingController();
  var auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Verify'),
        backgroundColor: baseColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  helperText: '6 digit code ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)
                  )),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            RoundButton(title: 'Verify',loading:loading, onTap: ()async{
              setState(() {
                loading=true;
              });
              final credential=PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verificationCodeController.text.toString());
              try{
                await auth.signInWithCredential(credential);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              }catch(e){
                  setState(() {
                    loading=true;
                  });
                  Utils().toastMessage(e.toString());
              }

            })
          ],
        ),
      ),
    );
  }
}

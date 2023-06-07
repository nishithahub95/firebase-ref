import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/constraints.dart';
import 'package:quizz_app/firebase_services/auth_services.dart';
import 'package:quizz_app/ui/Post/post_screen.dart';
import 'package:quizz_app/ui/Screen/home_screen.dart';
import 'package:quizz_app/ui/auth/forgot_password.dart';
import 'package:quizz_app/ui/auth/login_with_phonenumber.dart';
import 'package:quizz_app/ui/auth/signup_screen.dart';
import 'package:quizz_app/utils/utils.dart';
import 'package:quizz_app/ui/Screen/Widget/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading=false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
        loading=true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
          Utils().toastMessage(value.user!.emailVerified.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
          setState(() {
            loading=false;
          });
    })
        .onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Login'),
        backgroundColor: Color(0xff2980B9),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/quiz.jpg'))),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            fillColor: Color(0xffF8F9FA),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.email_outlined,
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
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
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
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              RoundButton(
                loading:loading,
                title: 'Login',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                  ;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: Text('Forgot password?',style: TextStyle(color: Color(0xff2980B9),decoration: TextDecoration.underline)))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text('Sign up',style: TextStyle(color: Color(0xff2980B9))))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPhoneNumber()));
                },

                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black,
                    )

                  ),
                  child: Center(child: Text('Login with phone number',style: TextStyle(color: baseColor,fontWeight: FontWeight.w700),)),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              InkWell(
                onTap: ()async{
                  setState(() {
                    loading=true;
                  });
                  AuthServices().signInWithGoogle().then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    setState(() {
                      loading=false;
                    });
                  }

                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/google.png'))

                        )
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Signin with google',style: TextStyle(fontWeight: FontWeight.w700,color: baseColor),),
                        )
                      ],
                    ),
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}

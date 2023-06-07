

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizz_app/ui/auth/login_screen.dart';
import 'package:quizz_app/utils/utils.dart';
import 'package:quizz_app/ui/Screen/Widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
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

  void signUp() {
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((
        value) {
      setState(() {
             loading = false ;
             emailController.clear();
             passwordController.clear();
      });

    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false ;
        emailController.clear();
        passwordController.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(

          centerTitle: true,
          title: Text('SignUp'),
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
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.20,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.80,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/quiz.jpg')
                        )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.03),
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
                              prefixIcon: Icon(Icons.email_outlined,
                                color: Color(0xff323F4B),),

                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(10)
                              )

                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03),
                        TextFormField(
                          controller: passwordController,

                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',

                              fillColor: Color(0xffF8F9FA),
                              filled: true,

                              prefixIcon: Icon(Icons.lock_outline,
                                color: Color(0xff323F4B),),
                              suffixIcon: Icon(Icons.visibility_outlined,
                                color: Color(0xff323F4B),),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),

                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.03),

                RoundButton(
                  loading: loading,
                  title: 'Sign up', onTap: () {
                  if (_formKey.currentState!.validate()) {
                    signUp();

                  };
                },),
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an account?"),
                    TextButton(onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen())
                      );
                    },
                        child: Text('Login',style: TextStyle(color: Color(0xff2980B9)),))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






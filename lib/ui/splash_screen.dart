import 'package:flutter/material.dart';
import 'package:quizz_app/firebase_services/splash_services.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:Image(
          height: double.infinity,
          fit: BoxFit.fitHeight,
          image: AssetImage('images/question.jpg')),

    );
  }
}

import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/ui/Post/post_screen.dart';
import 'package:quizz_app/ui/Screen/home_screen.dart';
import 'package:quizz_app/ui/auth/login_screen.dart';


class SplashServices{
  void isLogin(BuildContext context){
    FirebaseAuth auth=FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 3), ()=>
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()))
      );
    }else{
      Timer(Duration(seconds: 3), ()=>
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()))
      );
    }

  }
}
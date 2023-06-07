import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quizz_app/ui/Firestore/firestorelist_screen.dart';
import 'package:quizz_app/ui/auth/login_screen.dart';
import 'package:quizz_app/ui/splash_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices{


  signInWithGoogle()async{
     final auth=FirebaseAuth.instance;
    final GoogleSignInAccount? gUser= await GoogleSignIn().signIn();//popup sreen
        final GoogleSignInAuthentication gAuth=await gUser!.authentication;//obtain auth details from request
    final credential=GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );//create anew credential foe user
    return await auth.signInWithCredential(credential);

  }
}
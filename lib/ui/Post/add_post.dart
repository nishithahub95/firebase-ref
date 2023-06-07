

import 'package:flutter/material.dart';
import 'package:quizz_app/constraints.dart';
import 'package:quizz_app/ui/Screen/Widget/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:quizz_app/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading=false;
  final dtabaseRef=FirebaseDatabase.instance.ref('Post');
  final postController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add a Post'),
          centerTitle: true,
          backgroundColor: baseColor,
        ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
              const  SizedBox(height: 30,),
                TextFormField(
                  controller: postController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'What is in your mind?',
                    border: OutlineInputBorder()

                  ),
                ),
                const  SizedBox(height: 30,),
                RoundButton(title:'Add',
                    loading: loading,
                    onTap: (){
                  setState(() {
                    loading=true;
                  });
                       //dtabaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).child('comments').set({
                         //comment is a sub child
                  String id=DateTime.now().millisecondsSinceEpoch.toString();
                         dtabaseRef.child(id).set({
                        'Title':postController.text,
                         'id':id
                       }).then((value){
                         setState(() {
                           loading=false;
                         });

                         Utils().toastMessage('Post added');
                       }).onError((error, stackTrace){
                         setState(() {
                           loading=false;
                         });

                         Utils().toastMessage(error.toString());
                       });
                         postController.clear();
                })
              ],
            ),
          ),
      ),
    );
  }
}

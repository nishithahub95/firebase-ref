import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/ui/Screen/Widget/round_button.dart';
import 'package:quizz_app/utils/utils.dart';

import '../../constraints.dart';

class FireStoreAddData extends StatefulWidget {
  const FireStoreAddData({Key? key}) : super(key: key);

  @override
  State<FireStoreAddData> createState() => _FireStoreAddDataState();
}

class _FireStoreAddDataState extends State<FireStoreAddData> {
  bool loading=false;
 final firestore=FirebaseFirestore.instance.collection('users');
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
                    String id=DateTime.now().millisecondsSinceEpoch.toString();

                    firestore.doc(id).set({
                    'Title':postController.text.toString(),
                      'id':id
                    }).then((value) {

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

                  })
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/constraints.dart';
import 'package:quizz_app/ui/Firestore/fireStore_addData.dart';
import 'package:quizz_app/ui/Post/add_post.dart';
import 'package:quizz_app/ui/auth/login_screen.dart';
import 'package:quizz_app/utils/utils.dart';

class FireStoreListScreen extends StatefulWidget {
  const FireStoreListScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreListScreen> createState() => _FireStoreListScreenState();
}

class _FireStoreListScreenState extends State<FireStoreListScreen> {
  FirebaseAuth auth=FirebaseAuth.instance;
  final firestore=FirebaseFirestore.instance.collection('users').snapshots();
  final ref=FirebaseFirestore.instance.collection('users');

  final editController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        centerTitle: true,
        backgroundColor: baseColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: (){
                  auth.signOut().then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });

                },
                child: Icon(Icons.logout)),
          )

        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder:(context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.connectionState==ConnectionState.waiting)
                  return CircularProgressIndicator();
                if(snapshot.hasError)
                  return Text('Some error');
                return  Expanded(
                    child:  ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder:(context,index){
                          String title=snapshot.data!.docs[index]['Title'].toString();
                          String id=snapshot.data!.docs[index]['id'].toString();
                          return ListTile(

                            title: Text(snapshot.data!.docs[index]['Title'].toString()),
                            subtitle:Text(snapshot.data!.docs[index]['id'].toString()) ,
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context)=>[
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: (){
                                        Navigator.pop(context);
                                        showMyDialog(title,id);
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    )
                                ),
                                PopupMenuItem(
                                    value: 2,
                                    child: ListTile(
                                      onTap: (){
                                        Navigator.pop(context);
                                        ref.doc(id).delete();
                                      },
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete'),
                                    )
                                )
                              ],
                            ),
                          );
                        }

                    )

                );

              }

          ),



        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: baseColor,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FireStoreAddData()));
        },
        child: Icon(Icons.add),
      ),
    );

  }
  Future<void> showMyDialog(String title,String id)async{
    return showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextFormField(
                controller: editController,
              ),
            ),
            actions: [
              TextButton(onPressed:(){
                Navigator.pop(context);
                ref.doc(id).update({
                  'Title':editController.text.toString()
                }).then((value) {
                  Utils().toastMessage('Post Updated');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });

              }, child: Text('Update')),
              TextButton(onPressed:(){
                Navigator.pop(context);
              }, child: Text('Cancel'))
            ],
          );
        }
    );
  }
}

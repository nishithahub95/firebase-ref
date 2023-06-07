
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/constraints.dart';
import 'package:quizz_app/ui/Post/add_post.dart';
import 'package:quizz_app/ui/auth/login_screen.dart';
import 'package:quizz_app/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  FirebaseAuth auth=FirebaseAuth.instance;
  final ref=FirebaseDatabase.instance.ref('Post');
  final searchController=TextEditingController();
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
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: searchController,
              decoration:const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder()
              ),
              onChanged: (String value){
                setState(() {


                });

              },
            ),
          ),
    //       Expanded(child: StreamBuilder(
    //         stream: ref.onValue,
    //         builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
    //           if(!snapshot.hasData){
    //             return CircularProgressIndicator();
    //           }else{
    //             Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic;
    //             List<dynamic> list=[];
    //             list.clear();
    //             list=map.values.toList();
    //             return ListView.builder(
    //                 itemCount: snapshot.data!.snapshot.children.length,
    //                 itemBuilder:(context,index){
    //                   return ListTile(
    //                       title: Text(list[index]['title']),
    //                     subtitle:Text(list[index]['id']) ,
    //                   );
    //                 }
    //
    //             );
    //           }
    //
    // }
    //
    //       )),
          Expanded(
            child: FirebaseAnimatedList(query: ref,
                defaultChild: Text('No data'),
                itemBuilder: (context,snapshot,index,animation){
              final title=snapshot.child('Title').value.toString();
              final id=snapshot.child('Id').value.toString();
              if(searchController.text.isEmpty){
                return   ListTile(
                  title: Text(snapshot.child('Title').value.toString()),
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
                              ref.child(id).remove();
                            },
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                          )
                      )
                    ],
                  ),
                );
              }else if(title.toLowerCase().contains(searchController.text.toLowerCase())){

                return   ListTile(

                  title: Text(snapshot.child('Title').value.toString()),
                );
              }

              else{
                    return Container();
              }

                }),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: baseColor,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPostScreen()));
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
           ref.child(id).update({
           'title':editController.text.toString()
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

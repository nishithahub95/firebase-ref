

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizz_app/ui/Screen/Widget/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:quizz_app/utils/utils.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool loading=false;
  File? _image;
  final picker=ImagePicker();
 firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef= FirebaseDatabase.instance.ref('Post') ;//store tthe downloaded url in firebase realtime database name 'Post'
  Future getGallaryImage()async{

      final pickedFile = await picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
      setState(() {
        if(pickedFile != null){
          _image = File(pickedFile.path);
        }else {
          print('no image picked');
        }
      });

    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text('Upload Image'),
        backgroundColor: Color(0xff2980B9),
      ),
      body: Column(
        children: [
          Center(
            child: InkWell(
              onTap: (){
              getGallaryImage();
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black
                    )
                ),
            child: _image != null ? Image.file(_image!.absolute) :     //Show the image in front end
                Center(child: Icon(Icons.image)),
              ),
            ),
          ),
          SizedBox(height: 39,),
          RoundButton(title: 'Upload',loading: loading, onTap: ()async{
            setState(() {
              loading=true;
            });
            firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/myFolder/'+DateTime.now().millisecondsSinceEpoch.toString());//'/'is used for create a folder else it create a file
            firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

            Future.value(uploadTask).then((value)async{

              var newUrl = await ref.getDownloadURL();

              databaseRef.child('1').set({
                'id' : '1212' ,
                'title' : newUrl.toString()
              }).then((value){
                setState(() {
                  loading = false ;
                });
                Utils().toastMessage('uploaded');

              }).onError((error, stackTrace){
                print(error.toString());
                setState(() {
                  loading = false ;
                });
              });
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
              setState(() {
                loading = false ;
              });
            });

          })
        ],
      ),
    );
  }
}

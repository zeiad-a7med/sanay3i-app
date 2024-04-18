import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'home.dart';
import 'login.dart';

class Register extends StatefulWidget{
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController n1 = TextEditingController();
  TextEditingController n2 = TextEditingController();
  TextEditingController n3 = TextEditingController();
  TextEditingController n4 = TextEditingController();
  dynamic user,email,phone,pass,imagePath = "No Image";
  dynamic PickedImage;
  UploadTask? uploadTask;


  String? get _errorUser{
    if(user.isEmpty){
      return "Can't be Empty";
    }
    if(user.length < 4){
      return "Too Short";
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {

    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;

    user = n1.value.text;
    email = n2.value.text;
    pass = n3.value.text;
    phone = n4.value.text;
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 800,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                width: ScreenWidth/1.15,
                height: 80,
                child: Image.asset("assets/appicon/maintenance.png"),
              ),
              Container(
                width: ScreenWidth/1.15,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child:Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Sanay3i",
                    style: TextStyle(fontSize: 65,color: Colors.orange,fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                height: 100,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 100,
                    child: TextField(
                      onChanged: (user) => setState(() => n1),
                      controller: n1,
                      decoration: InputDecoration(
                        label: Text("User Name",style: TextStyle(fontSize: 20),),
                        fillColor: Colors.white,
                        filled: true,
                        border:OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        errorText: _errorUser
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 100,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (email) => setState(() => n2),
                      controller: n2,
                      decoration: InputDecoration(
                          label: Text("Email",style: TextStyle(fontSize: 20),),
                          fillColor: Colors.white,
                          filled: true,
                          border:OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          errorText: validateEmail

                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 100,
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'\d')),
                      ],
                      keyboardType: TextInputType.number,
                      onChanged: (phone) => setState(() => n2),
                      controller: n4,
                      decoration: InputDecoration(
                          label: Text("Phone",style: TextStyle(fontSize: 20),),
                          fillColor: Colors.white,
                          filled: true,
                          border:OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          errorText: validatePhone
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 100,
                    child: TextField(
                      obscureText: true,
                      onChanged: (pass) => setState(() => n3),
                      controller: n3,
                      decoration: InputDecoration(
                        label: Text("Password",style: TextStyle(fontSize: 20),),
                        fillColor: Colors.white,
                        filled: true,
                        border:OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        errorText: validatePassword
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 80,
                child: Center(
                  child: Container(
                    width: 250,
                    height: 50,
                    child: (imagePath != "No Image")?Image.file(File(imagePath)):ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.orange
                      ),
                      onPressed: () async {
                        ImagePicker xx = new ImagePicker();
                        dynamic y = await xx.getImage(source: ImageSource.gallery);
                        setState(() {
                          imagePath = y.path;
                          PickedImage=y;
                        });
                      },
                      child: Text("Take a Picture", style: TextStyle(fontSize: 20),),
                    ),
                  ),
                )
              ),
              Container(
                width: 200,
                height: 50,
                child: Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.orange
                      ),
                      onPressed: () async {
                        if(_errorUser == null && validateEmail == null && validatePhone == null && validatePassword == null && imagePath != "No Image"){
                          //upload data to firebase
                          uploadUserData(user,phone,imagePath,email,pass);

                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),

                )
              ),
              Container(
                width:ScreenWidth,
                height:70,
                child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Text("Have Account?",style: TextStyle(fontSize: 17,color:Colors.blueAccent.shade700),),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
  void uploadUserData(String user,String phone,String imagePath,String email,String pass)async{

    final file = File(imagePath);
    final path ='files/users/profiles/${email}.jpg';

    final ref =FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask=ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete((){});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('download link ${urlDownload}');

    FirebaseFirestore.instance.collection("users").add(
        <String,dynamic>{
          "userId":"",
          "userName":user,
          "phone":phone,
          "img":'${urlDownload}',
          "email":email,
          "password":pass
        }
    );
    //to get id form firebaseStore
    bool found=false;
    dynamic userId;
    dynamic snapdata = await FirebaseFirestore.instance.collection("users").get();
    for(int i=0;i<snapdata.docs.length;i++){
      if(snapdata.docs[i]["email"]==email && snapdata.docs[i]["password"]==pass){
        found=true;
        userId=snapdata.docs[i].id;
        break;
      }
    }
    if(found){

      FirebaseFirestore.instance.collection("users").doc('${userId}').update({
        'userId' : userId
      });


      final prefs= await SharedPreferences.getInstance();
      prefs.setString('userName',user );
      prefs.setString('userId',userId );
      prefs.setString('userImage','${urlDownload}' );
      prefs.setString('userEmail',email );
      prefs.setString('userPhone',phone );
      prefs.setString('userLocation',"set your location");
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(0, userId,user,'${urlDownload}',email,phone,"set your location")));
    }
    //

  }

  String? get validatePassword {
    String missings = "";
    String? value = n3.text;
    if(value!.length ==0){
      missings += "Password can't be empty\n";
    }
    if(value!.length >0){
      if (value!.length < 8) {
        missings += "Password has at least 8 characters\n";
      }
      if (value!.length >= 8) {
        if (!RegExp((r'\d')).hasMatch(value)) {
          missings += "Password must contain at least one digit\n";
        }
      }
    }
    //if there is password input errors return error string
    if (missings != "") {
      return missings;
    }

    //success
    return null;
  }
  String? get validateEmail{
    String missing = "";
    String? value = n2.text;
    if(value!.length == 0){
      missing += "Email can't be empty\n";
    }
    if(value!.length > 0){
      if(!RegExp((r'^([a-z0-9]{3,})[@](gmail|hotmail|yahoo)[.]([c][o][m]|[n][e][t])$')).hasMatch(value)){
        missing += "Email isn't correct\n";
      }
    }

    if(missing != ""){
      return missing;
    }

    return null;

  }
  String? get validatePhone{
    String missing = "";
    String? value = n4.text;
    if(value!.length == 0){
      missing += "Phone can't be empty\n";
    }
    if(value!.length > 0){
      if(!RegExp((r'^([0][1][0|1|2|5][0-9]{8})$')).hasMatch(value)){
        missing += "Phone isn't correct\n";
      }
    }

    if(missing != ""){
      return missing;
    }

    return null;

  }


}


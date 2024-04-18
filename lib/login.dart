import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'register.dart';


class Login extends StatefulWidget{

  @override
  State<Login> createState() => _LoginState();


}

class _LoginState extends State<Login> {
  int isLogged=2;
  TextEditingController n1 = TextEditingController();
  TextEditingController n2 = TextEditingController();
  dynamic email,pass,user,img,phone,userId="";

  @override
  Widget build(BuildContext context) {


    Future<void> getUserName()async{
      final prefs= await SharedPreferences.getInstance();
      if(prefs.get('userName')==null){
        isLogged=0;
      }else{
        final user= prefs.get('userName');
        final userImage= prefs.get('userImage');
        final userId= prefs.get('userId');
        final email= prefs.get('userEmail');
        final phone = prefs.get('userPhone');
        final myLoc= prefs.get('userLocation');
        isLogged=1;
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(0,userId,user,userImage,email,phone,myLoc)));
      }

    }
    getUserName();

    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;

    email = n1.value.text;
    pass = n2.value.text;
    return Scaffold(
      body: Center(
        child: Container(
          width: ScreenWidth,
          height: 720,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                width: ScreenWidth/1.15,
                height: 100,
                child: Image.asset("assets/appicon/maintenance.png"),
              ),
              Container(
                width: ScreenWidth/1.15,
                height: 170,
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
                    width: ScreenWidth/1.15,
                    height: 100,
                    child: TextField(
                      onChanged: (email) => setState(() => n1),
                      controller: n1,
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
                    width: ScreenWidth/1.15,
                    height: 100,
                    child: TextField(
                      obscureText: true,
                      onChanged: (email) => setState(() => n2),
                      controller: n2,
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
                width: 200,
                height: 60,
                child: Center(
                  child: Container(
                    width: 200,
                    height: 60,
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.orange
                      ),
                      onPressed: ()async{
                        if(validateEmail == null && validatePassword == null ){
                          bool found=false;
                          dynamic snapdata = await FirebaseFirestore.instance.collection("users").get();
                          for(int i=0;i<snapdata.docs.length;i++){
                              if(snapdata.docs[i]["email"]==email && snapdata.docs[i]["password"]==pass){
                                found=true;
                                user=snapdata.docs[i]["userName"];
                                img=snapdata.docs[i]["img"];
                                email=snapdata.docs[i]["email"];
                                phone=snapdata.docs[i]["phone"];
                                userId=snapdata.docs[i]["userId"];
                                break;
                              }
                          }
                          if(found){
                            final prefs= await SharedPreferences.getInstance();
                            prefs.setString('userName',user );
                            prefs.setString('userId',userId );
                            prefs.setString('userImage',img );
                            prefs.setString('userEmail',email );
                            prefs.setString('userPhone',phone );
                            prefs.setString('userLocation',"set your location");
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Home(0,userId,user,img,email,phone,"set your location")));

                          }else{
                            n1.text="";
                            n2.text="";
                          }
                        }
                      },
                      child: Text(
                        "Login",
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
                    child: Text("Don't Have Account?",style: TextStyle(fontSize: 17,color:Colors.blueAccent.shade700),),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
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

  String? get validatePassword {
    String missings = "";
    String? value = n2.text;
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
    String? value = n1.text;
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
}


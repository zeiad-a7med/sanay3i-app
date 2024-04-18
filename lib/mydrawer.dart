import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanayee/covid.dart';
import 'package:sanayee/mywallet.dart';
import 'package:sanayee/privacyPolicy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class MyDrawer extends StatelessWidget{

  dynamic img="";
  dynamic userName="";
  MyDrawer(this.userName,this.img);
  Widget build(BuildContext context) {

    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;//width of the screen

    return Drawer(
      width: ScreenWidth,
      child: Stack(
        children: [
          ListView(
            children: [
              Container(
                  height: 50,
                  width: ScreenWidth
              ),

              Container(
                  width: ScreenWidth,
                  height: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        backgroundColor: Colors.white
                    ),
                    onPressed:(){},
                    child: Row(
                      children: [
                        Container(
                          width:ScreenWidth/3,
                          height: 160,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: ScreenWidth/4,
                              height: ScreenWidth/4,
                              decoration:BoxDecoration(
                                image: DecorationImage(
                                  image: Image.network(img).image,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(65),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width:ScreenWidth/2,
                          height: 160,

                          child: Align(
                              alignment: Alignment.centerLeft,
                              child:Text('${userName}',style: TextStyle(color:Colors.black,fontSize: 25,),)
                          ),

                        ),
                        Container(
                          width: ScreenWidth/6,
                          height: 160,
                          child: Align(
                            alignment: Alignment.center,
                          ),
                        )
                      ],
                    ),
                  )
              ),

              Divider(
                color: Colors.grey.shade200,
                height: 0,
                thickness: 1,
              ),

              Container(
                  height:50,
                  width: ScreenWidth,
                  color: Colors.white70,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("   Account",style: TextStyle(color: Colors.grey,fontSize: 15),),
                  )
              ),
              ListTile(
                tileColor: Colors.white70,
                leading: Icon(Icons.wallet,color: Colors.black,),
                title:Text("My Wallet",style: TextStyle(fontSize: 17,color: Colors.black),),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyWallet()));

                },
              ),
              Divider(
                color: Colors.grey.shade200,
                height: 0.5,
                thickness: 1,
              ),

              Container(
                  height:50,
                  width: ScreenWidth,
                  color: Colors.white70,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("   General",style: TextStyle(color: Colors.grey,fontSize: 15),),
                  )
              ),

              ListTile(
                tileColor: Colors.white70,
                leading: Icon(Icons.health_and_safety,color: Colors.black,),
                title:Text("Covid-19 Safty",style: TextStyle(fontSize: 17,color: Colors.black),),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Covid()));
                },
              ),
              Divider(
                color: Colors.grey.shade200,
                height: 0.5,
                thickness: 1,
              ),

              Container(
                  height:50,
                  width: ScreenWidth,
                  color: Colors.white70,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("   Legal",style: TextStyle(color: Colors.grey,fontSize: 15),),
                  )
              ),
              ListTile(
                tileColor: Colors.white70,
                leading: Icon(Icons.lock,color: Colors.black,),
                title:Text("Privacy policy",style: TextStyle(fontSize: 17,color: Colors.black),),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));

                },
              ),
              Divider(
                color: Colors.grey.shade200,
                height: 0.5,
                thickness: 1,
              ),

              Container(
                  height:50,
                  width: ScreenWidth,
                  color: Colors.white70,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("   Log",style: TextStyle(color: Colors.grey,fontSize: 15),),
                  )
              ),

              ListTile(
                tileColor: Colors.white70,
                leading: Icon(Icons.logout,color: Colors.black,),
                title:Text("LogOut",style: TextStyle(fontSize: 17,color: Colors.black),),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                onTap: () async {
                  final prefs= await SharedPreferences.getInstance();
                  prefs.remove('userName');
                  prefs.remove('userEmail');
                  prefs.remove('userphone');
                  prefs.remove('userImage');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => Login()),
                          (Route<dynamic> route) => false
                  );

                },
              ),
              Divider(
                color: Colors.grey.shade200,
                height: 5,
                thickness: 8,
              ),

            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child:Container(
                height: 75,
                width: ScreenWidth,
                color: Colors.black,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Container(
                          width:10,
                          height:50
                      ),
                      Container(
                          width:ScreenWidth/4,
                          height:50,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Menu",style: TextStyle(fontSize: 28,color: Colors.white),)

                          )
                      ),
                      Container(
                        width:ScreenWidth/2-10,
                        height:50,
                      ),
                      Container(
                          width:ScreenWidth/4,
                          height:50,
                          child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(Icons.close,color: Colors.white),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                iconSize: 40,
                              )

                          )
                      )

                    ],
                  ),
                )
            ),

          ),
        ],
      )
    );
  }
}
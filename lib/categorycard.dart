import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services.dart';
import 'setmylocation.dart';
class CategoryCard extends StatelessWidget{
  String name="";
  String img="";
  String userLoc="";
  CategoryCard(this.name,this.img,this.userLoc);
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;
    return Container(
        width: ScreenWidth/4,
        height: ScreenWidth/4,
        child:ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white
            ),
            onPressed:() async {

              final prefs= await SharedPreferences.getInstance();
              if(prefs.getString('userLocation')=="set your location"){
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Please Set Your Location'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                          dynamic userId,userName,img,email,phone,myLoc;
                          userId=prefs.get('userId');
                          userName=prefs.get('userName');
                          img=prefs.get('userImage');
                          email=prefs.get('userEmail');
                          phone=prefs.get('userPhone');
                          myLoc=prefs.get('userLocation');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SetmyLocation(userId,userName,img,email,phone,myLoc)));
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Services(name,img,userLoc)),
                );
              }
            } ,
            child:Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(10),
                  child: Image.asset("assets/homeicons/${img}", width: ScreenWidth/9, height:ScreenWidth/9),
                ),
                Padding(
                    padding:EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text("${name}",style: TextStyle(color:Colors.black,fontSize: 12),textAlign: TextAlign.center, maxLines: 2,)
                )
              ],
            )
        )
    )
    ;
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanayee/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mydrawer.dart';
import 'myorders.dart';
import 'servicecard.dart';
import 'pickdate.dart';
import 'home.dart';
import 'setmylocation.dart';
class Search extends StatefulWidget{
  String category="";
  String iconImg="";
  String userLoc="";
  dynamic pageIndex,userId,userName,img,email,phone,myLoc;
  Search(this.pageIndex,this.userId,this.userName,this.img,this.email,this.phone,this.myLoc);
  @override
  State<Search> createState() => _SearchState(pageIndex,userId,userName,img,email,phone,myLoc);
}

class _SearchState extends State<Search> {
  String category="";
  String iconImg="";
  String userLoc="";
  dynamic pageIndex,userId,userName,img,email,phone,myLoc;
  String selectedService="";
  int? selectedIndex;
  _SearchState(this.pageIndex,this.userId,this.userName,this.img,this.email,this.phone,this.myLoc);
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50, // Set this height
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    side: const BorderSide(
                        width: 0, // the thickness
                        color: Colors.black  // the color of the border
                    )
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SetmyLocation(userId,userName,img,email,phone,myLoc)));

                },
                child:Container(
                  width: ScreenWidth/2.3,
                  child: Column(
                    children: [
                      Container(
                          width: ScreenWidth/2.3,
                          child: Text("Current Location ⤵",textAlign: TextAlign.left,style: TextStyle(color:Colors.yellow.shade800,fontWeight: FontWeight.bold,fontSize: 17),)
                      ),
                      Container(
                        width: ScreenWidth/2.3,
                        child: Text(myLoc,textAlign: TextAlign.left,style: TextStyle(color:Colors.white,fontSize: 15), softWrap: false, maxLines: 1, overflow: TextOverflow.fade,),
                      )

                    ],
                  ),
                )
            ),
          ],
          backgroundColor: Colors.black,
        ),
        drawer: MyDrawer(userName,img),

        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon:Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.inventory),
              label: "My Orders",
            ),
          ],
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          iconSize: 30,
          currentIndex: pageIndex,
          onTap: (value){
            setState(() {
              pageIndex=value;
              if(value==0){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home(pageIndex,userId,userName,img,email,phone,myLoc)));
              }else if(value==1){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Search(pageIndex,userId,userName,img,email,phone,myLoc)));
              }else if(value==2){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders(pageIndex,userId,userName,img,email,phone,myLoc)));
              }
            });
          },
        ),
        body: Center(
            child:Stack(
              children: [
                ListView(
                  children: [

                    Container(
                      height:deviceInfo.size.height-190,
                      width: ScreenWidth,
                      child: FutureBuilder(
                        future: mydb.rawQuery("SELECT * FROM services;"),
                        builder:(context, AsyncSnapshot snapshot){
                          if(snapshot.hasData==true){

                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder:(context,i){
                                  return Container(
                                    width: ScreenWidth,
                                    height: 115,
                                    decoration: BoxDecoration(
                                        border:Border(
                                          top: BorderSide(width: 1, color: Colors.grey.shade300),
                                          bottom: BorderSide(width: 1, color: Colors.grey.shade300),
                                        )
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            width: ScreenWidth/4-20,
                                            height: 90,
                                            decoration:BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage("${snapshot.data[i]["img"]}"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(15),
                                              ),
                                            ),

                                          ),
                                        ),
                                        Container(
                                            width:ScreenWidth/2,
                                            height: 115,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                              child: Text("${snapshot.data[i]["service"]}",style: TextStyle(color:Colors.black,fontSize: 20,),softWrap: false, maxLines: 2, overflow: TextOverflow.fade,),
                                            )

                                        ),
                                        Container(
                                          width:ScreenWidth/4,
                                          height: 115,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                                height:40, //height of button
                                                width:ScreenWidth/5 , //width of button
                                                child:ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.all(0),
                                                      primary: (selectedIndex==i)?Colors.black:Colors.grey.shade300, //background color of button
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(30)
                                                      ), //content padding inside button
                                                    ),
                                                    onPressed: (){
                                                      setState(() {
                                                        selectedService=snapshot.data[i]["service"];
                                                        category=snapshot.data[i]["category"];
                                                        selectedIndex=i;
                                                        iconImg="${category}.png";
                                                      });
                                                    },
                                                    child: Text("Add",style: TextStyle(color: (selectedIndex==i)?Colors.white:Colors.black,fontSize: 17,fontWeight: FontWeight.w400),)
                                                )
                                            ),
                                          ),
                                        )

                                      ],
                                    ),
                                  );
                                },
                              );

                          }
                          else{
                            return Text("no services");
                          }

                        },
                      ),
                    ),

                    Container(
                      color: Colors.black,
                        height: 190,
                        width:ScreenWidth
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      color: Colors.white,
                      width:ScreenWidth,
                      height:60,
                      child:Align(
                          alignment: Alignment.topCenter,
                          child:Container(
                            color: Colors.white,
                            width: ScreenWidth-30,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black, //background color of button
                                  shape: RoundedRectangleBorder( //to set border radius to button
                                      borderRadius: BorderRadius.circular(5)
                                  ), //content padding inside button
                                ),
                                onPressed:(selectedService=="")?null:()async{

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
                                  }
                                  else{
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PickDate(iconImg,category,selectedService,userLoc)));
                                  }

                                },
                                child: Text("Proceed to Pick Date and Time",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),)
                            ) ,
                          )
                      )
                  ),
                )
              ],
            )
        )
    );
  }
}
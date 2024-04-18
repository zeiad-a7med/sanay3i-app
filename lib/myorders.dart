import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanayee/main.dart';
import 'acceptedOrder.dart';
import 'mydrawer.dart';
import 'search.dart';
import 'servicecard.dart';
import 'pickdate.dart';
import 'home.dart';
import 'setmylocation.dart';
class MyOrders extends StatefulWidget{
  String category="";
  String iconImg="";
  String userLoc="";
  dynamic pageIndex,userId,userName,img,email,phone,myLoc;
  MyOrders(this.pageIndex,this.userId,this.userName,this.img,this.email,this.phone,this.myLoc);
  @override
  State<MyOrders> createState() => _MyOrdersState(pageIndex,userId,userName,img,email,phone,myLoc);
}

class _MyOrdersState extends State<MyOrders> {
  String category="";
  String iconImg="";
  String userLoc="";
  dynamic pageIndex,userId,userName,img,email,phone,myLoc;
  String selectedService="";
  int? selectedIndex;



  _MyOrdersState(this.pageIndex,this.userId,this.userName,this.img,this.email,this.phone,this.myLoc);
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
            child:RefreshIndicator(
              color: Colors.orange,
              strokeWidth: 5,
              edgeOffset: 20,

              onRefresh:()async{
                setState(() {

                });
              },
              child:FutureBuilder(
                future: FirebaseFirestore.instance.collection("requests").get(),
                builder:(context, AsyncSnapshot snapshot){
                  bool foundOrders=false;

                  if(snapshot.data.docs.length==0){
                    return ListView(
                      children: [
                        Container(
                          width: ScreenWidth,
                          height:deviceInfo.size.height,
                          child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: ScreenWidth,
                                child: Column(
                                  children: [
                                    Icon(Icons.priority_high,color: Colors.grey,size: 400,),
                                    Text("There Is No Orders",style: TextStyle(color: Colors.grey,fontSize: 30),)
                                  ],
                                ),
                              )
                          ),
                        )
                      ],
                    );
                  }
                  else{
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder:(context,i){
                          if(snapshot.data.docs[i]["userId"]==userId){
                            foundOrders=true;
                            return Container (
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
                                          image: Image.asset("assets/homeicons/${snapshot.data.docs[i]["category"]}.png",).image,
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
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 57.5,
                                            width: ScreenWidth/2,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                              child: Text("${snapshot.data.docs[i]["selectedService"]}",style: TextStyle(color:Colors.black,fontSize: 17,),softWrap: false, maxLines: 2, overflow: TextOverflow.fade,),
                                            ),
                                          ),
                                          Container(
                                            height: 25,
                                            width: ScreenWidth/2,
                                            child: Text("${snapshot.data.docs[i]["selectedDayName"]},${snapshot.data.docs[i]["selectedDay"]} ${snapshot.data.docs[i]["selectedMonth"]}  ${snapshot.data.docs[i]["selectedTime"]}:00",style: TextStyle(color:Colors.black,fontSize: 15,),softWrap: false, maxLines: 2, overflow: TextOverflow.fade,),
                                          ),
                                          Container(
                                            height: 25,
                                            width: ScreenWidth/2,
                                            child: Text("${snapshot.data.docs[i]["state"]}",style: TextStyle(color:(snapshot.data.docs[i]["state"]=="Not Accepted Yet"||snapshot.data.docs[i]["state"]=="Rejected")?Colors.red:Colors.green,fontSize: 12,),softWrap: false, maxLines: 2, overflow: TextOverflow.fade,),
                                          ),
                                        ],
                                      )

                                  ),
                                  Container(
                                    width:ScreenWidth/4,
                                    height: 115,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child:(snapshot.data.docs[i]["state"]=="Rejected")?SizedBox(
                                          height:40, //height of button
                                          width:ScreenWidth/5 , //width of button
                                          child:ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(0),
                                                primary:Colors.red, //background color of button
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(30)
                                                ), //content padding inside button
                                              ),
                                              onPressed:(){
                                                dynamic requestId =snapshot.data.docs[i]["requestId"];

                                                FirebaseFirestore.instance.collection("requests").doc('${requestId}').delete();
                                                setState(() {

                                                });

                                              },
                                              child: Text("Cancel",style: TextStyle(color:Colors.white,fontSize: 17,fontWeight: FontWeight.w400),)
                                          )
                                      ):SizedBox(
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
                                              onPressed:(snapshot.data.docs[i]["state"]=="Not Accepted Yet")?null:(){

                                                dynamic sanayeeId =snapshot.data.docs[i]["sanayeeId"];
                                                dynamic requestId =snapshot.data.docs[i]["requestId"];
                                                dynamic category =snapshot.data.docs[i]["category"];
                                                dynamic userLoc =snapshot.data.docs[i]["userLoc"];
                                                dynamic selectedService =snapshot.data.docs[i]["selectedService"];
                                                dynamic selectedMonth =snapshot.data.docs[i]["selectedMonth"];
                                                dynamic selectedDay =snapshot.data.docs[i]["selectedDay"];
                                                dynamic selectedDayName =snapshot.data.docs[i]["selectedDayName"];
                                                dynamic selectedTime =snapshot.data.docs[i]["selectedTime"];
                                                dynamic description =snapshot.data.docs[i]["description"];
                                                dynamic state =snapshot.data.docs[i]["state"];


                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AcceptedOrder(requestId,sanayeeId,category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description,state)));
                                              },
                                              child: Text("View",style: TextStyle(color: (snapshot.data.docs[i]["state"]=="Not Accepted Yet"||snapshot.data.docs[i]["state"]=="Rejected")?Colors.grey:Colors.black,fontSize: 17,fontWeight: FontWeight.w400),)
                                          )
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            );
                          }else{
                            if(!foundOrders&&snapshot.data.docs.length==i-1){
                              return ListView(
                                children: [
                                  Container(
                                    width: ScreenWidth,
                                    height:deviceInfo.size.height,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: ScreenWidth,
                                          child: Column(
                                            children: [
                                              Icon(Icons.priority_high,color: Colors.grey,size: 400,),
                                              Text("There Is No Orders",style: TextStyle(color: Colors.grey,fontSize: 30),)
                                            ],
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              );
                            }else{
                              return Container();
                            }
                          }
                        },
                      );
                    }else{
                      return Text("no services");

                    }

                  }
                },
              ),

            )

        )
    );
  }
}
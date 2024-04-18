import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanayee/myorders.dart';
import 'package:sanayee/search.dart';
import 'package:sanayee/setmylocation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'categorycard.dart';
import 'mydrawer.dart';

class Home extends StatefulWidget{
  dynamic pageIndex,userId,userName,userImage,email,phone,userLoc;

  Home(this.pageIndex,this.userId,this.userName,this.userImage,this.email,this.phone,this.userLoc);
  @override
  State<Home> createState() => _HomeState(pageIndex,userId,userName,userImage,email,phone,userLoc);

}


class _HomeState extends State<Home> {
  dynamic pageIndex;
  dynamic img,userName,userId,email,phone,myLoc;

  _HomeState(this.pageIndex,this.userId,this.userName,this.img,this.email,this.phone,this.myLoc);

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
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child:Text("Choose Categories",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 17),)
              ),
              Row(
                children: [
                  CategoryCard("Emergency","Emergency.png",myLoc),
                  CategoryCard("AC","AC.png",myLoc),
                  CategoryCard("Cleaning","Cleaning.png",myLoc),
                  CategoryCard("Electricity","Electricity.png",myLoc)
                ],
              ),
              Row(
                children: [
                  CategoryCard("Appliances","Appliances.png",myLoc),
                  CategoryCard("Plumbing","Plumbing.png",myLoc),
                  CategoryCard("Networks","Networks.png",myLoc),
                  CategoryCard("Grass","Grass.png",myLoc),
                ],
              ),
              Row(
                children: [
                  CategoryCard("Carpentry","Carpentry.png",myLoc),
                  CategoryCard("Painting","Painting.png",myLoc),
                  CategoryCard("Flooring","Flooring.png",myLoc),
                  CategoryCard("Pest Control","Pest Control.png",myLoc),
                ],
              ),
              Row(
                children: [
                  CategoryCard("Sterilization","Sterilization.png",myLoc),
                  CategoryCard("Swimming Pool","Swimming Pool.png",myLoc),
                ],
              ),
            ],
          ),
        )
    );
  }

}
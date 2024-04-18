import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sanayee/donerequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcceptedOrder extends StatefulWidget{
  dynamic requistId,sanayeeId,category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description,state;
  AcceptedOrder(this.requistId,this.sanayeeId,this.category,this.userLoc,this.selectedService,this.selectedMonth,this.selectedDay,this.selectedDayName,this.selectedTime,this.description,this.state);

  @override
  State<AcceptedOrder> createState() => _AcceptedOrderState(requistId,sanayeeId,category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description,state);
}

class _AcceptedOrderState extends State<AcceptedOrder> {
  dynamic requistId,sanayeeId,category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description,state;

  dynamic email,pass,img,phone,status,sanayeeCategory,sanayeeName,lat,long;
  dynamic Loc=LatLng(30.01,31.239);
  int changestate=0;

  List<Marker> markers=[];
  List<Circle> circles=[];

  _AcceptedOrderState(this.requistId,this.sanayeeId,this.category,this.userLoc,this.selectedService,this.selectedMonth,this.selectedDay,this.selectedDayName,this.selectedTime,this.description,this.state);
  @override
  Widget build(BuildContext context) {


    getSanayeeData() async {
      dynamic snapdata = await FirebaseFirestore.instance.collection("sanayee").get();
      for(int i=0;i<snapdata.docs.length;i++){
        if(snapdata.docs[i]["sanayeeId"]==widget.sanayeeId){
          sanayeeName=snapdata.docs[i]["sanayeeName"];
          sanayeeCategory=snapdata.docs[i]["category"];
          status=snapdata.docs[i]["status"];
          lat=snapdata.docs[i]["lat"];
          long=snapdata.docs[i]["long"];
          img=snapdata.docs[i]["img"];
          email=snapdata.docs[i]["email"];
          phone=snapdata.docs[i]["phone"];
          markers.add(
              Marker(
                onTap: (){
                },
                markerId: MarkerId("${i}"),
                position: LatLng(
                    snapdata.docs[i]["lat"], snapdata.docs[i]["long"]),
                infoWindow: InfoWindow(
                  title: "${snapdata.docs[i]["sanayeeName"]}",
                ),
                icon: BitmapDescriptor.defaultMarker,
              )
          );
          circles.add(
              Circle(
                  onTap: () {},
                  circleId: CircleId("${i}"),
                  center: LatLng(snapdata.docs[i]["lat"],snapdata.docs[i]["long"]),
                  fillColor:Colors.blue.withOpacity(0.3),

                  radius: 800,
                  strokeWidth: 2,
                  strokeColor: Colors.orange
              )
          );
          setState(() {
            Loc=LatLng(lat, long);
            changestate=1;
          });
          break;
        }
      }
    }
    getSanayeeData();


    MediaQueryData deviceInfo = MediaQuery. of(context);
    double ScreenWidth= deviceInfo.size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50, // Set this height
          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,),
            onPressed:() => Navigator.pop(context, false),
          ),
          title: Text("Order Details"),
          backgroundColor: Colors.black,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FlutterPhoneDirectCaller.callNumber("${phone}");
          },
          child: Icon(Icons.phone),
          backgroundColor: Colors.orange,
        ),
        body: Center(
            child:Stack(
              children: [
                ListView(
                  children: [
                    Container(
                        height: 210,
                        color: Colors.white,
                        child:Stack(
                          children: [
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black,
                            ),
                            Padding(
                              padding:EdgeInsets.fromLTRB(10, 30, 10, 0),
                              child: Container(

                                decoration:BoxDecoration(
                                    boxShadow:[
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5), //color of shadow
                                        spreadRadius: 5, //spread radius
                                        blurRadius: 7, // blur radius
                                        offset: Offset(0, 2), // changes position of shadow
                                        //first paramerter of offset is left-right
                                        //second parameter is top to down
                                      ),
                                      //you can set more BoxShadow() here
                                    ],
                                    border: Border.all(
                                        color: const Color(0xFF000000),
                                        width: 0.1,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.white//BorderRadius.all
                                ),
                                height:180,
                                width: (MediaQuery.of(context).size.width),
                                child: Column(
                                  children: [
                                    Container(
                                      height:100,
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child:Container(
                                                width: 80,height: 80,
                                                decoration:BoxDecoration(
                                                  image: DecorationImage(
                                                    image: Image.network("${img}").image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(65),
                                                  ),
                                                ),
                                              )
                                          ),
                                          Container(
                                            height: 120,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:EdgeInsets.fromLTRB(0, 30, 0,0),
                                                  child: Container(
                                                    width:ScreenWidth/2,
                                                    height: 27,
                                                    child:Text("${sanayeeName}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), softWrap: false, maxLines: 1, overflow: TextOverflow.fade,),

                                                  ),
                                                ),
                                                Padding(
                                                  padding:EdgeInsets.fromLTRB(0, 0, 0,2),
                                                  child: Container(
                                                    width:ScreenWidth/2,

                                                    child:Text("${category}",style: TextStyle(fontSize: 12,color: Colors.grey), softWrap: false, maxLines: 1, overflow: TextOverflow.fade,),

                                                  ),
                                                ),
                                                Container(
                                                  width: ScreenWidth/2,
                                                  child:Row(
                                                    children: [
                                                      Icon(Icons.star,color: Colors.yellow.shade900,),
                                                      Text("20"),
                                                      Text("(100+)",style: TextStyle(color:Colors.grey),),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child:Icon(Icons.info,color: Colors.grey,)
                                            ,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:79,
                                      child: Row(
                                        children: [
                                          Container(
                                            height:40,
                                            decoration:BoxDecoration(
                                              border: Border(
                                                right: BorderSide(color:Colors.grey),
                                              ),
                                            ),
                                            width:MediaQuery.of(context).size.width/3,
                                            child: Center(
                                              child: Padding(

                                                padding: EdgeInsets.all(0),
                                                child:Column(
                                                  children: [
                                                    Text("Deliver time",style: TextStyle(color: Colors.grey),),
                                                    Text("max 60mins"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height:40,
                                            decoration:BoxDecoration(
                                              border: Border(
                                                right: BorderSide(color:Colors.grey),
                                              ),
                                            ),
                                            width:MediaQuery.of(context).size.width/3-20,
                                            child: Center(
                                              child: Padding(

                                                padding: EdgeInsets.all(0),
                                                child:Column(
                                                  children: [
                                                    Text("Order",style: TextStyle(color: Colors.grey),),
                                                    Text("${state}",style: TextStyle(color: Colors.green),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height:40,

                                            width:MediaQuery.of(context).size.width/3-20,
                                            child: Center(
                                              child: Padding(

                                                padding: EdgeInsets.all(0),
                                                child:Column(
                                                  children: [
                                                    Text("Status",style: TextStyle(color: Colors.grey),),
                                                    Text("${status}",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 17)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                    ),


                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child:Text("Order Details",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 17),)
                    ),


                    Padding(
                      padding: EdgeInsets.fromLTRB(10,20, 10, 20),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/homeicons/${category}.png", width: 70, height:70),
                          Padding(
                              padding:EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text("${category}",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10,5, 10, 5),
                        child:Column(
                          children: [
                            Container(
                              width:ScreenWidth,
                              height: 50,
                              child: Row(
                                children: [
                                  Icon(Icons.home,color: Colors.orange,size: 30,),
                                  Padding(
                                      padding:EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text("Curret Location",style: TextStyle(color:Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: ScreenWidth,
                              height: 50,
                              child: Text("${userLoc}"),
                            ),
                            Container(
                              width: ScreenWidth,
                              height:60,
                              child: Align(
                                alignment: Alignment.center,
                                child:SizedBox(
                                    height:55, //height of button
                                    width:ScreenWidth-20 , //width of button
                                    child:ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(0),
                                          primary: Colors.grey.shade200, //background color of button
                                          shape: RoundedRectangleBorder( //to set border radius to button
                                              borderRadius: BorderRadius.circular(5)
                                          ), //content padding inside button
                                        ),
                                        onPressed:null,
                                        child: Row(
                                          children: [
                                            Container(
                                              width:ScreenWidth-60,
                                              height:55,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child:Text("${selectedService}",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w400),softWrap: false,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.fade,) ,
                                              ),
                                            ),


                                          ],
                                        )
                                    )
                                )
                                ,
                              ),
                            ),
                            Container(
                              width: ScreenWidth,
                              height:60,
                              child: Align(
                                  alignment: Alignment.center,
                                  child:Row(
                                    children: [
                                      SizedBox(
                                          height:55, //height of button
                                          width:ScreenWidth/2-10 , //width of button
                                          child:ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(0),

                                                primary: Colors.grey.shade200, //background color of button
                                                shape: RoundedRectangleBorder( //to set border radius to button
                                                    borderRadius: BorderRadius.circular(5)
                                                ), //content padding inside button
                                              ),
                                              onPressed:null,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:50,
                                                    height:55,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child:Icon(Icons.date_range,size: 20,color: Colors.black,) ,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:ScreenWidth/4-10,
                                                    height:55,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child:Text("${selectedDayName},${selectedDay} ${selectedMonth}",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w400),) ,
                                                    ),
                                                  ),


                                                ],
                                              )
                                          )
                                      ),
                                      SizedBox(
                                          height:55, //height of button
                                          width:ScreenWidth/2-10 , //width of button
                                          child:ElevatedButton(

                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(0),

                                                primary: Colors.grey.shade200, //background color of button
                                                shape: RoundedRectangleBorder( //to set border radius to button
                                                    borderRadius: BorderRadius.circular(5)
                                                ), //content padding inside button
                                              ),
                                              onPressed:null,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:50,
                                                    height:55,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child:Icon(Icons.access_time_filled,size: 20,color: Colors.black,) ,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:ScreenWidth/4-10,
                                                    height:55,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child:Text("${selectedTime}:00",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w400),) ,
                                                    ),
                                                  ),


                                                ],
                                              )
                                          )
                                      ),
                                    ],
                                  )

                              ),
                            ),
                          ],
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child:TextField(
                        maxLines: 5,
                        onChanged: null,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText:"${description}",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),



                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child:Text("sanay3i Location",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 17),)
                    ),
                    Container(
                      width:ScreenWidth,
                      height:300,
                      child:Align(
                        alignment: Alignment.center,
                        child: Container(
                          width:ScreenWidth-50,
                          height:280,
                          child:(changestate==0)?null:GoogleMap(
                            onMapCreated: (controller)  {

                            },
                            initialCameraPosition: CameraPosition(
                              target: (lat==null)?LatLng(30.04936635347326, 31.23752495928705):LatLng(lat, long),
                              zoom: 12,
                            ),
                            markers:markers.toSet(),
                            circles: circles.toSet(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width:ScreenWidth,
                      height: 50,
                    ),



                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child:Container(
                      width:ScreenWidth,
                      height:70,
                      child:Align(
                          alignment: Alignment.topCenter,
                          child:Container(
                            width: ScreenWidth/2.5-30,
                            height: 60,
                            child:ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, //background color of button
                                  shape: RoundedRectangleBorder( //to set border radius to button
                                      borderRadius: BorderRadius.circular(5)
                                  ), //content padding inside button
                                ),
                                onPressed: () async {
                                  FirebaseFirestore.instance.collection("requests").doc('${requistId}').delete();
                                  Navigator.pop(context);

                                },
                                child: Text("Cancel Order",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),)
                            ),
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanayee/services.dart';
import 'findsanayee.dart';
import 'servicecard.dart';
class OrderDetails extends StatefulWidget{
  String iconImg="";
  String category="";
  String userLoc="";
  String selectedService="";
  dynamic selectedMonth,selectedDay,selectedDayName,selectedTime;



  OrderDetails(this.iconImg,this.category,this.selectedService,this.selectedMonth,this.selectedDay,this.selectedDayName,this.selectedTime,this.userLoc);
  @override
  State<OrderDetails> createState() => _OrderDetailsState(iconImg,category,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,userLoc);
}

class _OrderDetailsState extends State<OrderDetails> {
  String iconImg="";
  String category="";
  String userLoc="";
  String selectedService="";
  String description="";
  dynamic selectedMonth,selectedDay,selectedDayName,selectedTime;

  _OrderDetailsState(this.iconImg,this.category,this.selectedService,this.selectedMonth,this.selectedDay,this.selectedDayName,this.selectedTime,this.userLoc);
  @override
  Widget build(BuildContext context) {
    TextEditingController desc=new TextEditingController();
    MediaQueryData deviceInfo = MediaQuery.of(context);
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
        body: Center(
            child:Stack(
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10,20, 10, 20),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/homeicons/${iconImg}", width: 70, height:70),
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
                                      onPressed:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Services(category, iconImg, userLoc)));
                                      },
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

                                          Container(
                                            width:40,
                                            height:55,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child:Icon(Icons.arrow_forward_ios,color: Colors.grey,) ,
                                                ),
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
                                           onPressed:(){
                                             Navigator.pop(context, false);
                                           },
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

                                               Container(
                                                 width:50,
                                                 height:55,
                                                 child: Align(
                                                   alignment: Alignment.centerRight,
                                                   child:Icon(Icons.arrow_forward_ios,color: Colors.grey,) ,
                                                 )
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
                                           onPressed:(){
                                             Navigator.pop(context, false);
                                           },
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

                                               Container(
                                                   width:50,
                                                   height:55,
                                                   child: Align(
                                                     alignment: Alignment.centerRight,
                                                     child:Icon(Icons.arrow_forward_ios,color: Colors.grey,) ,
                                                   )
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
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child:Text("add more details",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 17),)
                    ),
                    Container(
                      width: ScreenWidth,
                      height: 1,
                      color: Colors.grey.shade500,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child:TextField(
                        maxLines: 10,
                        controller: desc,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText:"Enter Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        height: 80,
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
                                onPressed: (){
                                  description=desc.text;
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FindSanayee(category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description)));
                                },
                                child: Text("Find Sanay3i",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),)
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
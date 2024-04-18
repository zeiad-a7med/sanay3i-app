import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanayee/main.dart';
import 'servicecard.dart';
import 'pickdate.dart';
class MyWallet extends StatefulWidget{

  @override
  State<MyWallet> createState() => _MyWallet();
}

class _MyWallet extends State<MyWallet> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50, // Set this height
          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,),
            onPressed:() => Navigator.pop(context, false),
          ),
          title: Text("My Wallet"),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Container(
            width: ScreenWidth,
            height:deviceInfo.size.height,
            color: Colors.grey.shade300,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: ScreenWidth-50,
                height: deviceInfo.size.height-150,
                child:Align(
                    alignment: Alignment.center,
                    child:Container(
                      width: ScreenWidth-50,
                      height: deviceInfo.size.height-250,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child:Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            height: (deviceInfo.size.height-250)/5,
                            width: ScreenWidth-50,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Total Cash Balance",style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,color: Colors.black),),
                            ),
                          ),
                          Container(
                            height: (deviceInfo.size.height-250)/5,
                            width: ScreenWidth-50,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("-EGP 40.20",style: TextStyle(fontSize:35,fontWeight:FontWeight.bold,color: Colors.red),),
                            ),
                          ),
                          Container(
                            height: (deviceInfo.size.height-250)/5,
                            width: ScreenWidth-50,
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text("please Pay The Outstanding Amount To Avoid",style: TextStyle(fontSize:15,fontWeight:FontWeight.bold,color: Colors.grey),),
                                  Text(" Getting Blocked For Cash Services",style: TextStyle(fontSize:15,fontWeight:FontWeight.bold,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: (deviceInfo.size.height-200)/3,
                            width: ScreenWidth-50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)

                            ),
                            child: Column(
                              children: [
                                Container(
                                    width: ScreenWidth-50,
                                    height: ((deviceInfo.size.height-200)/3)/2,
                                    child:Align(
                                        alignment: Alignment.center,
                                        child:Container(
                                          color: Colors.white,
                                          width: ScreenWidth-100,
                                          height: ((deviceInfo.size.height-200)/3)/2-30,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green, //background color of button
                                                shape: RoundedRectangleBorder( //to set border radius to button
                                                    borderRadius: BorderRadius.circular(25)
                                                ), //content padding inside button
                                              ),
                                              onPressed:(){},
                                              child: Text("Pay Back To Sanay3i",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),)
                                          ) ,
                                        )
                                    )

                                ),
                                Container(
                                    width: ScreenWidth-50,
                                    height: ((deviceInfo.size.height-200)/3)/2,
                                    child:Align(
                                        alignment: Alignment.center,
                                        child:Container(
                                          color: Colors.white,
                                          width: ScreenWidth-100,
                                          height: ((deviceInfo.size.height-200)/3)/2-30,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.grey.shade300, //background color of button
                                                shape: RoundedRectangleBorder( //to set border radius to button
                                                    borderRadius: BorderRadius.circular(25)
                                                ), //content padding inside button
                                              ),
                                              onPressed:(){},
                                              child: Text("Pay Out Amount",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),)
                                          ) ,
                                        )
                                    )

                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ),
              ),
            ),
          ),
        )
    );
  }
}
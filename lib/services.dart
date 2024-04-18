import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanayee/main.dart';
import 'servicecard.dart';
import 'pickdate.dart';
class Services extends StatefulWidget{
  String category="";
  String iconImg="";
  String userLoc="";
  Services(this.category,this.iconImg,this.userLoc);
  @override
  State<Services> createState() => _ServicesState(category,iconImg,userLoc);
}

class _ServicesState extends State<Services> {
  String category="";
  String iconImg="";
  String userLoc="";
  String catImg="https://tse2.mm.bing.net/th?id=OIP.AxzLZMuIJfwDHDLJOj1PzwHaDL&pid=Api&P=0";
  String selectedService="";
  int? selectedIndex;
  _ServicesState(this.category,this.iconImg,this.userLoc);
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
          title: Text("Select Service"),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child:Stack(
            children: [
              ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Image.network("${catImg}",width:ScreenWidth,height:150,fit:BoxFit.fill),
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
                  Container(
                    width: ScreenWidth,
                    height: 5,
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child:Text("Choose Service",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 17),)
                  ),
                  Container(
                    width: ScreenWidth,
                    height: 1,
                    color: Colors.grey.shade500,
                  ),
                  Container(
                    height: deviceInfo.size.height-470,
                    width: ScreenWidth,

                    child: FutureBuilder(
                      future: mydb.rawQuery("SELECT * FROM services WHERE category='${category}';"),
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
                                                    selectedIndex=i;
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
                        }else{
                          return Text("no services");
                        }
                      },
                    ),
                  ),

                 Container(
                      height: 60,
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
                          onPressed:(selectedService=="")?null:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PickDate(iconImg,category,selectedService,userLoc)));
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ServiceCard extends StatelessWidget{
  String service="";
  String img="";
  ServiceCard(this.service,this.img);
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;
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
                  image: NetworkImage("${img}"),
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
                child: Text("${service}",style: TextStyle(color:Colors.black,fontSize: 20,),softWrap: false, maxLines: 2, overflow: TextOverflow.fade,),
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
                        primary: Colors.grey.shade300, //background color of button
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ), //content padding inside button
                      ),
                      onPressed: (){
                        //code to execute when this button is pressed.
                      },
                      child: Text("Add",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w400),)
                  )
              ),
            ),
          )

        ],
      ),
    );
  }
}
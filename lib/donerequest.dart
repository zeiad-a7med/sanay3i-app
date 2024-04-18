import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'myorders.dart';
class DoneRequest extends StatelessWidget{

  dynamic userId,userName,img,email,phone,myLoc;
  DoneRequest(this.userId,this.userName,this.img,this.email,this.phone,this.myLoc);

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;
    // TODO: implement build
    return AnimatedSplashScreen(
      nextScreen: MyOrders(2,userId,userName,img,email,phone,myLoc),//redirect page
      duration: 1500,
      backgroundColor: Colors.orange,
      splash:Image.asset("assets/appicon/accept.png"),
      curve: Curves.bounceInOut,
      splashIconSize: 300,
      pageTransitionType: PageTransitionType.theme, //shape it goes to next page
      splashTransition: SplashTransition.slideTransition,//shape the image appears with
    );
  }
}
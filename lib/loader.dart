import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'login.dart';
class Loader extends StatelessWidget{
  // Will print error messages to the console.
  final String assetName = 'assets/image_that_does_not_exist.svg';
  final Widget svg = SvgPicture.asset(
    assetName,
  );

  final Widget networkSvg = SvgPicture.network(
    'https://site-that-takes-a-while.com/image.svg',
    semanticsLabel: 'A shark?!',
    placeholderBuilder: (BuildContext context) => Container(
        padding: const EdgeInsets.all(30.0),
        child: const CircularProgressIndicator()),
  );
  @override
  Widget build(BuildContext context) {

    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;
    // TODO: implement build
    return AnimatedSplashScreen(
      nextScreen: Login(),//redirect page
      duration: 1500,
      backgroundColor: Colors.orange,
      splash:Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: ScreenWidth,
              height: (deviceInfo.size.height)*2/3,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset("assets/appicon/maintenance.png",width: ScreenWidth-150,height: ScreenWidth-10,),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: ScreenWidth,
              height: (deviceInfo.size.height)/3,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Sanay3i",
                  style: TextStyle(fontSize: 85,color: Colors.white,fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
      splashIconSize: deviceInfo.size.height,
      pageTransitionType: PageTransitionType.theme, //shape it goes to next page
      splashTransition: SplashTransition.fadeTransition,//shape the image appears with
    );
  }
}
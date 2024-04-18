import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'servicecard.dart';

class SetmyLocation extends StatefulWidget{
  dynamic userId,userName,userImage,email,phone,userLoc;
  SetmyLocation(this.userId,this.userName,this.userImage,this.email,this.phone,this.userLoc);

  @override
  State<SetmyLocation> createState() => _SetmyLocationState(userId,userName,userImage,email,phone,userLoc);
}

class _SetmyLocationState extends State<SetmyLocation> {

  dynamic userId,userName,userImage,email,phone,userLoc;
  _SetmyLocationState(this.userId,this.userName,this.userImage,this.email,this.phone,this.userLoc);
  dynamic lat = 29.973664980579716;
  dynamic long = 31.09884763813549;
  dynamic loc=LatLng(29.973664980579716,31.09884763813549);
  double myZoom=12;
  double newZoom=12;
  String leadingText="Get My Location";
  List<Marker> myMark = [];
  List<Circle> myCircle = [];

  @override
  Widget build(BuildContext context) {

    dynamic DoneBtn=ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black, //background color of button
          shape: RoundedRectangleBorder( //to set border radius to button
              borderRadius: BorderRadius.circular(5)
          ), //content padding inside button
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home(0,userId,userName,userImage,email,phone,userLoc)));
        },
        child: Text("${leadingText}",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),)
    );

    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50, // Set this height
          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,),
            onPressed:() => Navigator.pop(context, false),
          ),
          title: Text("Set Your Current Location"),
          backgroundColor: Colors.black,
        ),
        body: Center(
            child:Stack(
              children: [
                GoogleMap(
                    onMapCreated: (controller) {
                      myZoom=newZoom;
                      myMark.add(
                          Marker(
                            markerId: MarkerId("0"),
                            position: loc,
                            infoWindow: InfoWindow(
                              title: "${userName}",
                              snippet: "${userLoc}",
                            ),
                            icon: BitmapDescriptor.defaultMarker,
                          )
                      );
                      myCircle.add(
                          Circle(
                              onTap: (){},
                              circleId:CircleId("0") ,
                              center: loc,
                              fillColor: Colors.blue.withOpacity(0.3),
                              radius: 800,
                              strokeWidth: 2,
                              strokeColor: Colors.orange
                          )
                      );
                    },
                    initialCameraPosition: CameraPosition(
                      target: loc,
                      zoom: myZoom,
                    ),
                    markers:myMark.toSet(),
                    circles: myCircle.toSet(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width:ScreenWidth/1.5,
                      height:70,
                      child:Align(
                          alignment: Alignment.topCenter,
                          child:Container(
                            width: ScreenWidth/1.5-30,
                            height: 60,
                            child:(leadingText=="Done")?DoneBtn:ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black, //background color of button
                                  shape: RoundedRectangleBorder( //to set border radius to button
                                      borderRadius: BorderRadius.circular(5)
                                  ), //content padding inside button
                                ),
                                onPressed: () async {
                                  Position position = await Geolocator.getCurrentPosition();
                                  print(position.longitude); //Output: 80.24599079
                                  print(position.latitude); //Output: 29.6593457
                                  long = position.longitude;
                                  lat = position.latitude;
                                  await getUserLocation(lat,long);
                                  loc=LatLng(lat,long);
                                  newZoom=15.0;
                                  leadingText="Done";
                                  final prefs= await SharedPreferences.getInstance();
                                  prefs.setString('userLocation',userLoc);
                                  prefs.setDouble('userLat',lat);
                                  prefs.setDouble('userLong',long);
                                  setState((){
                                  });
                                },
                                child: Text("${leadingText}",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),)
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
  getUserLocation(double lat,double long) async {//call this async method from whereever you need
    List<Placemark> placemarks =
    await placemarkFromCoordinates(lat,long);

    Placemark place1 = placemarks[0];
    Placemark place2 = placemarks[1];
    userLoc = "${place1.name} ${place2.name} ${place1.subLocality}${place1.subAdministrativeArea} ${place1.postalCode}";

  }
}
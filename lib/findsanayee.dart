import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'sanayeeprofile.dart';
import 'servicecard.dart';
class FindSanayee extends StatefulWidget{

  dynamic category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description;
  FindSanayee(this.category,this.userLoc,this.selectedService,this.selectedMonth,this.selectedDay,this.selectedDayName,this.selectedTime,this.description);
  @override
  State<FindSanayee> createState() => _FindSanayeeState(category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description);
}

class _FindSanayeeState extends State<FindSanayee> {
  dynamic category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description;

  _FindSanayeeState(this.category,this.userLoc,this.selectedService,this.selectedMonth,this.selectedDay,this.selectedDayName,this.selectedTime,this.description);

  List<Marker> markers=[];
  List<Circle> circles=[];
  dynamic lat,long;
  getData() async {
    dynamic snapdata = await FirebaseFirestore.instance.collection("sanayee").get();
    List<dynamic> colores=[
      Colors.blue.withOpacity(0.3),
      Colors.green.withOpacity(0.3)
    ];
    for(int i=0;i<snapdata.docs.length;i++) {
      if(snapdata.docs[i]["status"]=="online"&&snapdata.docs[i]["category"]==category){
        dynamic sanayeeId=snapdata.docs[i]["sanayeeId"];
        markers.add(
            Marker(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Sanayeeprofile(sanayeeId,category,userLoc,selectedService,selectedMonth,selectedDay,selectedDayName,selectedTime,description)));

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
                fillColor: (i%2==0)?colores[0]:colores[1],
                radius: 800,
                strokeWidth: 2,
                strokeColor: Colors.orange
            )
        );
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    long = position.longitude;
    lat = position.latitude;
    setState(() {
      changestate=1;
    });
  }
  int changestate=0;
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    double ScreenWidth= deviceInfo.size.width;
    getData();

    return Scaffold(appBar: AppBar(
      toolbarHeight: 50, // Set this height
      leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,),
        onPressed:() => Navigator.pop(context, false),
      ),
      title: Text("Find Your Sanay3i"),
      backgroundColor: Colors.black,
    ),

        body: Center(
          child: (changestate==0)?null:GoogleMap(
              onMapCreated: (controller) async {

              },
              initialCameraPosition: CameraPosition(
                target: (lat==null)?LatLng(30.04936635347326, 31.23752495928705):LatLng(lat, long),
                zoom: 12,
              ),
              markers:markers.toSet(),
            circles: circles.toSet(),
          ),
        )
    );
  }
}
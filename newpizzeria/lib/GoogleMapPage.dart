import 'dart:core';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapPage extends StatefulWidget {

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {

   GoogleMapController mapController;
   List<MarkerrValue> ListMakrerr = [];

   @override
  void initState() {
    // TODO: implement initState
     ListMakrerr.add(MarkerrValue(lat: 32.034943,Long:35.8607108));
     ListMakrerr.add(MarkerrValue(lat: 32.0160453,Long:35.8512296));
     ListMakrerr.add(MarkerrValue(lat: 32.0334067,Long:35.8742434));
setState(() {
  generateMarkers();

});
    super.initState();
  }
  final LatLng _center = const LatLng(31.995374, 35.8607108);
   List<Marker> _markers = <Marker>[];
   Future<Set<Marker>> generateMarkers() async {
     for(var i =0 ;i<ListMakrerr.length;i++)
       {
         final marker = Marker(
           markerId: MarkerId('Driver Location'),
           position: LatLng(ListMakrerr[i].lat, ListMakrerr[i].Long),

         );
         _markers.add(marker);
       }

     return _markers.toSet();
   }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Marker Demo'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: Container(
          color: Colors.blue,
        ),
      ),
      body:GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,

        ),
        markers: Set<Marker>.of(_markers),
      ),

    );
  }


}
class MarkerrValue
{
  double lat;
  double Long;
  MarkerrValue({this.lat,this.Long});
}
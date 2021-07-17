import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Googlemap extends StatefulWidget {
  @override
  _GooglemapState createState() => _GooglemapState();
}

class _GooglemapState extends State<Googlemap> {
  late GoogleMap mycontroller;
  Position? position;

  @override
  void initState() {
    getcurrentLocation();
    super.initState();
  }

  //fetching the user location
  void getcurrentLocation() async {
    Position res = await Geolocator.getCurrentPosition();
    setState(() {
      position = res;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Map")),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _createmarker(),
        onMapCreated: (controller) {
          mycontroller = controller as GoogleMap;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(position!.latitude, position!.longitude),
          zoom: 12,
        ),
      ),
    );
  }

  Set<Marker> _createmarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("home"),
        position: LatLng(position!.latitude, position!.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Home"),
      ),
    ].toSet();
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Location_Page extends StatefulWidget {
  const Location_Page({Key? key}) : super(key: key);

  @override
  State<Location_Page> createState() => _Location_PageState();
}

class _Location_PageState extends State<Location_Page> {
  double lat = 0.0;
  double log = 0.0;

  Completer<GoogleMapController> mapcontroller = Completer();

  MapType currentMapType = MapType.normal;
  late CameraPosition pposition;

  void onMapCreated(GoogleMapController controller) {
    mapcontroller.complete(controller);
    currentMapType = MapType.satellite;
  }

  liveCoordinates() async {
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        lat = position.latitude;
        log = position.longitude;
        pposition = CameraPosition(
          target: LatLng(lat, log),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Permission.location.request();
    liveCoordinates();
    pposition = CameraPosition(
      target: LatLng(lat, log),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map e = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${e['cname']}",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          liveCoordinates();
          setState(() {
            pposition = CameraPosition(
              target: LatLng(e['lat'], e['log']),
              zoom: 20,
            );
          });
          final GoogleMapController controller = await mapcontroller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(pposition),
          );
        },
        label: Text(
          "Location",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        icon: Icon(
          Icons.location_on_outlined,
          size: 40,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            // SizedBox(
            //   height: 200,
            // ),
            // Image.asset("${e['image']}"),
            Expanded(
              flex: 12,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapcontroller.complete(controller);
                },
                initialCameraPosition: pposition,
                mapType: currentMapType,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

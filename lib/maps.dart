import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Maps extends StatefulWidget {
  final Position pos;

  Maps({
    @required this.pos
  });

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  Position position;

  @override
  void initState() {
    position = widget.pos;
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("home"),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "home",),
      ),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _createMarker(),
          initialCameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15.0,
          ),
        ),
      ),
    );
  }
}
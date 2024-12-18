import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_with_google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: const LatLng(30.550526107874543, 31.011240923996862),
      zoom: 12,
    );
    initMarkers();
    initPolyLines();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            polylines: polylines,
            zoomControlsEnabled: false,
            markers: markers,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              googleMapController = controller;
              initMapStyle();
            },
            // cameraTargetBounds: CameraTargetBounds(
            //   LatLngBounds(
            //     southwest: const LatLng(30.55962380873864, 30.99141298170685),
            //     northeast: const LatLng(30.572778692380112, 31.035787447506287),
            //   ),
            // ),
            initialCameraPosition: initialCameraPosition),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              setState(() {});
              googleMapController.animateCamera(
                CameraUpdate.newLatLng(
                  const LatLng(31.193749161934008, 29.915166145899803),
                ),
                // CameraUpdate.newCameraPosition(
                //   const CameraPosition(
                //     target:
                //         const LatLng(31.193749161934008, 29.915166145899803),
                //     zoom: 12,
                //   ),
                // ),
              );
            },
            child: const Text('Change location'),
          ),
        ),
      ],
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');
    googleMapController.setMapStyle(nightMapStyle);
  }

  // Future<Uint8List> getImageFromRawData(String image, double width) async {
  //   var imageData = await rootBundle.load(image);
  //   var imageCodec = await ui.instantiateImageCodec(
  //       imageData.buffer.asUint8List(),
  //       targetWidth: width.round());
  //   var imageFrameInfo = await imageCodec.getNextFrame();
  //   var imageBytData =
  //       await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);
  //   return imageBytData!.buffer.asUint8List();
  // }

  void initMarkers() async {
    // var customMarkerIcon = BitmapDescriptor.fromBytes(
    //     await getImageFromRawData('assets/images/icons8-marker-50.png', 100));
    var customMarkerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size.fromHeight(250),
        ),
        'assets/images/icons8-marker-50.png');
    var myMarkers = places
        .map(
          (e) => Marker(
            icon: customMarkerIcon,
            infoWindow: InfoWindow(
              title: e.name,
            ),
            position: e.latlng,
            markerId: MarkerId(
              e.id.toString(),
            ),
          ),
        )
        .toSet();

    markers.addAll(myMarkers);
    setState(() {});
    // var myMarker = const Marker(
    //   markerId: const MarkerId('1'),
    //   position: LatLng(30.550526107874543, 31.011240923996862),
    // );
    // markers.add(myMarker);
  }

  void initPolyLines() {
    Polyline polyline = const Polyline(
      width: 5,
      geodesic: true,
      patterns: [PatternItem.dot],
      zIndex: 999,
      color: Colors.red,
      startCap: Cap.roundCap,
      polylineId: PolylineId('1'),
      points: [
        LatLng(30.535284751001363, 30.975396451763366),
        LatLng(30.54924703530867, 31.009091079084364),
        LatLng(30.59796240862012, 31.039924841821506),
        LatLng(30.584280786561106, 30.960138507316124),
      ],
    );
    Polyline polyline2 = const Polyline(
      width: 5,
      color: Colors.teal,
      startCap: Cap.roundCap,
      polylineId: PolylineId('2'),
      points: [
        LatLng(30.500074168969487, 31.01003674945215),
        LatLng(30.611336136282617, 30.983137653971628),
      ],
    );
    polylines.add(polyline);
    polylines.add(polyline2);
  }
}

// world view 0->3
// country view 4->6
// city view 10->12
// street view 13->17
// building view 18->20
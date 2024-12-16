import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
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
}

// world view 0->3
// country view 4->6
// city view 10->12
// street view 13->17
// building view 18->20